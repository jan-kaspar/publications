#include "TFile.h"
#include "TGraphErrors.h"
#include "TH1D.h"

#include <map>

using namespace std;

//----------------------------------------------------------------------------------------------------

TGraphErrors* MakeGraph(TH1D *h)
{
	TGraphErrors *g = new TGraphErrors;

	for (int bi = 1; bi <= h->GetNbinsX(); ++bi) {
		double c = h->GetBinCenter(bi);
		double v = h->GetBinContent(bi);
		double v_u = h->GetBinError(bi);

		if (v == 0. && v_u == 0.)
			continue;

		int idx = g->GetN();
		g->SetPoint(idx, c, v);
		g->SetPointError(idx, 0., v_u);
	}

	return g;
}

//----------------------------------------------------------------------------------------------------

void CalculateB(TGraphErrors *gs, unsigned int points)
{
	char buf[100];
	sprintf(buf, "gB_%i", points);

	TGraphErrors *gB = new TGraphErrors();
	gB->SetName(buf);

	for (int i = points-1; i < gs->GetN(); i++) {
		double S1=0., Sx=0., Sxx=0., Sl=0., Sxl=0.;

		for (unsigned int j = 0; j < points; j++) {
			double x, y, y_e;
			gs->GetPoint(i-j, x, y);
			y_e = gs->GetErrorY(i-j);
			double l = log(y), l_e = y_e / y;

			double w = 1./l_e/l_e;

			S1 += w;
			Sx += w*x;
			Sxx += w*x*x;
			Sl += w*l;
			Sxl += w*x*l;
		}

		double D = S1*Sxx - Sx*Sx;
		double B = -(S1*Sxl - Sx*Sl) / D;
		double Be = sqrt(S1/D);
		double x = Sx/S1;
		double xe = 0.;

		int idx = gB->GetN();
		gB->SetPoint(idx, x, B);
		gB->SetPointError(idx, xe, Be);
	}

	gB->Write();
}

//----------------------------------------------------------------------------------------------------

void CalculateVar(TGraphErrors *gs, unsigned int mode)
{
	char buf[100];
	sprintf(buf, "gB_var");

	TGraphErrors *gB = new TGraphErrors();
	gB->SetName(buf);

	double *X = gs->GetX();
	//double *EX = gs->GetEX();
	double *Y = gs->GetY();
	double *EY = gs->GetEY();

	// default size
	int points = (mode == 1) ? 5 : 12;

	int pi = 0;
	while (pi + points - 1 < gs->GetN()) {
		// update size
		if (mode == 1) {
			if (X[pi] > 0.75)
				points = 6;
		} 
		if (mode == 3) {
			if (X[pi] > 0.18)
				points = 8;
		} 

		// fit B over the range
		double S1=0., Sx=0., Sxx=0., Sl=0., Sxl=0.;
		for (int j = 0; j < points; j++) {
			double x = X[pi+j];
			double y = Y[pi+j];
			double y_e = EY[pi+j];
			double l = log(y), l_e = y_e / y;

			double w = 1./l_e/l_e;

			S1 += w;
			Sx += w*x;
			Sxx += w*x*x;
			Sl += w*l;
			Sxl += w*x*l;
		}

		double D = S1*Sxx - Sx*Sx;
		double B = -(S1*Sxl - Sx*Sl) / D;
		double Be = sqrt(S1/D);
		double x = (X[pi + points - 1] + X[pi]) / 2.;
		double xe = (X[pi + points - 1] - X[pi]) / 2.;
		
		printf("%E, %E\n", D, B);

		// save point
		int idx = gB->GetN();
		gB->SetPoint(idx, x, B);
		gB->SetPointError(idx, xe, Be);

		// shift index
		pi += points-1;
	}

	gB->Write();
}

//----------------------------------------------------------------------------------------------------

void CalculateB_flat(TGraphErrors *gs, double half_width, unsigned int min_points = 3)
{
	char buf[100];
	sprintf(buf, "gB_flat");

	TGraphErrors *gB = new TGraphErrors();
	gB->SetName(buf);
	gB->SetLineColor(2);

	double *X = gs->GetX();
	double *Y = gs->GetY();
	double *EY = gs->GetEY();

	for (int i = 3; i < gs->GetN() - 3; i++)
	{
		unsigned int S1=0;
		double Sw=0., Swx=0., Swxx=0., Swe=0., Swex=0., Sssww=0., Ssswwx=0., Ssswwxx=0.;

		//printf("%E\n", X[i]);
		bool verb = false;
		if (fabs(X[i] - 0.221) < 0.001)
			verb = true;

		for (int j = 0; j < gs->GetN(); j++)
		{
			double w = 1.;

			if (X[j] < 4E-3)
				continue;

			if (fabs(X[j] - X[i]) > half_width)
				continue;

			double x = X[j];
			double eta = log(Y[j]);
			double s = EY[j] / Y[j];	// ucertainty of eta

			if (verb)
			{
				printf("x=%E, y=%E, y_u=%E, eta=%E, eta_u=%E\n", x, Y[j], EY[j], eta, s);
			}

			S1 += 1.;
			Sw += w;
			Swx += w * x;
			Swxx += w * x * x;
			Swe += w * eta;
			Swex += w * eta * x;

			Sssww += s*s * w*w;
			Ssswwx += s*s * w*w * x;
			Ssswwxx += s*s * w*w * x*x;
		}

		double D = Sw * Swxx - Swx * Swx;
		double b = (Sw * Swex - Swx * Swe) / D;
		double b_v = (Swx*Swx*Sssww - 2.*Swx*Sw*Ssswwx + Sw*Sw*Ssswwxx) / D / D;
		double b_s = (b_v > 0.) ? sqrt(b_v) : 0.;

		if (verb)
			printf("\t=> b=%E\n", b);

		if (S1 >= min_points)
		{
			int idx = gB->GetN();
			gB->SetPoint(idx, X[i], -b);
			gB->SetPointError(idx, 0., b_s);
		}
	}
	
	gB->Write();
}

//----------------------------------------------------------------------------------------------------

void CalculateB_gauss(TGraphErrors *gs, double sigma, double min_w, unsigned int min_points = 3)
{
	char buf[100];
	sprintf(buf, "gB_gauss");

	TGraphErrors *gB = new TGraphErrors();
	gB->SetName(buf);
	gB->SetLineColor(4);

	double *X = gs->GetX();
	double *Y = gs->GetY();
	double *EY = gs->GetEY();

	for (int i = 3; i < gs->GetN() - 3; i++)
	{
		unsigned int S1=0;
		double Sw=0., Swx=0., Swxx=0., Swe=0., Swex=0., Sssww=0., Ssswwx=0., Ssswwxx=0.;

		//printf("i = %i, t = %.2E\n", i, X[i]);

		for (int j = 0; j < gs->GetN(); j++)
		{
			double w = exp( -(X[j] - X[i])*(X[j] - X[i]) / 2. / sigma/sigma);

			if (X[j] < 4E-3)
				continue;

			if (w < min_w)
				continue;

			//printf("\tj = %i, t = %.2E, w = %.2E\n", j, X[j], w);

			double x = X[j];
			double eta = log(Y[j]);
			double s = EY[j] / Y[j];	// ucertainty of eta

			S1 += 1.;
			Sw += w;
			Swx += w * x;
			Swxx += w * x * x;
			Swe += w * eta;
			Swex += w * eta * x;

			Sssww += s*s * w*w;
			Ssswwx += s*s * w*w * x;
			Ssswwxx += s*s * w*w * x*x;
		}

		double D = Sw * Swxx - Swx * Swx;
		double b = (Sw * Swex - Swx * Swe) / D;
		double b_v = (Swx*Swx*Sssww - 2.*Swx*Sw*Ssswwx + Sw*Sw*Ssswwxx) / D / D;
		double b_s = (b_v > 0.) ? sqrt(b_v) : 0.;

		if (S1 >= min_points)
		{
			int idx = gB->GetN();
			gB->SetPoint(idx, X[i], -b);
			gB->SetPointError(idx, 0., b_s);
		}
	}
	
	gB->Write();
}

//----------------------------------------------------------------------------------------------------

int main()
{
	map<string, TGraphErrors *> input;

	/*
	TFile *f1 = new TFile("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/publication1_graph.root");
	input["3500GeV,3.5m"] = (TGraphErrors *) f1->Get("g1");
	
	TFile *f3 = new TFile("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/tab_this_pub.root");
	input["3500GeV,90m"] = (TGraphErrors *) f3->Get("g_stat_err");
	*/
	
	TFile *outF = new TFile("calculate_B.root", "recreate");

	TFile *f;
	TGraphErrors *g;
	
	// ---------- 4000GeV,90m ----------
	f = new TFile("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/merged/merged.root");
	g = MakeGraph((TH1D *) f->Get("eb/combined/dsdt"));
	gDirectory = outF->mkdir("4000GeV,90m");
	
	CalculateB(g, 10);
	CalculateB_flat(g, 0.02);
	CalculateB_gauss(g, 0.01, 0.01);

	// ---------- 4000GeV,1000m ----------
	f = new TFile("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/coulomb_analysis/data/merged/combined/fit:2,KL,cen,chisq_st/dsdt.root");
	g = (TGraphErrors *) f->Get("data_diff, final");
	gDirectory = outF->mkdir("4000GeV,1000m");
	
	CalculateB(g, 10);
	CalculateB_flat(g, 0.02);
	CalculateB_gauss(g, 0.01, 0.01);

	delete outF;

	return 0;
}

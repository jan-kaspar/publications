#include "TFile.h"
#include "TGraphErrors.h"

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
	double *EX = gs->GetEX();
	double *Y = gs->GetY();
	double *EY = gs->GetEY();

	// default size
	unsigned int points = (mode == 1) ? 5 : 12;

	unsigned pi = 0;
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
		for (unsigned int j = 0; j < points; j++) {
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

void B()
{
	TFile *f1 = new TFile("publication1_graph.root");
	TGraphErrors *g1 = (TGraphErrors *) f1->Get("g1");
	
	TFile *f3 = new TFile("tab_this_pub.root");
	TGraphErrors *g3 = (TGraphErrors *) f3->Get("g_stat_err");

	TFile *outF = new TFile("B.root", "recreate");

	gDirectory = outF->mkdir("1");
	CalculateB(g1, 2);
	CalculateB(g1, 3);
	CalculateB(g1, 4);
	CalculateB(g1, 5);
	CalculateB(g1, 6);
	
	CalculateVar(g1, 1);
	
	gDirectory = outF->mkdir("3");
	CalculateB(g3, 2);
	CalculateB(g3, 3);
	CalculateB(g3, 4);
	CalculateB(g3, 5);
	CalculateB(g3, 6);
	
	CalculateVar(g3, 3);

	delete outF;
}

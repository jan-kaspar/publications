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
	
	gDirectory = outF->mkdir("3");
	CalculateB(g3, 2);
	CalculateB(g3, 3);
	CalculateB(g3, 4);
	CalculateB(g3, 5);
	CalculateB(g3, 6);

	delete outF;
}

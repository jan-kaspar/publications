#include "TFile.h"
#include "TH1D.h"
#include "TGraphErrors.h"
#include "TCanvas.h"
#include "TF1.h"

#include "common.h"

//----------------------------------------------------------------------------------------------------

void tab_epl_95_hubert()
{
	// get input data
	TFile *inF = new TFile("publication1_graph.root");
	TGraphErrors *g = (TGraphErrors *) inF->Get("g1");

	g->Dump();

	// systematic error data
	double syst_err_t[] = { 0.4, 0.5, 1.5 };
	double syst_err_up[] = { +25., +28., +27. };
	double syst_err_down[] = { -37., -39., -30. };
	TGraph *g_rel_syst_err_up = new TGraph(3, syst_err_t, syst_err_up);
	TGraph *g_rel_syst_err_down = new TGraph(3, syst_err_t, syst_err_down);
	
	// print in TeX format
	for (int i = 0; i < g->GetN(); i++) {
		double x, x_e, y, y_stat_e;
		g->GetPoint(i, x, y);
		x_e = g->GetErrorX(i);
		y_stat_e = g->GetErrorY(i);

		double y_syst_up = g_rel_syst_err_up->Eval(x) / 100. * y;
		double y_syst_down = -g_rel_syst_err_down->Eval(x) / 100. * y;

		before = 1; after = 4; digits = 2;
		//PrintTuple(d.cp, d.cp_e);
		PrintTuple(x, x_e);
		printf(" | ");
		before = 3; after = 4; digits = 2;
		PrintTuple(y*1E3, y_stat_e*1E3, y_syst_up*1E3, y_syst_down*1E3);
		printf(" \\cr\n");
	}
}

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
	
	TFile *inF_h = new TFile("publication1.root");
	TH1D *h = (TH1D *) inF_h->Get("h_dsdt");

	// systematic error data
	double syst_err_t[] = { 0.4, 0.5, 1.5 };
	double syst_err_up[] = { +25., +28., +27. };
	double syst_err_down[] = { -37., -39., -30. };
	TGraph *g_rel_syst_err_up = new TGraph(3, syst_err_t, syst_err_up);
	TGraph *g_rel_syst_err_down = new TGraph(3, syst_err_t, syst_err_down);

	map<unsigned int, BinData> binData;
	
	// print in TeX format
	for (int i = 0; i < g->GetN(); i++) {
		double x, x_e, y, y_stat_e;
		g->GetPoint(i, x, y);
		x_e = g->GetErrorX(i);
		y_stat_e = g->GetErrorY(i);

		if (x < 0.377)
			continue;

		double y_syst_up = g_rel_syst_err_up->Eval(x) / 100. * y;
		double y_syst_down = -g_rel_syst_err_down->Eval(x) / 100. * y;

		int h_idx = h->FindBin(x);
		double le = h->GetBinLowEdge(h_idx);
		double he = le + h->GetBinWidth(h_idx);

		BinData bd(le, he, x, x_e, y, y_stat_e, 0.);
		bd.v_syst_e_up = y_syst_up;
		bd.v_syst_e_down = y_syst_down;
		binData[i] = bd;

		//printf("%3i : ", i);

		before = 1; after = 3; digits = 1;
		//PrintTuple(d.cp, d.cp_e);
		//PrintTuple(x, x_e);
		printf("$%.3f$ & $%.3f$", x, x_e);

		printf(" | ");

		//before = 3; after = 4; digits = 1;

		if (i < 15) {
			before = 3; after = 4; deci = 0;
		}
		if (i >= 15) {
			before = 3; after = 4; deci = 1;
		}
		if (i >= 69) {
			before = 3; after = 4; deci = 2;
		}
		if (i >= 77) {
			before = 3; after = 4; deci = 3;
		}

		after = 3;
		
		PrintTuple2(y*1E3, y_stat_e*1E3, y_syst_up*1E3, y_syst_down*1E3);

		printf(" \\cr\n");
	}
	
	// print in Durham format
	printf(
"           xlow"
"          xhigh"
"         xfocus"
"     xfocus_err"
"              y"
"         +-stat"
"           +sys"
"           -sys"
"\n");
	for (map<unsigned int, BinData>::iterator it = binData.begin(); it != binData.end(); ++it) {
		const BinData &d = it->second;

		printf("%+15.5E%+15.5E%+15.5E%+15.5E%+15.5E%+15.5E%+15.5E%+15.5E\n",
			d.bLow, d.bHigh, d.cp, d.cp_e, d.v, d.v_stat_e, d.v_syst_e_up, d.v_syst_e_down);
	}
}

#include "TFile.h"
#include "TH1D.h"
#include "TGraphErrors.h"
#include "TCanvas.h"
#include "TF1.h"

#include "common.h"

//----------------------------------------------------------------------------------------------------

TGraph *g_rel_syst_err_up;
TGraph *g_rel_syst_err_down;

double GetRelativeSystematicError(double t)
{
	return g_rel_syst_err->Eval(t);
}

//----------------------------------------------------------------------------------------------------

void tab_epl_95()
{
	// get input data
	TFile *inF = new TFile("publication1.root");
	TH1D *h = (TH1D *) inF->Get("h_dsdt");
	
	// output file
	TFile *outF = new TFile("tab_epl_95.root", "recreate");

	// initialize fit functions
	vector<TF1 *> fits;

	TF1 *ff1 = new TF1("ff1", "exp([0] + [1]*x) + pow(x, [2]) * exp([3] + [4]*x + [5]*x*x + [6]*x*x*x + [7]*x*x*x*x)", 0., 4.);
	ff1->SetParameters(7.915, -25.017, 49.97, 85.83, -141.47, 68.38, -19.52, +2.26);
	fits.push_back(ff1);
	
	TF1 *ff2 = new TF1("ff2", "exp([0] + [1]*x) + exp([2] + [3]*x) - [4] * exp(- (x - [5])^2 / [6])", 0., 4.);
	ff2->SetParameters(7.14, -23.007, -0.113, -4.40, 0.201, 0.259, 0.00757);
	fits.push_back(ff2);
	
	// make fits
	for (unsigned int i = 0; i < fits.size(); i++) {
		TF1 *f = fits[i];
		printf("* fitting function %i (%s)\n", i, f->GetName());

		h->Fit(f, "QN", "", 0.36, 2.7);
		h->Fit(f, "QN", "", 0.36, 2.7);
		h->Fit(f, "QIN", "", 0.36, 2.7);
		h->Fit(f, "IN", "", 0.36, 2.7);

		printf("\tpoints %i, chi^2/ndf = %.2E\n", f->GetNumberFitPoints(), f->GetChisquare() / f->GetNDF());
	}
	
	// draw fits
	int colors[] = {2, 4, 8, 6, 10};
	TCanvas *fc = new TCanvas();
	fc->SetName("fits");
	fc->SetLogy(1);
	h->Draw();
	
	for (unsigned int i = 0; i < fits.size(); i++) {
		fits[i]->SetLineColor(colors[i]);
		fits[i]->Draw("same");
	}
	fc->Write();
	
	// graph with representative points errors
	TGraphErrors *g_stat_err = new TGraphErrors(); g_stat_err->SetName("g_stat_err");
	TGraphErrors *g_syst_err = new TGraphErrors(); g_syst_err->SetName("g_syst_err");

	// calculate representative points and errors
	map<unsigned int, BinData> binData;
	for (int i = 1; i <= h->GetNbinsX(); i++) {
		// get data from histogram
		double v = h->GetBinContent(i);
		double v_stat_e = h->GetBinError(i);
		double c = h->GetBinCenter(i);
		double le = h->GetBinLowEdge(i);
		double he = le + h->GetBinWidth(i);
		
		// select bins
		if (c < 0.36 || c > 2.5)
			continue;

		printf("* bin %i\n", i);
		printf("\t%.3f to %.3f\n", le, he);

		// determine representative point and its uncertainty
		vector<double> cps, uncs;
		for (unsigned int fi = 0; fi < fits.size(); fi++) {
			printf("\tfit %i\n", fi);
			printf("\t\tcenter = %.3f\n", (he+le)/2.);

			double mean = fits[fi]->Integral(le, he) / (he - le);
			double cp_s = Solve(fits[fi], mean, le, he);
			printf("\t\tcp = %.3f\n", cp_s);
			
			double cp_n = SolveNewton(fits[fi], mean, le, he);
			printf("\t\tcp_n = %.3f\n", cp_n);

			printf("\t\tcp_s - cp_n = %.1E\n", cp_s - cp_n);

			double cp_rep, cp_mean, cp_unc;
			SolveUncertainty(fits[fi], le, he, cp_rep, cp_mean, cp_unc, (i == 63 && fi == 1));
			printf("\t\trep = %.1E, mean = %.3f, std. dev. = %.2E\n", cp_rep, cp_mean, cp_unc);

			cps.push_back(cp_n);
			uncs.push_back(cp_unc);
		}

		double cp = (cps[1] + cps[0]) / 2.;
		printf("\tcp f2-f1 = %.2E\n", cps[1] - cps[0]);
		printf("\tdev mean = %.2E\n", (uncs[1] + uncs[0])/2.);

		double cp_e = sqrt(pow(cps[1] - cps[0], 2.) + pow((uncs[1] + uncs[0])/2., 2.));
		printf("\tunc = %.2E\n", cp_e);

		// systematic error
		double v_syst_e = v * GetRelativeSystematicError(cp);

		// fill graphs

		// fill in data
		binData[i] = BinData(cp, cp_e, v, v_stat_e, v_syst_e);
	}
	
	// write graphs
	g_stat_err->Write();
	g_syst_err->Write();
	
	// print in TeX format
	for (map<unsigned int, BinData>::iterator it = binData.begin(); it != binData.end(); ++it) {
		const BinData &d = it->second;

		before = 1; after = 3; digits = 3;
		//PrintTuple(d.cp, d.cp_e);
		PrintTuple(d.cp);
		printf(" & ");
		before = 3; after = 4; digits = 2;
		PrintTuple(d.v*1E3, d.v_stat_e*1E3, d.v_syst_e*1E3);
		printf("\n");
	}

	delete outF;
}

#include "TFile.h"
#include "TH1D.h"
#include "TGraphErrors.h"
#include "TCanvas.h"
#include "TF1.h"

#include "common.h"

//----------------------------------------------------------------------------------------------------

TGraph *g_rel_syst_err;

double GetRelativeSystematicError(double t)
{
	return g_rel_syst_err->Eval(t) / 100.;
}

//----------------------------------------------------------------------------------------------------

void tab_this_pub()
{
	// get input data
	TFile *inF = new TFile("dataset_cmp.root");
	TH1D *h = (TH1D*) inF->Get("h_avg");

	// systematic error data
	double syst_err_t[] = { 0.005, 0.01, 0.06, 0.1, 0.12, 0.16, 0.2, 0.3, 0.4};
	double syst_err_v[] = { 4.5, 4.3, 4.2, 4.3, 4.3, 5.1, 6.1, 9.3, 12.9 };
	g_rel_syst_err = new TGraph(9, syst_err_t, syst_err_v);
	
	// output file
	TFile *outF = new TFile("tab_this_pub.root", "recreate");

	// initialize fit functions
	vector<TF1 *> fits;
	TF1 *ff2 = new TF1("ff2", "exp([0] + [1]*x + [2]*x*x)");
	fits.push_back(ff2);
	TF1 *ff3 = new TF1("ff3", "[0]*exp([1]*x + [2]*x*x + [3]*x*x*x)");
	fits.push_back(ff3);
	
	// make fits
	for (unsigned int i = 0; i < fits.size(); i++) {
		TF1 *f = fits[i];
		printf("* fitting function %i (%s)\n", i, f->GetName());

		h->Fit(f, "QN", "", 0., 0.47);
		h->Fit(f, "QN", "", 0., 0.47);
		h->Fit(f, "QIN", "", 0., 0.47);
		h->Fit(f, "IN", "", 0., 0.47);

		printf("\tpoints %i, chi^2/ndf = %.2E\n", f->GetNumberFitPoints(), f->GetChisquare() / f->GetNDF());
		f->Write();
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
		if (c > 0.45 || v == 0.)
			continue;
		
		printf("* bin %i\n", i);
		printf("\tfrom %.3f to %.3f, center = %.3f\n", le, he, (he+le)/2.);

		// determine representative point and its uncertainty
		vector<double> cps, uncs;
		for (unsigned int fi = 0; fi < fits.size(); fi++) {

			double mean = fits[fi]->Integral(le, he) / (he - le);
			double cp_s = Solve(fits[fi], mean, le, he);
			
			double cp_n = SolveNewton(fits[fi], mean, le, he);

			double cp_rep, cp_mean, cp_unc;
			SolveUncertainty(fits[fi], le, he, cp_rep, cp_mean, cp_unc, (i == 63 && fi == 1));
			
			printf("\tfit %i: cp_s = %.3f, cp_n = %.3f | rep = %.1E, mean = %.3f, std. dev. = %.2E\n",
				fi, cp_s, cp_n, cp_rep, cp_mean, cp_unc);

			cps.push_back(cp_n);
			uncs.push_back(cp_unc);
		}

		// analytic calculation

		double B = 19.45;
		double ff1_cp = -1./B * log((exp(-B*le) - exp(-B*he))/B / (he - le));
		
		B += 0.06; // B += 1 sigma (statistical)
		//B += 0.27; // B += 1 sigma (systematic)
		double ff1_cp_sp = -1./B * log((exp(-B*le) - exp(-B*he))/B / (he - le));
		double ff1_cp_si = fabs(ff1_cp_sp - ff1_cp);
		cps.push_back(ff1_cp);
		uncs.push_back(ff1_cp_si);

		printf("\tresult collection:\n");
		double S1=0, Sc=0, Se=0, Scc=0;
		for (unsigned int ri = 0; ri < cps.size(); ri++) {
			printf("\t\t%u: cp = %.3f +- %.2E\n", ri, cps[ri], uncs[ri]);
			S1++;
			Sc += cps[ri];
			Scc += cps[ri] * cps[ri];
			Se += uncs[ri];
		}

		double cp = Sc/S1;
		double cp_mean_e = Se/S1;
		double cp_var = (Scc - Sc*Sc/S1) / S1;
		double cp_stddev = sqrt(cp_var);
		double cp_e = (cp_mean_e + cp_stddev) / 2.;
		printf("\tcp mean = %.3f, cp_stddev = %.2E, cp_unc mean = %.2E, cp_unc = %.2E = %.2E (rel)\n",
			cp, cp_stddev, cp_mean_e, cp_e, cp_e / cp);
		
		// systematic error
		double v_syst_e = v * GetRelativeSystematicError(cp);

		// fill graphs
		int idx = g_stat_err->GetN();
		g_stat_err->SetPoint(idx, cp, v);
		g_stat_err->SetPointError(idx, cp_e, v_stat_e);
		g_syst_err->SetPoint(idx, cp, v);
		g_syst_err->SetPointError(idx, cp_e, v_syst_e);

		/*
			printf("* bin %3u | from %.3f to %.3f | cp = %.3f +- %.1E | %.2E +- %.2E (stat) +- %.2E (syst)\n",
				i, le, he, cp, ff1_cp_si, v, v_stat_e, v_syst_e);
				*/
		
		// fill in data
		binData[i] = BinData(cp, cp_e, v, v_stat_e, v_syst_e);
	}

	// write graphs
	g_stat_err->Write();
	g_syst_err->Write();
	
	// print in TeX format
	for (map<unsigned int, BinData>::iterator it = binData.begin(); it != binData.end(); ++it) {
		const BinData &d = it->second;

		before = 1; after = 5; digits = 3;
		//PrintTuple(d.cp, d.cp_e);
		PrintTuple(d.cp);
		printf(" & ");
		before = 3; after = 4; digits = 2;
		PrintTuple(d.v, d.v_stat_e, d.v_syst_e);
		printf("\n");
	}

	delete outF;
}

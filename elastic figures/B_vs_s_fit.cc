#include "TGraphErrors.h"
#include "TFile.h"
#include "TF1.h"
#include "TCanvas.h"
#include "TMinuit.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"

#include "TRandom2.h"

#include "stat.h"

//----------------------------------------------------------------------------------------------------

TGraphErrors *g = NULL;

void AddPoint(double W, double B, double B_e)
{
	int idx = g->GetN();
	g->SetPoint(idx, W, B);
	g->SetPointError(idx, 0., B_e);
}

//----------------------------------------------------------------------------------------------------

int main()
{
	TFile *f_out = TFile::Open("B_vs_s_fit.root", "recreate");

	g = new TGraphErrors();
	g->SetName("g_B_vs_s");

	AddPoint(  23.6, 11.80, 0.30);
	AddPoint(  30.8, 12.30, 0.30);
	AddPoint(  45.0, 12.80, 0.30);
	AddPoint(  53.2, 13.10, 0.30);
	AddPoint(  63.2, 13.30, 0.30);
	AddPoint(  21.5, 11.57, 0.03);
	AddPoint(  30.8, 11.87, 0.28);
	AddPoint(  44.9, 12.87, 0.20);
	AddPoint(  48.0, 12.40, 0.30);
	AddPoint(  23.5, 11.80, 0.30);
	AddPoint(  30.6, 12.20, 0.30);
	AddPoint(  30.4, 12.70, 0.50);
	AddPoint(  52.8, 12.87, 0.14);
	AddPoint(  52.6, 13.03, 0.52);
	AddPoint(  62.3, 13.02, 0.27);
	AddPoint(  62.3, 13.47, 0.52);
	AddPoint(  52.8, 13.09, 0.58);
	AddPoint(  52.8, 13.92, 0.59);
	AddPoint( 540.0, 13.30, 1.50);
	AddPoint( 540.0, 13.70, 0.30);
	AddPoint( 546.0, 15.50, 0.80);
	AddPoint( 541.0, 15.52, 0.07);
	AddPoint( 546.0, 15.35, 0.19);
	AddPoint(1800.0, 16.98, 0.25);
	AddPoint(1800.0, 16.99, 0.47);
	AddPoint(1020.0, 16.20, 1.00);
	AddPoint(1960.0, 16.54, 0.90);
	AddPoint( 200.0, 16.30, 1.84);

	AddPoint(2760.0, 17.10, 0.20);

	/*
	AddPoint(7000.0, 19.73, 0.29);
	AddPoint(7000.0, 19.90, 0.26);
	AddPoint(8000.0, 19.74, 0.24);
	AddPoint(8000.0, 19.90, 0.30);
	*/

	// make fit
	TF1 *ff = new TF1("ff", "[0] + [1]*log(x*x)");
	ff->SetRange(2E1, 1E5);
	g->Fit(ff, "", "");

	g->Write();

	double cov_mat_data[2*2];
	gMinuit->mnemat(&cov_mat_data[0], 2);
	TMatrixDSym cov_mat(2);
	cov_mat.SetMatrixArray(cov_mat_data);

	// build generator matrix
	TMatrixDSymEigen eig_decomp(cov_mat);
	TVectorD eig_values(eig_decomp.GetEigenValues());
	TMatrixDSym S(2);
	for (unsigned int i = 0; i < 2; i++)
		S(i, i) = (eig_values(i) >= 0.) ? sqrt(eig_values(i)) : 0.;
	auto gen_mat = eig_decomp.GetEigenVectors() * S;

	// define grid of s values
	vector<double> values_W;
	for (double sqrt_s = 1E1; sqrt_s < 2E5; sqrt_s *= 1.05)
		values_W.push_back(sqrt_s);

	// evaluate fit
	TGraph *g_cen_val = new TGraph();
	for (unsigned int si = 0; si < values_W.size(); si++)
	{
		const double W = values_W[si];
		const double s = W*W;

		int idx = g_cen_val->GetN();
		g_cen_val->SetPoint(idx, W, ff->Eval(W));
	}
	g_cen_val->Write("g_cen_val");
	// evaluate uncertainty
	gRandom = new TRandom2();
	gRandom->SetSeed(1);

	vector<Stat> stat(values_W.size(), Stat(1));

	for (unsigned int ci = 0; ci < 10000; ci++)
	{
		// generate model parameter errors
		TVectorD de(2);
		for (unsigned int i = 0; i < 2; i++)
			de(i) = gRandom->Gaus();
		TVectorD de_P = gen_mat * de;

		// get model with biased parameters;
		TF1 *ff_bias = new TF1(*ff);
		for (unsigned int pi = 0; pi < 2; pi++)
			ff_bias->SetParameter(pi, ff_bias->GetParameter(pi) + de_P(pi));

		for (unsigned int si = 0; si < values_W.size(); si++)
		{
			const double W = values_W[si];
			stat[si].Fill(ff_bias->Eval(W) - ff->Eval(W));
		}

		delete ff_bias;
	}

	// build graphs
	TGraph *g_unc_mean = new TGraph();
	TGraph *g_unc_stddev = new TGraph();
	TGraph *g_band_up = new TGraph();
	TGraph *g_band_dw = new TGraph();

	for (unsigned int si = 0; si < values_W.size(); si++)
	{
		const double W = values_W[si];

		const double cen = ff->Eval(W);

		int idx = g_unc_mean->GetN();

		g_unc_mean->SetPoint(idx, W, stat[si].GetMean(0));
		g_unc_stddev->SetPoint(idx, W, stat[si].GetStdDev(0));
		g_band_up->SetPoint(idx, W, cen + stat[si].GetMean(0) + stat[si].GetStdDev(0));
		g_band_dw->SetPoint(idx, W, cen + stat[si].GetMean(0) - stat[si].GetStdDev(0));
	}

	g_unc_mean->Write("g_unc_mean");
	g_unc_stddev->Write("g_unc_stddev");
	g_band_up->Write("g_band_up");
	g_band_dw->Write("g_band_dw");

	delete f_out;

	return 0;
}

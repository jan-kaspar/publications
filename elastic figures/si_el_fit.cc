#include "TFile.h"
#include "TGraphErrors.h"
#include "TF1.h"
#include "TCanvas.h"
#include "TMinuit.h"
#include "TMatrixDSym.h"
#include "TMatrixDSymEigen.h"

#include "TRandom2.h"

#include "stat.h"

//----------------------------------------------------------------------------------------------------

TGraphErrors *g = NULL;

void AddPoint(double W, double si, double si_e)
{
	int idx = g->GetN();
	g->SetPoint(idx, W, si);
	g->SetPointError(idx, 0., si_e);
}

//----------------------------------------------------------------------------------------------------

int main()
{
	TFile *f_out = TFile::Open("si_el_fit.root", "recreate");

	g = new TGraphErrors();
	g->SetName("g_si_el_vs_s");

	// input
	AddPoint(1.154E+01, 7.3, 0.47);
	AddPoint(1.154E+01, 6.4, 1);
	AddPoint(1.376E+01, 7.39, 0.36);
	AddPoint(1.376E+01, 7.8, 0.6);
	AddPoint(1.626E+01, 7.52, 0.6);
	AddPoint(1.817E+01, 7.12, 0.52);
	AddPoint(3.04E+01, 7.16, 0.445);
	AddPoint(5.26E+01, 7.44, 0.437);
	AddPoint(5.28E+01, 7.89, 0.203);
	AddPoint(6.23E+01, 7.46, 0.438);
	AddPoint(5.46E+02, 12.87, 0.3);
	AddPoint(5.47E+02, 13.3, 0.615);
	AddPoint(1.8E+03, 15.79, 0.87);
	AddPoint(1.8E+03, 19.7, 0.85);
	AddPoint(1.8E+03, 16.6, 1.6);
	AddPoint(1.019E+01, 7.23, 0.276);
	AddPoint(1.043E+01, 7.21, 0.271);
	AddPoint(1.052E+01, 7.49, 0.08);
	AddPoint(1.069E+01, 6.6, 0.7);
	AddPoint(1.071E+01, 7.25, 0.273);
	AddPoint(1.1E+01, 6.89, 0.257);
	AddPoint(1.122E+01, 7.07, 0.263);
	AddPoint(1.147E+01, 6.86, 0.256);
	AddPoint(1.152E+01, 6.86, 0.26);
	AddPoint(1.154E+01, 7.41, 0.31);
	AddPoint(1.154E+01, 7.1, 0.2);
	AddPoint(1.376E+01, 7.07, 0.35);
	AddPoint(1.376E+01, 7.08, 0.09);
	AddPoint(1.39E+01, 6.9, 1);
	AddPoint(1.626E+01, 7, 0.28);
	AddPoint(1.666E+01, 6.85, 0.24);
	AddPoint(1.683E+01, 6.97, 0.11);
	AddPoint(1.817E+01, 7.06, 0.28);
	AddPoint(1.942E+01, 6.87, 0.13);
	AddPoint(1.942E+01, 6.95, 0.08);
	AddPoint(1.966E+01, 6.92, 0.44);
	AddPoint(1.966E+01, 6.92, 0.44);
	AddPoint(2.17E+01, 6.78, 0.23);
	AddPoint(2.35E+01, 6.7, 0.3);
	AddPoint(2.35E+01, 6.82, 0.08);
	AddPoint(2.35E+01, 6.8, 0.36);
	AddPoint(2.35E+01, 6.81, 0.332);
	AddPoint(2.376E+01, 7.29, 0.16);
	AddPoint(2.376E+01, 7.89, 0.52);
	AddPoint(2.388E+01, 7.2, 0.4);
	AddPoint(3.04E+01, 6.8, 0.6);
	AddPoint(3.06E+01, 6.9, 0.4);
	AddPoint(3.06E+01, 7.39, 0.08);
	AddPoint(3.06E+01, 7, 0.361);
	AddPoint(3.06E+01, 6.75, 0.319);
	AddPoint(4.49E+01, 7.45, 0.08);
	AddPoint(4.49E+01, 7.5, 0.424);
	AddPoint(5.28E+01, 7.79, 0.17);
	AddPoint(5.28E+01, 7.56, 0.08);
	AddPoint(5.28E+01, 7.6, 0.422);
	AddPoint(5.28E+01, 7.17, 0.301);
	AddPoint(6.23E+01, 7.51, 0.355);
	AddPoint(6.25E+01, 7.77, 0.1);

	AddPoint(2.76e3, 21.8, 1.4);
	
	AddPoint(7e3, 25.43, 1.07);
	AddPoint(7e3, 25.1, 1.1);

	AddPoint(8e3, 27.1, 1.4);

	AddPoint(13e3, 31.535, 1.5);

	// make fit
	TF1 *ff = new TF1("ff", "[0] + [1]*log(x*x) + [2]*log(x*x)*log(x*x)");
	ff->SetParameters(11.7, -1.59, 0.134);
	ff->SetRange(1E1, 1E5);
	g->Fit(ff, "", "");

	g->Write();
	ff->Write();

	double cov_mat_data[3*3];
	gMinuit->mnemat(&cov_mat_data[0], 3);
	TMatrixDSym cov_mat(3);
	cov_mat.SetMatrixArray(cov_mat_data);

	// build generator matrix
	TMatrixDSymEigen eig_decomp(cov_mat);
	TVectorD eig_values(eig_decomp.GetEigenValues());
	TMatrixDSym S(3);
	for (unsigned int i = 0; i < 3; i++)
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

	for (unsigned int ci = 0; ci < 100000; ci++)
	{
		// generate model parameter errors
		TVectorD de(3);
		for (unsigned int i = 0; i < 3; i++)
			de(i) = gRandom->Gaus();
		TVectorD de_P = gen_mat * de;

		// get model with biased parameters;
		TF1 *ff_bias = new TF1(*ff);
		for (unsigned int pi = 0; pi < 3; pi++)
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

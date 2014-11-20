#include "TFile.h"
#include "TGraphErrors.h"
#include "TH1D.h"
#include "TF1.h"

//----------------------------------------------------------------------------------------------------

TF1 *ff;

void MakeFit(const string &comb, const string &quant, double x1, double x2, double x3, double x4)
{
	TDirectory *d_out = gDirectory;

	TFile *f_in = new TFile(("../analysis/background_studies/DS4/"+comb+"/distributions_45t_56b.root").c_str());
	TH1D *h_in = (TH1D *) f_in->Get(("elastic cuts/"+quant).c_str());
	
	gDirectory = d_out;

	TGraphErrors *g = new TGraphErrors();
	g->SetName((comb).c_str());

	for (int i = 1; i <= h_in->GetNbinsX(); i++)
	{
		double c = h_in->GetBinCenter(i);
		double v = h_in->GetBinContent(i);
		double u = h_in->GetBinError(i);

		if ((x1 < c && c < x2) || (x3 < c && c < x4))
		{
			int idx = g->GetN();
			g->SetPoint(idx, c, v);
			g->SetPointError(idx, 0., u);
		}
	}

	ff->SetParameters(1., 1., 0., (x3 - x1) / 3.);
	ff->FixParameter(2, 0.);
	g->Fit(ff, "W");
	ff->ReleaseParameter(2);
	g->Fit(ff, "W");

	g->Write();
	g->Draw("ap");

	delete f_in;
}


//----------------------------------------------------------------------------------------------------

void background_fits()
{
	ff = new TF1("ff", "[0] + [1] * exp(-(x - [2])^2 / (2*[3]^2))");

	TFile *f_out = new TFile("background_fits.root", "recreate");

	MakeFit("cuts:2,5,6,7", "cut 1/h_cq1", -200E-6, -80E-6, +80E-6, 200E-6);
	
	MakeFit("cuts:1,5,6,7", "cut 2/h_cq2", -50E-6, -20E-6, +20E-6, 50E-6);
	
	MakeFit("cuts:1,2,5,6", "cut 7/h_cq7", -200E-3, -70E-3, +70E-3, 200E-3);
	

	delete f_out;
}

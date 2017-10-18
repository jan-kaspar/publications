#include "TFile.h"
#include "TGraphErrors.h"
#include "TF1.h"
#include "TCanvas.h"

//----------------------------------------------------------------------------------------------------

TGraphErrors *g = NULL;

void AddPoint(double W, double si, double si_e)
{
	int idx = g->GetN();
	g->SetPoint(idx, W, si);
	g->SetPointError(idx, 0., si_e);
}

//----------------------------------------------------------------------------------------------------

int si_el_fit()
{
	TFile *f_out = TFile::Open("si_el_fit.root", "recreate");

	g = new TGraphErrors();
	g->SetName("g_si_el_vs_s");

	// PDG points
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

	TF1 *ff = new TF1("ff", "[0] + [1]*log(x*x) + [2]*log(x*x)*log(x*x)");
	ff->SetParameters(11.7, -1.59, 0.134);
	ff->SetRange(1E1, 1E5);
	g->Fit(ff, "", "");

	g->Write();
	ff->Write();

	TCanvas *c = new TCanvas();
	c->SetLogx(1);
	g->Draw("ap");

	return 0;
}

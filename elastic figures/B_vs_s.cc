#include "TGraphErrors.h"
#include "TFile.h"
#include "TF1.h"
#include "TCanvas.h"

//----------------------------------------------------------------------------------------------------

TGraphErrors *g = NULL;

void AddPoint(double W, double B, double B_e)
{
	int idx = g->GetN();
	g->SetPoint(idx, W, B);
	g->SetPointError(idx, 0., B_e);
}

//----------------------------------------------------------------------------------------------------

void B_vs_s()
{
	TFile *f_out = TFile::Open("B_vs_s.root", "recreate");

	g = new TGraphErrors();
	g->SetName("B_vs_s");

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

	AddPoint(7000.0, 19.73, 0.29);
	AddPoint(7000.0, 19.90, 0.26);
	AddPoint(8000.0, 19.74, 0.24);
	AddPoint(8000.0, 19.90, 0.30);

	TF1 *ff = new TF1("ff", "[0] + [1]*log(x)");
	ff->SetRange(2E1, 2E3);
	g->Fit(ff, "", "", 2E1, 2E3);

	g->Write();

#if 0
	TF1 *ff = new TF1("ff", "(1 - TMath::Erf((log(x)-[4])/[5]))/2 * ([0] + [1]*log(x))  +  (1 + TMath::Erf((log(x)-[4])/[5]))/2 * ([0]+[1]*[4] + 0*[2] + [3]*(log(x)-[4]))");
	ff->SetRange(1E1, 1E4);
	ff->SetParameters(8.0, 1.2, -4.0, 2.7);

	ff->FixParameter(2, 0.);

	ff->FixParameter(4, log(2760));
	ff->FixParameter(5, 0.1);

	g->Fit(ff);

	TF1 *ff_low_e = new TF1("ff_low_e", "[0] + [1]*log(x)");
	ff_low_e->SetRange(1E1, 1E4);
	ff_low_e->SetParameters(ff->GetParameter(0), ff->GetParameter(1));
	ff_low_e->SetLineColor(4);
	ff_low_e->SetLineStyle(2);

	TF1 *ff_high_e = new TF1("ff_high_e", "[0] + [1]*log(x)");
	ff_high_e->SetRange(1E1, 1E4);
	ff_high_e->SetParameters(ff->GetParameter(0) + (ff->GetParameter(1)-ff->GetParameter(3))*ff->GetParameter(4), ff->GetParameter(3));
	ff_high_e->SetLineColor(8);
	ff_high_e->SetLineStyle(2);

	TCanvas *c = new TCanvas();
	c->SetLogx(1);
	g->SetMarkerStyle(20);
	g->Draw("ap");
	//ff->Draw("same");
	ff_low_e->Draw("same");
	ff_high_e->Draw("same");

	g->Write();
#endif

	delete f_out;
}

#include "TFile.h"
#include "TGraph.h"

class Model2017
{
	double H1 = 0.24964;
	double H2 = -0.31854;
	double H3 = 30.012;
	double O1 = -0.05098;
	double O2 = 1.0240;
	double O3 = -4.9110;
	double al_pl_0 = 0.62957;
	double C_R_pl = 47.292;
	double al_mi_0 = 0.26530;
	double C_R_mi = 36.113;

	double m = 0.938;	// GeV

  public:

	Model2017()
	{
	}

	double si_tot_pp(double s) const;

	double si_tot_rho_pp(double s) const;
};

//----------------------------------------------------------------------------------------------------

double Model2017::si_tot_pp(double s) const
{
	const double z = (s - 2.*m*m) / (2.*m*m);

	const double f = (1. - 2.*m*m/s) / sqrt(1. - 4.*m*m/s);

	const double S = H1 * log(z)*log(z) + (H2 - M_PI*O1) * log(z) + H3 - H1*M_PI*M_PI/4. - O2*M_PI/2.
		+ C_R_pl*pow(z, al_pl_0-1.)*sin(M_PI/2.*al_pl_0) - C_R_mi*pow(z, al_mi_0-1.)*cos(M_PI/2.*al_mi_0);

	return f * S;
}

//----------------------------------------------------------------------------------------------------

double Model2017::si_tot_rho_pp(double s) const
{
	const double z = (s - 2.*m*m) / (2.*m*m);

	//const double f = (1. - 2.*m*m/s) / (2.*m*m) / sqrt(1. - 4.*m*m/s);
	const double f = (1. - 2.*m*m/s) / sqrt(1. - 4.*m*m/s);

	const double S = O1*log(z)*log(z) + (O2 + M_PI*H1)*log(z) + O3 - O1*M_PI*M_PI/4. + H2*M_PI/2.
		- C_R_pl*pow(z, al_pl_0-1.)*cos(M_PI/2.*al_pl_0) - C_R_mi*pow(z, al_mi_0-1.)*sin(M_PI/2.*al_mi_0);

	return f * S;
}

//----------------------------------------------------------------------------------------------------

int main()
{
	TFile *f_out = TFile::Open("model_2017.root", "recreate");

	Model2017 model;

	TGraph *g_si_tot_pp_vs_s = new TGraph();
	TGraph *g_rho_pp_vs_s = new TGraph();

	for (double W = 1E1; W <= 1E5; W *= 1.1)
	{
		const double s = W*W;

		const double si_tot_pp = model.si_tot_pp(s);
		const double rho_pp = model.si_tot_rho_pp(s) / si_tot_pp;

		int idx = g_si_tot_pp_vs_s->GetN();
		g_si_tot_pp_vs_s->SetPoint(idx, W, si_tot_pp);
		g_rho_pp_vs_s->SetPoint(idx, W, rho_pp);
	}

	g_si_tot_pp_vs_s->Write("g_si_tot_pp_vs_s");
	g_rho_pp_vs_s->Write("g_rho_pp_vs_s");

	delete f_out;
}

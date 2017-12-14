#include "TFile.h"
#include "TGraph.h"
#include "TComplex.h"
#include "TMath.h"

/**
 * Model of elastic pp scattering by Gauron, Nicolescu, Leader et al.
 * 
 * References:
 *	[1] arXiv:hep-ph/0607089v4
 **/
class Model2007
{
	/// parameters of F_H_pl
	double H_1, b_1_pl, H_2, b_2_pl, H_3, b_3_pl, K_pl;

	/// parameters of Odderon
	double O_1, b_1_mi, O_2, b_2_mi, O_3, b_3_mi, K_mi;

	struct Singularity
	{
		double al_0, C, be, al_p;
	};

	Singularity s_P, s_PP, s_O, s_OP, s_R_pl, s_R_mi, s_RP_pl, s_RP_mi;

	double s0 = 1.;		// GeV^2

  public:

	Model2007();

	// crossing-even amplitude, according to Eq. (23)
	TComplex F_pl_0(double s) const;

	// crossing-odd amplitude, according to Eq. (38)
	TComplex F_mi_0(double s) const;

	// amplitude at t = 0, according to Eq. (39)
	TComplex Amp0_pp(double s) const
	{
		return F_pl_0(s) + F_mi_0(s);
	}

	// amplitude at t = 0, according to Eq. (40)
	TComplex Amp0_pap(double s) const
	{
		return F_pl_0(s) - F_mi_0(s);
	}
};

//----------------------------------------------------------------------------------------------------

TComplex i(0, 1);

//----------------------------------------------------------------------------------------------------

Model2007::Model2007()
{
	// Table 1 from [1]
	H_1 = 0.4030;
	b_1_pl = 4.5691;
	H_2 = -3.8616;
	b_2_pl = 7.1798;
	H_3 = 9.2079;
	b_3_pl = 6.0270;
	K_pl = 0.6571;

	O_1 = -0.0696;
	b_1_mi = 8.9526;
	O_2 = +1.4166;
	b_2_mi = 3.4515;
	O_3 = +0.3558;
	b_3_mi = 1.1064;
	K_mi = 0.1267;

	s_P = { 1., 40.43, 4.37, 0.25 };
	s_PP = { 1., -9.2, 1.95, 0 };
	s_O = { 1., -6.07, 5.33, 0.57 };
	s_OP = { 1., 11.83, 1.73, 0 };
	s_R_pl = { 0.48, 38.18, 0.03, 0.88 };
	s_R_mi = { 0.34, 47.09, 33.60, 0.88 };
	s_RP_pl = { -0.56, -1930.1, 0.79, 0. };
	s_RP_mi = { 0.70, 8592.7, 7.33, 0. };

	s_PP.al_p = s_P.al_p / 2.;	// Eq. (16) from [1]
	s_OP.al_p = s_O.al_p * s_P.al_p / (s_O.al_p + s_P.al_p);	// Eq. (31) from [1]
	s_RP_pl.al_p = s_R_pl.al_p * s_P.al_p / (s_R_pl.al_p + s_P.al_p);	// Eq. (22) from [1]
	s_RP_mi.al_p = s_R_mi.al_p * s_P.al_p / (s_R_mi.al_p + s_P.al_p);	// Eq. (37) from [1]


	// TODO
	//O_3 = -8.0;

	O_1 *= 0.98;
	O_2 *= 0.98;
	O_3 = -7.9;
}

//----------------------------------------------------------------------------------------------------
	
TComplex Model2007::F_pl_0(double s) const
{
	// Eq. (9)
	const TComplex ln_s_bar = log(s) - i * M_PI / 2.;

	// Eq. (12)
	const double al_P = s_P.al_0;

	// Eq. (15)
	const double al_PP = s_PP.al_0;

	// Eq. (18)
	const double al_R = s_R_pl.al_0;

	// Eq. (19)
	const double ga_R = 1.;

	// Eq. (8)
	TComplex F_H = i * s * (
			H_1 * ln_s_bar * ln_s_bar
			+ H_2 * ln_s_bar
			+ H_3
		);

	// Eq. (11)
	TComplex F_P = s * s_P.C * (i - 1./tan(M_PI/2.*al_P)) * pow(s/s0, al_P-1.);

	// Eq. (14)
	TComplex F_PP = s * s_PP.C * (i * sin(M_PI/2.*al_PP) - cos(M_PI/2.*al_PP) ) * pow(s/s0, al_PP-1.) / ln_s_bar;

	// Eq. (17)
	TComplex F_R = s * s_R_pl.C * ga_R * (i - 1./tan(M_PI/2.*al_R)) * pow(s/s0, al_R-1.);

	// Eq. (20)
	TComplex F_RP = 0.;

	// Eq. (23)
	return F_H + F_P + F_PP + F_R + F_RP;
}

//----------------------------------------------------------------------------------------------------
	
TComplex Model2007::F_mi_0(double s) const
{
	// Eq. (9)
	const TComplex ln_s_bar = log(s) - i * M_PI / 2.;

	// Eq. (26)
	const double al_O = s_O.al_0;

	// Eq. (29)
	const double al_OP = s_OP.al_0;

	// Eq. (33)
	const double al_R = s_R_mi.al_0;

	// Eq. (34)
	const double ga_R = 1.;

	// Eq. (24)
	TComplex F_MO = s * (
			O_1 * ln_s_bar * ln_s_bar
			+ O_2 * ln_s_bar
			+ O_3
		);

	// Eq. (25)
	TComplex F_O = s * s_O.C * (i + tan(M_PI/2.*al_O)) * pow(s/s0, al_O-1.) * (1. + al_O) * (1. - al_O);

	// Eq. (28)
	TComplex F_OP = s * s_OP.C * (sin(M_PI/2.*al_OP) + i * cos(M_PI/2.*al_OP)) * pow(s/s0, al_OP-1.) / ln_s_bar;

	// Eq. (32)
	TComplex F_R = -s * s_R_mi.C * ga_R * (i + tan(M_PI/2.*al_R)) * pow(s/s0, al_R-1.);

	// Eq. (35)
	TComplex F_RP = 0.;

	return F_MO + F_O + F_OP + F_R + F_RP;
}

//----------------------------------------------------------------------------------------------------

int main()
{
	TFile *f_out = TFile::Open("model_2007.root", "recreate");

	Model2007 model;

	TGraph *g_si_tot_pp_vs_s = new TGraph();
	TGraph *g_rho_pp_vs_s = new TGraph();
	TGraph *g_si_tot_pap_vs_s = new TGraph();
	TGraph *g_rho_pap_vs_s = new TGraph();
	TGraph *g_de_rho_vs_s = new TGraph();

	for (double W = 4E0; W <= 1E7; W *= 1.1)
	{
		const double s = W*W;

		const TComplex &A_pp = model.Amp0_pp(s);
		const double si_tot_pp = 1./s * A_pp.Im();
		const double rho_pp = A_pp.Re() / A_pp.Im();

		const TComplex &A_pap = model.Amp0_pap(s);
		const double si_tot_pap = 1./s * A_pap.Im();
		const double rho_pap = A_pap.Re() / A_pap.Im();

		int idx = g_si_tot_pp_vs_s->GetN();
		g_si_tot_pp_vs_s->SetPoint(idx, W, si_tot_pp);
		g_rho_pp_vs_s->SetPoint(idx, W, rho_pp);
		g_si_tot_pap_vs_s->SetPoint(idx, W, si_tot_pap);
		g_rho_pap_vs_s->SetPoint(idx, W, rho_pap);
		g_de_rho_vs_s->SetPoint(idx, W, rho_pap - rho_pp);
	}

	g_si_tot_pp_vs_s->Write("g_si_tot_pp_vs_s");
	g_rho_pp_vs_s->Write("g_rho_pp_vs_s");
	g_si_tot_pap_vs_s->Write("g_si_tot_pap_vs_s");
	g_rho_pap_vs_s->Write("g_rho_pap_vs_s");
	g_de_rho_vs_s->Write("g_de_rho_vs_s");

	delete f_out;
}

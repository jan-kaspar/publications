#include "TFile.h"
#include "TGraph.h"

#include "TRandom2.h"

#include "stat.h"

//----------------------------------------------------------------------------------------------------

int main()
{
	// load input
	TFile *f_in_si_el = TFile::Open("si_el_fit.root");
	TGraph *g_in_si_el_cen_val = (TGraph *) f_in_si_el->Get("g_cen_val");
	TGraph *g_in_si_el_unc_mean = (TGraph *) f_in_si_el->Get("g_unc_mean");
	TGraph *g_in_si_el_unc_stddev = (TGraph *) f_in_si_el->Get("g_unc_stddev");

	TFile *f_in_compete = TFile::Open("compete/uncertainty_RRPL2u_21.root");
	TGraph *g_in_si_tot_p_p_cen_val = (TGraph *) f_in_compete->Get("si_p_p/g_cen_val");
	TGraph *g_in_si_tot_p_p_unc_mean = (TGraph *) f_in_compete->Get("si_p_p/g_unc_mean");
	TGraph *g_in_si_tot_p_p_unc_stddev = (TGraph *) f_in_compete->Get("si_p_p/g_unc_stddev");

	TGraph *g_in_si_tot_p_ap_cen_val = (TGraph *) f_in_compete->Get("si_p_ap/g_cen_val");
	TGraph *g_in_si_tot_p_ap_unc_mean = (TGraph *) f_in_compete->Get("si_p_ap/g_unc_mean");
	TGraph *g_in_si_tot_p_ap_unc_stddev = (TGraph *) f_in_compete->Get("si_p_ap/g_unc_stddev");

	TGraph *g_in_rho_p_p_cen_val = (TGraph *) f_in_compete->Get("rho_p_p/g_cen_val");
	TGraph *g_in_rho_p_p_unc_mean = (TGraph *) f_in_compete->Get("rho_p_p/g_unc_mean");
	TGraph *g_in_rho_p_p_unc_stddev = (TGraph *) f_in_compete->Get("rho_p_p/g_unc_stddev");

	TGraph *g_in_rho_p_ap_cen_val = (TGraph *) f_in_compete->Get("rho_p_ap/g_cen_val");
	TGraph *g_in_rho_p_ap_unc_mean = (TGraph *) f_in_compete->Get("rho_p_ap/g_unc_mean");
	TGraph *g_in_rho_p_ap_unc_stddev = (TGraph *) f_in_compete->Get("rho_p_ap/g_unc_stddev");

	TFile *f_in_B = TFile::Open("B_vs_s_fit.root");
	TGraph *g_in_B_cen_val = (TGraph *) f_in_B->Get("g_cen_val");
	TGraph *g_in_B_unc_mean = (TGraph *) f_in_B->Get("g_unc_mean");
	TGraph *g_in_B_unc_stddev = (TGraph *) f_in_B->Get("g_unc_stddev");

	// prepare output
	TFile *f_out = TFile::Open("build_uncertainty_bands.root", "recreate");

	// define grid of s values
	vector<double> values_W;
	for (double sqrt_s = 1E1; sqrt_s < 2E5; sqrt_s *= 1.05)
		values_W.push_back(sqrt_s);

	// set up random generator
	gRandom = new TRandom2();
	gRandom->SetSeed(1);

	// prepare data structures
	struct QuanData
	{
		vector<Stat> stat;
		vector<double> cen_val, unc_mean, unc_stddev;
		TGraph *g_cen_val;

		QuanData(unsigned int size) : stat(size, Stat(1)),
			cen_val(size), unc_mean(size), unc_stddev(size),
			g_cen_val(new TGraph)
		{
		}
	};

	QuanData qd_si_tot_p_p(values_W.size());
	QuanData qd_si_tot_p_ap(values_W.size());
	QuanData qd_si_inel_p_p(values_W.size());
	QuanData qd_si_inel_p_ap(values_W.size());
	QuanData qd_si_el(values_W.size());
	QuanData qd_rat_si_el_tot_p_p(values_W.size());
	QuanData qd_rat_si_el_tot_p_ap(values_W.size());
	QuanData qd_rho_p_p(values_W.size());
	QuanData qd_rho_p_ap(values_W.size());

	QuanData qd_B(values_W.size());

	// evaluate input on grid
	for (unsigned int si = 0; si < values_W.size(); si++)
	{
		const double W = values_W[si];

		qd_si_tot_p_p.cen_val[si] = g_in_si_tot_p_p_cen_val->Eval(W);
		qd_si_tot_p_p.unc_mean[si] = g_in_si_tot_p_p_unc_mean->Eval(W);
		qd_si_tot_p_p.unc_stddev[si] = g_in_si_tot_p_p_unc_stddev->Eval(W);

		qd_si_tot_p_ap.cen_val[si] = g_in_si_tot_p_ap_cen_val->Eval(W);
		qd_si_tot_p_ap.unc_mean[si] = g_in_si_tot_p_ap_unc_mean->Eval(W);
		qd_si_tot_p_ap.unc_stddev[si] = g_in_si_tot_p_ap_unc_stddev->Eval(W);

		qd_si_el.cen_val[si] = g_in_si_el_cen_val->Eval(W);
		qd_si_el.unc_mean[si] = g_in_si_el_unc_mean->Eval(W);
		qd_si_el.unc_stddev[si] = g_in_si_el_unc_stddev->Eval(W);

		qd_rho_p_p.cen_val[si] = g_in_rho_p_p_cen_val->Eval(W);
		qd_rho_p_p.unc_mean[si] = g_in_rho_p_p_unc_mean->Eval(W);
		qd_rho_p_p.unc_stddev[si] = g_in_rho_p_p_unc_stddev->Eval(W);

		qd_rho_p_ap.cen_val[si] = g_in_rho_p_ap_cen_val->Eval(W);
		qd_rho_p_ap.unc_mean[si] = g_in_rho_p_ap_unc_mean->Eval(W);
		qd_rho_p_ap.unc_stddev[si] = g_in_rho_p_ap_unc_stddev->Eval(W);

		qd_B.cen_val[si] = g_in_B_cen_val->Eval(W);
		qd_B.unc_mean[si] = g_in_B_unc_mean->Eval(W);
		qd_B.unc_stddev[si] = g_in_B_unc_stddev->Eval(W);
	}

	// evalute uncertainty
	for (unsigned int ci = 0; ci < 100000; ci++)
	{
		double R1 = gRandom->Gaus();
		double R2 = gRandom->Gaus();
		double R3 = gRandom->Gaus();
		double R4 = gRandom->Gaus();
		double R5 = gRandom->Gaus();
		double R6 = gRandom->Gaus();

		for (unsigned int ei = 0; ei < values_W.size(); ei++)
		{
			double si_tot_p_p_ref = qd_si_tot_p_p.cen_val[ei];
			double si_tot_p_p = si_tot_p_p_ref + qd_si_tot_p_p.unc_mean[ei] + R1 * qd_si_tot_p_p.unc_stddev[ei];

			double si_tot_p_ap_ref = qd_si_tot_p_ap.cen_val[ei];
			double si_tot_p_ap = si_tot_p_ap_ref + qd_si_tot_p_ap.unc_mean[ei] + R2 * qd_si_tot_p_ap.unc_stddev[ei];

			double si_el_ref = qd_si_el.cen_val[ei];
			double si_el = si_el_ref + qd_si_el.unc_mean[ei] + R3 * qd_si_el.unc_stddev[ei];

			double si_inel_p_p_ref = si_tot_p_p_ref - si_el_ref;
			double si_inel_p_p = si_tot_p_p - si_el;

			double si_inel_p_ap_ref = si_tot_p_ap_ref - si_el_ref;
			double si_inel_p_ap = si_tot_p_ap - si_el;

			double rat_si_el_tot_p_p_ref = si_el_ref / si_tot_p_p_ref;
			double rat_si_el_tot_p_p = si_el / si_tot_p_p;

			double rat_si_el_tot_p_ap_ref = si_el_ref / si_tot_p_ap_ref;
			double rat_si_el_tot_p_ap = si_el / si_tot_p_ap;

			qd_si_tot_p_p.stat[ei].Fill(si_tot_p_p - si_tot_p_p_ref);
			qd_si_tot_p_ap.stat[ei].Fill(si_tot_p_ap - si_tot_p_ap_ref);

			qd_si_inel_p_p.stat[ei].Fill(si_inel_p_p - si_inel_p_p_ref);
			qd_si_inel_p_ap.stat[ei].Fill(si_inel_p_ap - si_inel_p_ap_ref);

			qd_si_el.stat[ei].Fill(si_el - si_el_ref);

			qd_rat_si_el_tot_p_p.stat[ei].Fill(rat_si_el_tot_p_p - rat_si_el_tot_p_p_ref);
			qd_rat_si_el_tot_p_ap.stat[ei].Fill(rat_si_el_tot_p_ap - rat_si_el_tot_p_ap_ref);

			double rho_p_p_ref = qd_rho_p_p.cen_val[ei];
			double rho_p_p = rho_p_p_ref + qd_rho_p_p.unc_mean[ei] + R4 * qd_rho_p_p.unc_stddev[ei];

			double rho_p_ap_ref = qd_rho_p_ap.cen_val[ei];
			double rho_p_ap = rho_p_ap_ref + qd_rho_p_ap.unc_mean[ei] + R5 * qd_rho_p_ap.unc_stddev[ei];

			qd_rho_p_p.stat[ei].Fill(rho_p_p - rho_p_p_ref);
			qd_rho_p_ap.stat[ei].Fill(rho_p_ap - rho_p_ap_ref);

			double B_ref = qd_B.cen_val[ei];
			double B = B_ref + qd_B.unc_mean[ei] + R6 * qd_B.unc_stddev[ei];

			qd_B.stat[ei].Fill(B - B_ref);

			if (ci == 0)
			{
				const double W = values_W[ei];
				int idx = qd_si_tot_p_p.g_cen_val->GetN();
				qd_si_tot_p_p.g_cen_val->SetPoint(idx, W, si_tot_p_p_ref);
				qd_si_tot_p_ap.g_cen_val->SetPoint(idx, W, si_tot_p_ap_ref);
				qd_si_inel_p_p.g_cen_val->SetPoint(idx, W, si_inel_p_p_ref);
				qd_si_inel_p_ap.g_cen_val->SetPoint(idx, W, si_inel_p_ap_ref);
				qd_si_el.g_cen_val->SetPoint(idx, W, si_el_ref);
				qd_rat_si_el_tot_p_p.g_cen_val->SetPoint(idx, W, rat_si_el_tot_p_p_ref);
				qd_rat_si_el_tot_p_ap.g_cen_val->SetPoint(idx, W, rat_si_el_tot_p_ap_ref);
				qd_rho_p_p.g_cen_val->SetPoint(idx, W, rho_p_p_ref);
				qd_rho_p_ap.g_cen_val->SetPoint(idx, W, rho_p_ap_ref);

				qd_B.g_cen_val->SetPoint(idx, W, B_ref);
			}
		}
	}

	// build graphs
	struct GraphSet
	{
		TGraph *g_cen_val, *g_unc_mean, *g_unc_stddev, *g_band_up, *g_band_dw;

		GraphSet()
		{
			g_cen_val = new TGraph();
			g_unc_mean = new TGraph();
			g_unc_stddev = new TGraph();
			g_band_up = new TGraph(); g_band_up->SetLineColor(2);
			g_band_dw = new TGraph(); g_band_dw->SetLineColor(2);
		}

		void Fill(double W, double cv, double mean, double stddev)
		{
			int idx = g_cen_val->GetN();

			g_cen_val->SetPoint(idx, W, cv);
			g_unc_mean->SetPoint(idx, W, mean);
			g_unc_stddev->SetPoint(idx, W, stddev);
			g_band_up->SetPoint(idx, W, cv + mean + stddev);
			g_band_dw->SetPoint(idx, W, cv + mean - stddev);
		}

		void Write() const
		{
			g_cen_val->Write("g_cen_val");
			g_unc_mean->Write("g_unc_mean");
			g_unc_stddev->Write("g_unc_stddev");
			g_band_up->Write("g_band_up");
			g_band_dw->Write("g_band_dw");
		}
	};

	GraphSet gs_si_tot_p_p;
	GraphSet gs_si_tot_p_ap;
	GraphSet gs_si_inel_p_p;
	GraphSet gs_si_inel_p_ap;
	GraphSet gs_si_el;
	GraphSet gs_rat_si_el_tot_p_p;
	GraphSet gs_rat_si_el_tot_p_ap;
	GraphSet gs_rho_p_p;
	GraphSet gs_rho_p_ap;

	GraphSet gs_B;

	for (unsigned int si = 0; si < values_W.size(); si++)
	{
		const double W = values_W[si];
		const double s = values_W[si] * values_W[si];

		gs_si_tot_p_p.Fill(W, qd_si_tot_p_p.g_cen_val->Eval(W), qd_si_tot_p_p.stat[si].GetMean(0), qd_si_tot_p_p.stat[si].GetStdDev(0));
		gs_si_tot_p_ap.Fill(W, qd_si_tot_p_ap.g_cen_val->Eval(W), qd_si_tot_p_ap.stat[si].GetMean(0), qd_si_tot_p_ap.stat[si].GetStdDev(0));
		gs_si_inel_p_p.Fill(W, qd_si_inel_p_p.g_cen_val->Eval(W), qd_si_inel_p_p.stat[si].GetMean(0), qd_si_inel_p_p.stat[si].GetStdDev(0));
		gs_si_inel_p_ap.Fill(W, qd_si_inel_p_ap.g_cen_val->Eval(W), qd_si_inel_p_ap.stat[si].GetMean(0), qd_si_inel_p_ap.stat[si].GetStdDev(0));
		gs_si_el.Fill(W, qd_si_el.g_cen_val->Eval(W), qd_si_el.stat[si].GetMean(0), qd_si_el.stat[si].GetStdDev(0));
		gs_rat_si_el_tot_p_p.Fill(W, qd_rat_si_el_tot_p_p.g_cen_val->Eval(W), qd_rat_si_el_tot_p_p.stat[si].GetMean(0), qd_rat_si_el_tot_p_p.stat[si].GetStdDev(0));
		gs_rat_si_el_tot_p_ap.Fill(W, qd_rat_si_el_tot_p_ap.g_cen_val->Eval(W), qd_rat_si_el_tot_p_ap.stat[si].GetMean(0), qd_rat_si_el_tot_p_ap.stat[si].GetStdDev(0));
		gs_rho_p_p.Fill(W, qd_rho_p_p.g_cen_val->Eval(W), qd_rho_p_p.stat[si].GetMean(0), qd_rho_p_p.stat[si].GetStdDev(0));
		gs_rho_p_ap.Fill(W, qd_rho_p_ap.g_cen_val->Eval(W), qd_rho_p_ap.stat[si].GetMean(0), qd_rho_p_ap.stat[si].GetStdDev(0));

		gs_B.Fill(W, qd_B.g_cen_val->Eval(W), qd_B.stat[si].GetMean(0), qd_B.stat[si].GetStdDev(0));
	}

	// save output
	gDirectory = f_out->mkdir("si_tot_p_p");
	gs_si_tot_p_p.Write();

	gDirectory = f_out->mkdir("si_tot_p_ap");
	gs_si_tot_p_ap.Write();

	gDirectory = f_out->mkdir("si_inel_p_p");
	gs_si_inel_p_p.Write();

	gDirectory = f_out->mkdir("si_inel_p_ap");
	gs_si_inel_p_ap.Write();

	gDirectory = f_out->mkdir("si_el");
	gs_si_el.Write();

	gDirectory = f_out->mkdir("rat_si_el_tot_p_p");
	gs_rat_si_el_tot_p_p.Write();

	gDirectory = f_out->mkdir("rat_si_el_tot_p_ap");
	gs_rat_si_el_tot_p_ap.Write();

	gDirectory = f_out->mkdir("rho_p_p");
	gs_rho_p_p.Write();

	gDirectory = f_out->mkdir("rho_p_ap");
	gs_rho_p_ap.Write();

	gDirectory = f_out->mkdir("B");
	gs_B.Write();

	// clean up
	delete f_out;
	
	return 0;
}

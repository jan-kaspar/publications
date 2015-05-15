import root;
import pad_layout;
import patterns;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/plots/t_distributions/common_code.asy";

pen full_band_p = (olive*0.5 + yellow*0.7) + opacity(0.7);
pen anal_band_p = brown*0.5 + yellow*0.5;
add("hatch", hatch(1.3mm, NE, anal_band_p+1pt));

//----------------------------------------------------------------------------------------------------

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/";

string datasets[] = { "DS4" };

string datasets_unc[] = { "DS4" };

string diagonals[] = { "combined" };
string diagonals_long[] = { "diagonals combined" };

xSizeDef = 14.1cm;
ySizeDef = 6cm;

string ref_str = MakeRefStr();

//string binning = "ub";
//string binning = "ob";
//string binning = "eb";
//string binning = "eb20,1000";
//string binning = "eb20,200";
//string binning = "hb";
string binning = "cpb,0.001";

string iteration = "iteration 2";

string f = "fit_with_syst-split_fit.root";

TGraph_errorBar = None;

//----------------------------------------------------------------------------------------------------

void DrawBand(rObject o_c, rObject o_r, pen p)
{
	guide gp, gm;

	int N = o_r.iExec("GetNbinsX");
	for (int bi = 1; bi <= N; ++bi)
	{
		real x = o_r.rExec("GetBinCenter", bi);
		real u_rel = o_r.rExec("GetBinContent", bi);

		if (u_rel <= 0 || x > 0.2)
			continue;

		real y = o_c.rExec("Eval", x);
		real u = u_rel * y;

		gp = gp -- Scale((x, y + u));
		gm = gm -- Scale((x, y - u));
	}
	
	gm = reverse(gm);
	filldraw((gp--gm--cycle), p, nullpen);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string base_dir = binning + "/"+datasets[0]+"/"+diagonals[0]+"/fit with systematics, "+format("n_b=%i", 3)+"/"+iteration;

rObject h_dsdt = rGetObj(topDir+"DS-merged/"+f, base_dir + "/h_dsdt", error=false);
if (!h_dsdt.valid)
	write("ERROR: can't load fit data " + base_dir);

rObject g_dsdt = rGetObj(topDir+"DS-merged/"+f, base_dir + "/g_fit");

rObject f_dsdt_fit = rGetObj(topDir+"DS-merged/"+f, base_dir+"/fit canvas|f_fit");

rObject h_rel_unc_anal = rGetObj(topDir+"systematics/"+datasets_unc[0]+"/matrix_direct_"+diagonals[0]+".root",
	"all analysis/"+binning+"/h_stddev");

rObject h_rel_unc_full = rGetObj(topDir+"systematics/"+datasets_unc[0]+"/matrix_direct_"+diagonals[0]+".root",
	"all/"+binning+"/h_stddev");

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

/*
NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$");
currentpad.xSize = 5cm;
currentpad.xTicks = LeftTicks(0.05, 0.01);
scale(Linear, Log);

DrawBand(f_dsdt_fit, h_rel_unc_full, paleblue+opacity(0.4));
DrawBand(f_dsdt_fit, h_rel_unc_anal, yellow);

draw(g_dsdt, "p", mCi+1pt+black);

limits((0, 1e1), (0.2, 4e2), Crop);
*/

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

void PlotOneFit(string f, string ds, string dgn, string binning, int n_b, string fit_type, string iteration, pen p)
{
	string base = binning+"/"+ds+"/"+dgn+format("/"+fit_type+", n_b=%u/", n_b) + iteration;
	rObject ff = rGetObj(f, base + "/fit canvas|f_fit", error=false);
	rObject fd = rGetObj(f, base + "/g_fit_data", error=false);

	if (!ff.valid || !ff.valid)
	{
		write("ERROR: can't load fit results: " + base);
		return;
	}

	real chi2 = ff.rExec("GetChisquare");
	int ndf = ff.iExec("GetNDF");
	real chi2_ndf = (ndf > 0) ? chi2/ndf : 0;
	real prob = ff.rExec("GetProb");

	real x[] = { 0. };
	real y[] = { 0. };
	fd.vExec("GetPoint", 0., x, y);
	real sigma_eq = y[0];

	string label = format("$\chi^2/\hbox{ndf} = %#5.1f", chi2) + format("/%i = ", ndf) + format("%#.3f$", chi2_ndf)
		+ format(" $\Rightarrow$ p-value = $%#.2E$", prob);
	if (sigma_eq > 0)
		label += format(", significance = $%#.2f\un{\si}$", sigma_eq);
	else
		label += ", significance = INF";

	label = "";

	DrawRelDiff(ff, red + p, label);

	/*
	AddToLegend(
		format("$a_1 = (%.0f$", ff.rExec("GetParameter", 0)) + format("$\pm %.0f)\un{mb/GeV^2}$, ", ff.rExec("GetParError", 0))
		+ format("$b_1 = (%.1f$", ff.rExec("GetParameter", 1)) + format("$\pm %.1f)\un{GeV^{-2}}$", ff.rExec("GetParError", 1))
	);

	AddToLegend(
		format("$a_2 = (%.0f$", ff.rExec("GetParameter", 2)) + format("$\pm %.0f)\un{mb/GeV^2}$, ", ff.rExec("GetParError", 2))
		+ format("$b_2 = (%.1f$", ff.rExec("GetParameter", 3)) + format("$\pm %.1f)\un{GeV^{-2}}$", ff.rExec("GetParError", 3))
	);
	*/
}

//----------------------------------------------------------------------------------------------------

frame fLegend;

for (int dsi : datasets.keys)
{
	int min_n_b = 3;
	int max_n_b = 3;

	A_ref = 519.9; B_ref = 19.39;
	ref_str = MakeRefStr();

	//NewRow();
	//NewPad(false);
	//label("{\SetFontSizesXX " + replace(datasets[dsi], "_", "\_") + "}");

	for (int dgni : diagonals.keys)
	{
		string dataset = datasets[dsi];

		NewPad("$|t|\ung{GeV^2}$", "$\displaystyle{\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\quad \hbox{ref} = "+ref_str+"$",
			axesAbove=false);
	
		AddToLegend("data, statistical uncertainties", MarkerArray(mCi+1pt, (scale(0.0001, 1.)*mPl)+5pt));

		// uncertainty band
		//AddToLegend("systematic uncertainty band", mSq+true+5pt+lightgray);
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_full, x_max=0.2, full_band_p, "full systematic uncertainty band");
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, pattern("hatch"), "syst.~unc.~band without normalisation");

		//AddToLegend("fit parametrisation: $\cases{a_1\,\exp(-b_1 |t|) & for $|t| < 0.7\un{GeV^2}$\cr a_2\,\exp(-b_2 |t|) & for $|t| > 0.7\un{GeV^2}$\cr}$");

		// datapoints
		//DrawRelDiff(h_dsdt, black);
		DrawRelDiff(g_dsdt, black+0.1pt, mCi+0.7pt+black);
		
		//DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, yellow+opacity(0.4), "");

		/*
		// fits with statistical uncertainties
		AddToLegend("{\it fits with statistical uncertainties:}");
		for (int i = min_n_b; i <= max_n_b; ++i)
			PlotOneFit(topDir+"DS-merged/"+f, datasets[dsi], diagonals[dgni], binning, i, "fit without systematics", ""+iteration+"", dashed);
		*/
		
		// fits with statistical and systematic uncertainties
		//AddToLegend("{\it fits with statistical and systematic uncertainties:}");
		for (int i = min_n_b; i <= max_n_b; ++i)
			PlotOneFit(topDir+"DS-merged/"+f, datasets[dsi], diagonals[dgni], binning, i, "fit with systematics", ""+iteration+"", solid+1.5pt);

		/*
		// datapoints + uncertainty mode
		string fu = topDir + "systematics/simu.root";

		DrawRelDiffWithCorrection(
			rGetObj(topDir+"DS-merged/fit.root", binning + "/"+datasets[dsi]+"/"+diagonals[dgni]+"/fit with systematics, n_b=1/fit canvas|h_dsdt"),
			rGetObj(fu, "de_th_y/h_eff_syst"),
			+3., blue+1.0pt, "$+3\un{\si}$", true);
		*/

		real y_min, y_max, y_Step, y_step;
		y_min = -0.05;
		y_max = +0.06;
		y_Step = 0.01;
		y_step = 0.005;

		currentpad.xTicks = LeftTicks(0.02, 0.01);
		currentpad.yTicks = RightTicks(y_Step, y_step);	
			
		limits((0, y_min), (0.20, y_max), Crop);

		for (real x = 0; x <= 0.2; x += 0.02)
			yaxis(XEquals(x, false), dotted, above=true);

		for (real y = y_min; y <= y_max; y += y_Step)
			xaxis(YEquals(y, false), (abs(y) < 1e-5) ? dashed : dotted, above=true);
		
		frame fL = BuildLegend(lineLength=5mm, vSkip=-1mm, N);
		AttachLegend(fL, N);
	}
}
		
GShipout(vSkip=0mm, hSkip=5mm, margin=0mm);

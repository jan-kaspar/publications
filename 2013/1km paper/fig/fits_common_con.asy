import root;
import pad_layout;
import patterns;
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/plots/t_distributions/common_code.asy";
import latex_aux_parser;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

legendLabelPen = fontcommand("\SmallerFonts");

pen p_full_band = (olive*0.5 + yellow*0.7) + opacity(1);
pen p_anal_band = brown*0.5 + yellow*0.5;

add("hatch", hatch(1.7mm, NE, p_anal_band+1pt));
add("hatch-b", hatch(1.7mm, NE, p_full_band+0.7pt));

add("hatch2", hatch(1.7mm, NW, p_anal_band+1pt));
add("hatch2-b", hatch(1.7mm, NW, p_full_band+0.7pt));

//----------------------------------------------------------------------------------------------------

ParseLatexAuxFile("../elastic_1km_npb.aux");

//----------------------------------------------------------------------------------------------------

struct FitType
{
	string method, intFor, hadPha, Nb;
}

FitType fits[];

void AddFit(string m, string iF, string hP, string nb)
{
	FitType ft;
	ft.method = m;
	ft.intFor = iF;
	ft.hadPha = hP;
	ft.Nb = nb;
	fits.push(ft);
}

//----------------------------------------------------------------------------------------------------

string datasets[] = { "1000-ob-0-1,90-DS4-sc-ob" };

xSizeDef = 10cm;
ySizeDef = 7cm;

string ref_str = MakeRefStr();

AddFit("simple", "SWY", "con", "1");
AddFit("parcmp", "SWY", "con", "1");
AddFit("simple", "KL", "con", "1");
AddFit("parcmp", "KL", "con", "1");
AddFit("simple", "KL", "con", "2");
AddFit("parcmp", "KL", "con", "2");
AddFit("simple", "KL", "con", "3");
AddFit("parcmp", "KL", "con", "3");

//----------------------------------------------------------------------------------------------------

string syst_unc_file_1000 = topDir+"4000GeV,beta1000/systematics/DS2b/matrix_numerical_integration.root";
string syst_unc_obj_full_1000 = "matrices/all/combined/ob-1-10/h_stddev";
string syst_unc_obj_anal_1000 = "matrices/all-anal/combined/ob-1-10/h_stddev";

string syst_unc_file_90 = topDir+"4000GeV,beta90/systematics/DS4/matrix_direct_combined.root";
string syst_unc_obj_full_90 = "all/ob/h_stddev";
string syst_unc_obj_anal_90 = "all analysis/ob/h_stddev";

//----------------------------------------------------------------------------------------------------

void PlotOneFit(string f, string desc, pen p)
{
	rObject g_fit = rGetObj(f, "fit canvas|g_fit", error=false);
	if (!g_fit.valid)
		g_fit = rGetObj(f, "g_fit_CH", error=false);
	if (!g_fit.valid)
		return;

	rObject g_fit_data = rGetObj(f, "g_fit_data", error=false);


	real x[] = { 0. };
	real y[] = { 0. };
	g_fit_data.vExec("GetPoint", 0, x, y); real chi2 = y[0];
	g_fit_data.vExec("GetPoint", 1, x, y); real ndf = y[0];
	g_fit_data.vExec("GetPoint", 2, x, y); real prob = y[0];
	g_fit_data.vExec("GetPoint", 3, x, y); real sigma_eq = y[0];
	real chi2_ndf = (ndf > 0) ? chi2/ndf : 0;

	string label = desc + ": "
		//+ format("$\chi^2/\hbox{ndf} = %#5.1f", chi2) + format("/%.0f = ", ndf) + format("%#.3f$", chi2_ndf)
		//+ format("p-value = $%#.1E$", prob)
		+ format("sig = $%#.2f\un{\si}$", sigma_eq);

	rel_diff_low_limit = 0.001;
	rel_diff_high_limit = 0.2;
	DrawRelDiff(g_fit, "l", p, label);
	rel_diff_high_limit = +inf;
}

//----------------------------------------------------------------------------------------------------

A_ref = 519.545; B_ref = 19.376;
ref_str = MakeRefStr();

//----------------------------------------------------------------------------------------------------

frame fLegend;

for (int dsi : datasets.keys)
{
	int min_n_b = 1;
	int max_n_b = 3;

	NewRow();

	string dataset = datasets[dsi];

	NewPad("$|t|\ung{GeV^2}$", "$\displaystyle{\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\quad\hbox{ref} = "+ref_str+"$",
		axesAbove=false);

	string fitDir = topDir + "4000GeV,combined/coulomb_analysis/data/";
	
	int defFitIdx = 0;
	// TODO
	//string defDir = "simple:"+fits[defFitIdx].Nb+","+fits[defFitIdx].intFor+","+fits[defFitIdx].hadPha+",chisq,,st";
	//string defDir = fits[defFitIdx].method+":"+fits[defFitIdx].Nb+","+fits[defFitIdx].intFor+","+fits[defFitIdx].hadPha+",chisq,,st";
	string defDir = "simple:3,KL,con,chisq,,st";
	
	// centre for uncertainty bands
	rObject f_dsdt_fit = rGetObj(fitDir + datasets[dsi]+"/"+defDir+"/fit.root", "f_fit");

	// build list of data set tags
	string ds_tags[];
	string f_data = fitDir + datasets[dsi]+"/"+defDir+"/fit.root";
	for (int di = 0; di < 3; ++di)
	{
		string o_data = "fit canvas|g_data" + format("%i", di);
		rObject obj = rGetObj(f_data, o_data, error=false);
		if (obj.valid)
			ds_tags.push(obj.sExec("GetTitle"));
	}

	// draw full uncertainty band
	for (int ti : ds_tags.keys)
	{
		string data_tag = ds_tags[ti];

		if (find(data_tag, "1000-") == 0)
		{
			rObject h_rel_unc_full = rGetObj(syst_unc_file_1000, syst_unc_obj_full_1000);
			DrawRelDiffBand(f_dsdt_fit, h_rel_unc_full, x_max=0.2, pattern("hatch-b"));
		}

		if (find(data_tag, "90-") == 0)
		{
			rObject h_rel_unc_full = rGetObj(syst_unc_file_90, syst_unc_obj_full_90);
			DrawRelDiffBand(f_dsdt_fit, h_rel_unc_full, x_max=0.2, pattern("hatch2-b"));
		}
	}

	// draw analysis uncertainty band
	for (int ti : ds_tags.keys)
	{
		string data_tag = ds_tags[ti];

		if (find(data_tag, "1000-") == 0)
		{
			rObject h_rel_unc_anal = rGetObj(syst_unc_file_1000, syst_unc_obj_anal_1000);
			DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, pattern("hatch"));
		}

		if (find(data_tag, "90-") == 0)
		{
			rObject h_rel_unc_anal = rGetObj(syst_unc_file_90, syst_unc_obj_anal_90);
			DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, pattern("hatch2"));
		}
	}

	// draw data + statistical uncertainties
	for (int di = 0; di < 3; ++di)
	{
		string o_data = "fit canvas|g_data" + format("%i", di);
		rObject obj = rGetObj(f_data, o_data, error=false);
		if (obj.valid)
		{
			string data_tag = obj.sExec("GetTitle");
			pen p = StdPen(di+1);
			DrawRelDiff(obj, p, std_marks[di+2] + 3pt + p);
		}
	}

	// draw data legend
	for (int ti : ds_tags.keys)
	{
		string data_tag = ds_tags[ti];
		
		pen p = StdPen(ti+1);

		if (find(data_tag, "1000-") == 0)
		{
			AddToLegend("<{\it differential cross-section, $\be^* =$ 1000 m:}");
			AddToLegend("data points with statistical uncertainties", std_marks[ti+2] + 3pt + p);
			AddToLegend("full systematic uncertainty band", mSq+6pt+pattern("hatch-b"));
			AddToLegend("band of syst.~unc.~without normalisation", mSq+6pt+pattern("hatch"));
		}

		if (find(data_tag, "90-") == 0)
		{
			AddToLegend("<{\it differential cross-section, $\be^* =$ 90 m:}");
			AddToLegend("data points with statistical uncertainties", std_marks[ti+2] + 3pt + p);
			AddToLegend("full systematic uncertainty band", mSq+6pt+pattern("hatch2-b"));
			AddToLegend("band of syst.~unc.~without normalisation", mSq+6pt+pattern("hatch2"));
		}
	}

	//AddToLegend("data ("+ replace(datasets[dsi], "_", "\_") +")", mCi+1pt);

	// fit description
	/*
	AddToLegend("<{\it fit parametrisation:}");
	AddToLegend("nuclear modulus: Eq.~(" + GetLatexReference("label", "eq:nuc mod") + ")");
	AddToLegend("nuclear phase: constant, Eq.~(" + GetLatexReference("label", "eq:nuc phase con") + ")");
	*/

	// fits with statistical and systematic uncertainties
	AddToLegend("<{\it fit results:}");
	for (int fi : fits.keys)
	{
		string dir = fits[fi].method+":"+fits[fi].Nb+","+fits[fi].intFor+","+fits[fi].hadPha+",chisq,,st+sy";
		
		string method = fits[fi].method;
		if (method == "simple")
			method = "std.~LS fit";
		if (method == "peripheral")
			method = "std.~LS fit (per.)";
		if (method == "parcmp")
			method = "par.~cmp.~fit";
		if (method == "parcmpper")
			method = "par.~cmp.~fit (per.)";

		//string label = fits[fi].intFor + ", $N_b = $ " + fits[fi].Nb + ", " + fits[fi].hadPha + "; " + method;
		string label = fits[fi].intFor + ", $N_b = $ " + fits[fi].Nb + "; " + method;

		pen p;
		p = StdPen(quotient(fi, 2) + 0) + 1pt;
		if (fi % 2 == 0) p += solid;
		if (fi % 2 == 1) p += dashed;
		
		PlotOneFit(fitDir + datasets[dsi]+"/"+dir+"/fit.root", label, p);
	}

	real y_min, y_max, y_Step, y_step;
	y_min = -0.05; y_max = +0.08; y_Step = 0.01; y_step = 0.005;

	currentpad.xTicks = LeftTicks(0.05, 0.01);
	currentpad.yTicks = RightTicks(y_Step, y_step);
		
	limits((0, y_min), (0.2, y_max), Crop);

	for (real x = 0; x <= 0.2; x += 0.05)
		yaxis(XEquals(x, false), dotted);

	for (real y = y_min; y <= y_max; y += y_Step)
		xaxis(YEquals(y, false), (abs(y) < 1e-5) ? dashed : dotted);

	AttachLegend(BuildLegend(lineLength=6mm, vSkip=-0.7mm, NW), NE);

	currentpicture.legend.delete();
	//AttachLegend("nuclear phase: constant, Eq.~(" + GetLatexReference("label", "eq:nuc phase con") + ")", N, N);
	AttachLegend("nuclear phase: constant parametrisation)", N, N);
}
		
GShipout(margin=0mm);

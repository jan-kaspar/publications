import root;
import pad_layout;
import patterns;

include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/plots/base.asy";
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/plots/t_distributions/common_code.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

pen p_full_band = (olive*0.5 + yellow*0.7) + opacity(1);
//pen p_anal_band = brown*0.5 + yellow*0.5;
pen p_anal_band = heavygreen;

add("hatch", hatch(1.7mm, NE, p_anal_band+1pt));
add("hatch-b", hatch(1.7mm, NE, p_full_band+0.7pt));

add("hatch2", hatch(1.7mm, NW, p_anal_band+1pt));
add("hatch2-b", hatch(1.7mm, NW, p_full_band+0.7pt));

//----------------------------------------------------------------------------------------------------


string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/";

string fits[] = {
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:1,KL,con,chisq,,st+sy_noNorm",
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:1,SWY,con,chisq,,st+sy_noNorm",
	//"1000-ob-0-1,90-DS4-sc-ob/pervojsep-1000,v,v,v,v-all,v,v,f,v:1,KL,per-jun15,chisq,,st+sy_noNorm",
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:1,KL,per-jun15,chisq,,st+sy_noNorm",
};

pen fitPens[] = {
	black,
	magenta+dashed,
	//red,
	red,
};

string fitLabels[] = {
	"Cahn/KL, constant",
	"SWY, constant",
	//"Cahn/KL, mid-peripheral",
	"Cahn/KL, peripheral",
};

xSizeDef = 11cm;
ySizeDef = 7cm;

drawGridDef = true;

string ref_str = MakeRefStr();

string syst_unc_file_1000 = topDir+"../../4000GeV,beta1000/systematics/DS2b/matrix_numerical_integration.root";
string syst_unc_obj_full_1000 = "matrices/all/combined/ob-1-10/h_stddev";
string syst_unc_obj_anal_1000 = "matrices/all-anal/combined/ob-1-10/h_stddev";

string syst_unc_file_90 = topDir+"../../4000GeV,beta90/systematics/DS4/matrix_direct_combined.root";
string syst_unc_obj_full_90 = "all/ob/h_stddev";
string syst_unc_obj_anal_90 = "all analysis/ob/h_stddev";

//-----------------------------------------------------------------------------------------------------

pad p_main;

void PlotOneFit(string dir, string desc, pen p)
{
	// ----- results file ------
	Results ra[] = { new Results };
	int ret = ParseData(dir + "/fit.out", ra);
	if (ret != 0 || ! ra[0].Valid())
		return;

	// ----- ROOT file -----
	string f = dir + "/fit.root";

	//RootObject f_fit = RootGetObject(f, "f_fit", error=false);
	//RootObject g_fit = RootGetObject(f, "g_fit", error=false);

	RootObject g_fit = RootGetObject(f, "g_fit_CH", error=false);
	RootObject g_fit_h = RootGetObject(f, "g_fit_H", error=false);

	if (!g_fit.valid)
		return;

	RootObject g_fit_data = RootGetObject(f, "g_fit_data", error=false);

	RootObject g_Phase_H = RootGetObject(f, "g_Phase_H", error=false);

	string label = desc;

	SetPad(p_main);

	rel_diff_low_limit = 0.001;
	rel_diff_high_limit = 0.201;
	DrawRelDiff(g_fit, "l", p, label);
	//DrawRelDiff(g_fit_h, "l", p+dashed, "hadronic only");
	rel_diff_high_limit = +inf;
}

//----------------------------------------------------------------------------------------------------

A_ref = 527.1; B_ref = 19.39;
ref_str = MakeRefStr();

//----------------------------------------------------------------------------------------------------

int min_n_b = 1;
int max_n_b = 3;

NewRow();

p_main = NewPad("$|t|\ung{GeV^2}$", "$\displaystyle{\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\quad\hbox{ref} = "+ref_str+"$",
	axesAbove=true);

string defDir = "1000-ob-0-1,90-DS4-sc-ob/simple:3,KL,con,chisq,,st";

// centre for uncertainty bands
RootObject f_dsdt_fit = RootGetObject(topDir + "/data/"+defDir+"/fit.root", "f_fit");

// build list of data set tags
string ds_tags[];
string f_data = topDir + "/data/"+defDir+"/fit.root";
for (int di = 0; di < 3; ++di)
{
	string o_data = "fit canvas|g_data" + format("%i", di);
	RootObject obj = RootGetObject(f_data, o_data, error=false);
	if (obj.valid)
		ds_tags.push(obj.sExec("GetTitle"));
}

// draw full uncertainty band
for (int ti : ds_tags.keys)
{
	string data_tag = ds_tags[ti];

	if (find(data_tag, "1000-") == 0)
	{
		RootObject h_rel_unc_full = RootGetObject(syst_unc_file_1000, syst_unc_obj_full_1000);
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_full, x_max=0.2, pattern("hatch-b"));
	}

	if (find(data_tag, "90-") == 0)
	{
		RootObject h_rel_unc_full = RootGetObject(syst_unc_file_90, syst_unc_obj_full_90);
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_full, x_max=0.2, pattern("hatch2-b"));
	}
}

// draw analysis uncertainty band
for (int ti : ds_tags.keys)
{
	string data_tag = ds_tags[ti];

	if (find(data_tag, "1000-") == 0)
	{
		RootObject h_rel_unc_anal = RootGetObject(syst_unc_file_1000, syst_unc_obj_anal_1000);
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, pattern("hatch"));
	}

	if (find(data_tag, "90-") == 0)
	{
		RootObject h_rel_unc_anal = RootGetObject(syst_unc_file_90, syst_unc_obj_anal_90);
		DrawRelDiffBand(f_dsdt_fit, h_rel_unc_anal, x_max=0.2, pattern("hatch2"));
	}
}

// draw data + statistical uncertainties
for (int di = 0; di < 3; ++di)
{
	string o_data = "fit canvas|g_data" + format("%i", di);
	RootObject obj = RootGetObject(f_data, o_data, error=false);
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
		AddToLegend("<{\it $\be^* =$ 1000 m:}");
		AddToLegend("data with stat.~unc.", std_marks[ti+2] + 3pt + p);
		AddToLegend("full syst.~unc.", mSq+7pt+pattern("hatch-b"));
		AddToLegend("syst.~unc.~w/o norm.", mSq+7pt+pattern("hatch"));
	}

	if (find(data_tag, "90-") == 0)
	{
		AddToLegend("<{\it $\be^* =$ 90 m:}");
		AddToLegend("data with stat.~unc.", std_marks[ti+2] + 3pt + p);
		AddToLegend("full syst.~unc.", mSq+7pt+pattern("hatch2-b"));
		AddToLegend("syst.~unc.~w/o norm.", mSq+7pt+pattern("hatch2"));
	}
}

bool fitStSy = true;

AddToLegend("<{\it fits:}");

for (int fi : fits.keys)
{
	string label = fits[fi];
	label = substr(label, find(label, "/")+1);

	pen p = fitPens[fi] + 1pt;
	
	PlotOneFit(topDir + "/data/"+ fits[fi], fitLabels[fi], p);
}

//------------------------------

SetPad(p_main);

real y_min, y_max, y_Step, y_step;
y_min = -0.05; y_max = +0.08; y_Step = 0.01; y_step = 0.005;

currentpad.xTicks = LeftTicks(0.05, 0.01);
currentpad.yTicks = RightTicks(y_Step, y_step);
	
limits((0, y_min), (0.2, y_max), Crop);

//AttachLegend(NW, NE);

// swap 3rd and 4th legend etry from the end
int s = currentpicture.legend.length;
Legend l = currentpicture.legend[s-3];
currentpicture.legend[s-3] = currentpicture.legend[s-2];
currentpicture.legend[s-2] = l;

AttachLegend(shift(-25, 10)*BuildLegend(3, S, hSkip=4mm, lineLength=8mm, vSkip=-1mm), N);

GShipout(vSkip=0mm, margin=1mm);

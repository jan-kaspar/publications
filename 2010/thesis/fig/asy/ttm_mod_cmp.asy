include root;
include pad_layout;
import settings;

StdFonts();
xSizeDef = 9cm;
//ySizeDef = 8cm;

string mod_dir = "../elastic_models/data";
string ttm_dir = "../elastic_data_model_cmp";

string[] files = {
	"3500GeV_0_20_4E3", 
};

string[] flabels = {
	"$\sqrt s = 7\,{\rm TeV}$",
};
	
string[] tags = {"islam_bfkl", "islam_cgc", "ppp2", "ppp3", "bsw", "bh", "jenkovszky" };
pen[] colors = {black, black+dashed, red, red+dashed, blue, heavygreen, magenta, orange};
string[] labels = {"Islam et al. (HP)", "Islam et al. (LxG)", "Petrov et al. (2P)", "Petrov et al. (3P)",
	"Bourrely et al.", "Block et al.", "Jenkovszky et al."};


TGraph_reducePoints = 1;
xTicksDef = LeftTicks(Step=0.5, step=0.1);

//----------------------------------------------------------------------------------------------------

void AddErrorBars(real t, real s, real et, real esp, real esm, pen color=orange)
{
	//dotfactor = 5;
	//dot((t, log10(s)), red);
	
	//draw((t*(1-et/100), log10(s))--(t*(1+et/100), log10(s)), red, Bars);
	//draw((t, log10(s*(1+esm/100)))--(t, log10(s*(1+esp/100))), red, Bars);

	real l = t-0.01, r = t+0.01, b = log10(s*(1+esm/100)), t = log10(s*(1+esp/100));
	filldraw((l, b)--(r, b)--(r, t)--(l, t)--cycle, color, nullpen);
}

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$");
scale(Linear, Log);

for (int t : tags.keys) {
	rObject o = rGetObj(mod_dir+"/"+files[0] + ".root", "differential cross section/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, colors[t], labels[t]);
}

//draw(rGetObj("khoze.root", "c1_n2|khoze1"), orange, "Khoze et al. (i)");
//draw(rGetObj("khoze.root", "c1_n2|khoze2"), orange+dashed, "Khoze et al. (ii)");

//draw(rGetObj("ostapchenko.root", "ostapchenko"), cyan, "Ostapchenko");
//draw(rGetObj("menon.root", "menon"), red, "Fagundes et al.");

draw(rGetObj(ttm_dir+"/merged.root", "tc|merged_background_subtracted_unfolded"), "vl,ec", black+1.5pt, "TOTEM");

AddErrorBars(0.4, 0.13, 13, +25, -37);
AddErrorBars(0.5, 0.019, 12, +28, -39);
AddErrorBars(1.5, 0.0011, 7, +27, -30);

label("\SmallerFonts TOTEM measurement uncertainties", (0.1, log10(2e-4)), E);

AddErrorBars(0.15, 9e-5, 0, +30, -30, black+opacity(0.3));
label("\SmallerFonts statistical", (0.15, log10(9e-5)), E);

AddErrorBars(0.15, 4e-5, 0, +30, -30, orange);
label("\SmallerFonts systematic (at $|t| = 0.4, 0.5$ and $1.5\un{GeV^2}$)", (0.15, log10(4e-5)), E);

limits((0, 1e-5), (2.5, 1e0), Crop);
frame fl = Legend();

NewPad(false);
attach(shift(-5mm, 2cm)* fl);

GShipout("ttm_mod_cmp_dsdt", hSkip=3mm);

//----------------------------------------------------------------------------------------------------

xTicksDef = LeftTicks(Step=0.1, step=0.02);
NewPad("$|t|\ung{GeV^2}$", "$B \ung{GeV^{-2}}$");
for (int t : tags.keys) {
	rObject o = rGetObj(mod_dir+"/"+files[0] + ".details.root", "B/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, colors[t], labels[t]);
}

draw(rGetObj(ttm_dir+"/data_slope_6.root", "c1|g_B_merged"), "p", black+0.3pt, mCi+black+1pt, "TOTEM");

limits((0, -10), (1, 40), Crop);
frame fl = Legend();

NewPad(false);
attach(shift(-5mm, 2cm)* fl);

GShipout("ttm_mod_cmp_B", hSkip=3mm);

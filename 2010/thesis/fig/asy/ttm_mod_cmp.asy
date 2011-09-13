include root;
include pad_layout;
import settings;

StdFonts();
xSizeDef = 9cm;
//ySizeDef = 8cm;

string mod_dir = "/mnt/pctotem31/software/offline/311/user/elastic_models/data";
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

NewPad("$|t|\un{GeV^2}$", "$\d\si/\d t\un{mb/GeV^2}$");
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

draw(rGetObj(ttm_dir+"/merged.root", "tc|merged_background_subtracted_unfolded"), "e", black+1pt, "TOTEM");

limits((0, 1e-5), (2.5, 1e0), Crop);
frame fl = Legend();

NewPad(false);
attach(shift(-5mm, 2cm)* fl);

GShipout("ttm_mod_cmp_dsdt", hSkip=3mm);

//----------------------------------------------------------------------------------------------------

xTicksDef = LeftTicks(Step=0.1, step=0.02);
NewPad("$|t|\un{GeV^2}$", "$B \un{GeV^{-2}}$");
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

import root;
import pad_layout;

StdFonts();


//----------------------------------------------------------------------------------------------------

string base_dir = "/mnt/pctotem31/software/offline/311/user/elastic_models/data";
string[] files = { "7000GeV_0_20_4E3" };

string[] tags = {"islam_bfkl", "islam_cgc", "ppp2", "ppp3", "bsw", "bh" };
pen[] colors = {black, black+dashed, red, red+dashed, blue, heavygreen, magenta};

string[] labelsS = {"Islam et al. (HP)", "Islam et al. (LxG)", "Petrov et al. (2P)", "Petrov et al. (3P)",
	"Bourrely et al.", "Block et al.", "Jenkovszky et al."};

//----------------------------------------------------------------------------------------------------

TGraph_reducePoints = 3;
for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$B(t)\un{GeV^{-2}}$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "B/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labelsS[t]);
	}

	limits((0, 18), (0.35, 33), Crop);
}

GShipout("ext_B", hSkip=2mm);

//----------------------------------------------------------------------------------------------------

TGraph_reducePoints = 3;
for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$C(t)\un{\%}$");
	scale(Log, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "C/" + tags[t], error=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
	}

	limits((1e-4, -5), (0.35, +2), Crop);
}

GShipout("ext_C", hSkip=2mm);

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string[] tags = {"islam", "ppp2", "ppp3", "bsw", "bh" };
pen[] colors = {black, red, red+dashed, blue, heavygreen};

string f = "../root/extrapolation_1535.root";

NewPad("$|t|_{\rm low}$", "$\de$");
for (int ti : tags.keys) {
	draw(rGetObj(f, "dev|"+tags[ti]), "l,p", colors[ti], mCi+1pt+colors[ti]);
}

limits((0.003, -3), (0.02, 1), Crop);
AttachLegend("$\be^* = 1535\ \rm m$");

//---------------

string f = "../root/extrapolation_90_ty.root";

NewPad("$|t|_{\rm low}$", "$\de$");
for (int ti : tags.keys) {
	draw(rGetObj(f, tags[ti]+"/dev"), "l,p,ieb", colors[ti], mCi+1pt+colors[ti]);
}

limits((0.04, -6), (0.08, 2), Crop);
AttachLegend("$\be^* = 90\ \rm m$");

GShipout("ext_results", hSkip=5mm);

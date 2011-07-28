import root;
import pad_layout;

StdFonts();

void DrawT30(real y)
{
	xaxis(YEquals(0, false), dotted);
	yaxis(XEquals(2e-3, false), dashed);
	label(rotate(90)*Label("1535"), (log10(2.5e-3), y));
	yaxis(XEquals(4e-2, false), dashed);
	label(rotate(90)*Label("90"), (log10(5e-2), y));
}

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
	currentpad.xSize = 9cm;
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "B/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labelsS[t]);
	}

	limits((0, 18), (0.35, 33), Crop);
	yaxis(XEquals(2e-3, false), dashed);
	label(rotate(90)*Label("1535"), (2e-3, 23), E);
	yaxis(XEquals(4e-2, false), dashed);
	label(rotate(90)*Label("90"), (4e-2, 23), E);
}

AttachLegend(N, N+0.05E);

GShipout("ext_B", hSkip=2mm);

//----------------------------------------------------------------------------------------------------

TGraph_reducePoints = 3;
for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$C(t)\un{\%}$");
	scale(Log, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "low |t| C/" + tags[t], error=false, search=false);
		if (o.valid)
			draw(yscale(100), o, colors[t], labelsS[t]);
	}

	limits((1e-3, -5), (0.35, +10), Crop);
}

DrawT30(-3);
AttachLegend();

GShipout("ext_C", hSkip=2mm);

//----------------------------------------------------------------------------------------------------

string f = "../extrapolation/SmearingTest.root";

NewPad("$|t|\un{GeV^2}$", "smearing correction$\un{\%}$");

AddToLegend("$\be^* = 1535\ \rm m$");
draw(yscale(100)*shift(0, -1), rGetObj("../extrapolation/SmearingTest_0.30.root", tags[0]+"/h_r"), blue, labelsS[0]);
draw(yscale(100)*shift(0, -1), rGetObj("../extrapolation/SmearingTest_0.30.root", tags[5]+"/h_r"), blue+dashed, labelsS[5]);

AddToLegend("$\be^* = 90\ \rm m$");
draw(yscale(100)*shift(0, -1), rGetObj("../extrapolation/SmearingTest_2.36.root", tags[0]+"/h_r"), red, labelsS[0]);
draw(yscale(100)*shift(0, -1), rGetObj("../extrapolation/SmearingTest_2.36.root", tags[5]+"/h_r"), red+dashed, labelsS[5]);

scale(Log, Linear);

limits((1e-3, -5), (0.35, 20), Crop);
DrawT30(3);

AttachLegend(NW, NW);

GShipout("ext_smearing", hSkip=2mm);

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string[] tags = {"islam", "ppp2", "ppp3", "bsw", "bh" };
pen[] colors = {black, red, red+dashed, blue, heavygreen};

string f = "../root/extrapolation_1535.root";

NewPad("$|t|_{\rm low}$", "$\de$");
currentpad.yTicks = RightTicks(Step=1,step=0.2);
for (int ti : tags.keys) {
	draw(rGetObj(f, "dev|"+tags[ti]), "l,p", colors[ti], mCi+1pt+colors[ti]);
}
	
limits((0.002, -3), (0.02, 1), Crop);
xaxis(YEquals(0, false), dotted);

AttachLegend("$\be^* = 1535\ \rm m$");

//---------------

string f = "../root/extrapolation_90_ty.root";

NewPad("$|t|_{\rm low}$", "$\de$");
for (int ti : tags.keys) {
	draw(rGetObj(f, tags[ti]+"/dev"), "l,p,ieb", colors[ti], mCi+1pt+colors[ti]);
}

limits((0.04, -6), (0.08, 2), Crop);
xaxis(YEquals(0, false), dotted);
AttachLegend("$\be^* = 90\ \rm m$");
	
GShipout("ext_results", hSkip=5mm);

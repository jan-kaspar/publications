import root;
import pad_layout;
include "../alignment/common_code.asy";

StdFonts();

string dates[] = {
	"2010_10_05",
	"2010_10_29-30"
};

TGraph_N_limit = 2000;

useDefaultLabel = false;

real s = 1/sqrt(2);
transform rot = (0, 0, s, s, -s, s);

for (int d_i: dates.keys) {
	string name = "far: y_56 vs. y_45";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y_{45} \un{mm}$", "$y_{56} \un{mm}$");
	//AddToLegend("far");
	AddToLegend(Date(dates[d_i]));
	draw(rot, rGetObj(file, name + "#1"), "p", red);
	draw(rot, rGetObj(file, name + "#3"), "p", blue);

	draw(rot, rGetObj(file, name + "#2"), "l", red);
	draw(rot, rGetObj(file, name + "#4"), "l", blue);
	draw(rot, rGetObj(file, name + "#5"), "l", heavygreen);

	limits((-12, -12), (+12, +12), Crop);
	AttachLegend("Method 4", NE, NE);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}

GShipout(hSkip=1mm, vSkip=1mm);

import root;
import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
ySizeDef = 4cm;

string dates[] = {
	"2010_10_05",
	"2010_10_29-30"
};

TGraph_N_limit = 2000;

useDefaultLabel = false;

real s = 1/sqrt(2);
transform rot = (0, 0, s, s, -s, s);

for (int d_i: dates.keys) {
	//string name_f = "far: y_56 vs. y_45, full";
	string name_c = "far: y_56 vs. y_45, cut";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y_{45} \ung{mm}$", "$y_{56} \ung{mm}$");
	//AddToLegend("far");
	AddToLegend(Date(dates[d_i]));
	//draw(rot, rGetObj(file, name_f + "#1"), "p", darkred+opacity(0.2));
	draw(rot, rGetObj(file, name_c + "#1"), "p", black);
	//draw(rot, rGetObj(file, name_f + "#3"), "p", darkred+opacity(0.2)); // blue
	draw(rot, rGetObj(file, name_c + "#3"), "p", black); // blue

	//draw(rot, rGetObj(file, name_c + "#2"), "l", red+1pt);
	//draw(rot, rGetObj(file, name_c + "#4"), "l", blue+1pt);
	draw(rot, rGetObj(file, name_c + "#5"), "l", heavygreen+1pt);

	limits((-18, -12), (+18, +12), Crop);
	AttachLegend("Method 4", NE, NE);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}

GShipout(hSkip=5mm, vSkip=1mm);

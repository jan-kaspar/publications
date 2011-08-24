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

transform switch = (0, 0, 0, 1, 1, 0);

for (int d_i: dates.keys) {
	string name = "45 far: y vs. x";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$x \un{mm}$", "$y \un{mm}$");
	draw(switch, rGetObj(file, name + "#1"), "p", black);
	draw(switch, rGetObj(file, name + "#3"), "p", black); // blue

	draw(switch, rGetObj(file, name + "#2"), "l", red+1pt);
	draw(switch, rGetObj(file, name + "#4"), "l", blue+1pt);
	draw(switch, rGetObj(file, name + "#5"), "l", heavygreen+1pt);

	limits((-5, -10), (5, 10), Crop);
	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 1", NW, NW);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}

GShipout(hSkip=5mm, vSkip=1mm);

import root;
import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = 5cm;
ySizeDef = 5cm;

string dates[] = {
	"2010_10_29-30"
};

TGraph_N_limit = 2000;
useDefaultLabel = false;

//----------------------------------------------------------------------------------------------------

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
	AttachLegend("Method 1", NE, NE);

	xaxis(YEquals(0, false), dashdotted);
	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

//----------------------------------------------------------------------------------------------------

for (int d_i: dates.keys) {
	string name = "y distributions, shift test|56 far: y distributions, shift test";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("", "$y \un{mm}$");
	scale(Linear(true), Linear);
	draw(switch, rGetObj(file, name + "|hR"), "e", red);
	draw(switch, rGetObj(file, name + "|hL"), "e", blue);
	draw(switch, rGetObj(file, name + "|hLS", error=false), "e", heavygreen);

	limits((0, -10), (1200, 10), Crop);

	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2", NE, NE);

	xaxis(YEquals(0, false), dashdotted);
	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);

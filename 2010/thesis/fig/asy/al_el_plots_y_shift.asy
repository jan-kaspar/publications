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

for (int d_i: dates.keys) {
	string name = "y distributions, shift test|56 far: y distributions, shift test";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y \un{mm}$", "");
	scale(Linear(true), Linear);
	draw(rGetObj(file, name + "|hR"), "e", red);
	draw(rGetObj(file, name + "|hL"), "e", blue);
	draw(rGetObj(file, name + "|hLS", error=false), "e", heavygreen);

	if (d_i == 0)
		limits((-12, 0), (12, 80), Crop);
	else
		limits((-9, 0), (9, 1200), Crop);

	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2", NE, NE);
}

GShipout(hSkip=5mm, vSkip=1mm);

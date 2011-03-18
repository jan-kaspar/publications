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

for (int d_i: dates.keys) {
	string name = "56 far: y distributions, shift test";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y \un{mm}$", "");
	scale(Linear(true), Linear);
	draw(rGetObj(file, name + "#0"), "e", red);
	draw(rGetObj(file, name + "#1"), "e", blue);

	if (d_i == 0)
		limits((8, 0), (12, 100));
	else
		limits((3, 0), (9, 1500));

	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2c", NE, NE);
}

GShipout(hSkip=5mm, vSkip=1mm);

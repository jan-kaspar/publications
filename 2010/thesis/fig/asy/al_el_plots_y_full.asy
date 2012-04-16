/* NOT USED

import root;
import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
ySizeDef = 4cm;

string dates[] = {
	"2010_10_05",
	"2010_10_29-30"
};

real scales[] = { 100, 1500 };

TGraph_N_limit = 2000;

useDefaultLabel = false;

for (int d_i: dates.keys) {
	string name = "56 far: y distributions";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y \ung{mm}$", "");

	draw(rGetObj(file, name + "#0"), black);
	draw(rGetObj(file, name + "#1#0"), magenta+1pt);

	limits((-12, 0), (+12, scales[d_i]), Crop);
	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2a", NW, NW);
}

GShipout(hSkip=5mm, vSkip=1mm);
*/

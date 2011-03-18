import root;
import pad_layout;
include "../alignment/common_code.asy";

StdFonts();

string dates[] = {
	"2010_10_05",
	"2010_10_29-30"
};

real scales[] = { 100, 1500 };

TGraph_N_limit = 2000;

useDefaultLabel = false;

for (int d_i: dates.keys) {
	string name = "56 far: y distributions, gauss";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y \un{mm}$", "");

	draw(rGetObj(file, name + "#0"), black);
	rObject o = rGetObj(file, name + "#1#0", error=false);
	if (o.valid) {
		draw(o, magenta+1pt);
		draw(rGetObj(file, name + "#1"), "p,ieb", mCi+1pt+heavygreen);
	}

	limits((-12, 0), (+12, scales[d_i]), Crop);

	yaxis(XEquals(-4.2, false), dotted);
	yaxis(XEquals(+4.2, false), dotted);

	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2b", NE, NE);
}

GShipout(hSkip=5mm, vSkip=1mm);

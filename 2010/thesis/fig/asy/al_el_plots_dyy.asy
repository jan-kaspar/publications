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
	string name = "45: dy vs. y";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y_N \un{mm}$", "$y_F - y_N \un{mm}$");
	draw(rGetObj(file, name + "#1"), "p", red);
	draw(rGetObj(file, name + "#3"), "p", blue);

	//draw(rGetObj(file, name + "#2"), red);
	//draw(rGetObj(file, name + "#4"), blue);
	draw(rGetObj(file, name + "#5"), black);

	limits((-12, -0.5), (+12, +0.5), Crop);
	
	AddToLegend(Date(dates[d_i]));

	AttachLegend("Method 3", NW, NW);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}


GShipout(hSkip=5mm, vSkip=1mm);

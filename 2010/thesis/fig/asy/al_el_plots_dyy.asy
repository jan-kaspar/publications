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

	NewPad("$y_{\rm N} \ung{mm}$", "$y_{\rm F} - y_{\rm N} \ung{mm}$");
	draw(rGetObj(file, name + "#1"), "p", black);
	draw(rGetObj(file, name + "#3"), "p", black); // blue

	draw(rGetObj(file, name + "#2"), red+1pt);
	draw(rGetObj(file, name + "#4"), blue+1pt);
	draw(rGetObj(file, name + "#5"), heavygreen+1pt);

	limits((-12, -0.5), (+12, +0.5), Crop);
	
	AddToLegend(Date(dates[d_i]));

	AttachLegend("Method 3", NW, NW);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}

GShipout(hSkip=5mm, vSkip=1mm);

//----------------------------------------------------------------------------------------------------

string dates[] = {
	"2010_10_29-30"
};

for (int d_i: dates.keys) {
	string name = "45: dy vs. y";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$y_{\rm N} \ung{mm}$", "$y_{\rm F} - y_{\rm N} \ung{mm}$");
	draw(rGetObj(file, name + "#1"), "p", black);
	draw(rGetObj(file, name + "#3"), "p", black); // blue

	draw(rGetObj(file, name + "#2"), red+1pt);
	draw(rGetObj(file, name + "#4"), blue+1pt);
	draw(rGetObj(file, name + "#5"), heavygreen+1pt);

	limits((-12, -0.5), (+12, +0.5), Crop);
	
	AddToLegend(Date(dates[d_i]));

	AttachLegend("Method 3", NW, NW);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}


GShipout("al_el_plots_dyy_one");

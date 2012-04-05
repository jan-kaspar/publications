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

	NewPad("$x \ung{mm}$", "$y \ung{mm}$");
	draw(switch, rGetObj(file, name + "#1"), "p", black);
	draw(switch, rGetObj(file, name + "#3"), "p", black); // blue

	//draw(switch, rGetObj(file, name + "#2"), "l", red+1pt);
	//draw(switch, rGetObj(file, name + "#4"), "l", blue+1pt);
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

	NewPad("", "$y \ung{mm}$");
	scale(Linear(true), Linear);
	draw(switch, rGetObj(file, name + "|hR"), "vl,d0", red);
	draw(switch, rGetObj(file, name + "|hL"), "vl,d0", blue);
	draw(switch, rGetObj(file, name + "|hLS", error=false), "vl,d0", heavygreen);

	limits((0, -10), (1200, 10), Crop);

	AddToLegend(Date(dates[d_i]));
	AttachLegend("Method 2", NE, NE);

	xaxis(YEquals(0, false), dashdotted);
	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

//----------------------------------------------------------------------------------------------------

GShipout(hSkip=5mm, vSkip=1mm);

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

for (int d_i: dates.keys) {
	string name = "45 far: y vs. x";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$x \ung{mm}$", "$y \ung{mm}$");
	draw(switch, rGetObj(file, name + "#1"), "p", black);
	draw(switch, rGetObj(file, name + "#3"), "p", black); // blue

	//draw(switch, rGetObj(file, name + "#5"), "l", magenta+1pt);

	limits((-5, -10), (5, 10), Crop);
	AddToLegend(Date(dates[d_i]));
	//AttachLegend("Method 1", NE, NE);

	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

draw((-3, 1)--(-3, 3.2), EndArrow);
label("sensor edges", (-4.5, 0), E);
draw((-3, -1)--(-3, -3.2), EndArrow);

//----------------------------------------------------------------------------------------------------

for (int d_i: dates.keys) {
	string name = "y distributions, shift test|56 far: y distributions, shift test";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("", "$y \ung{mm}$");
	scale(Linear(true), Linear);
	draw(switch, rGetObj(file, name + "|hR"), "vl,d0", red);
	draw(switch, rGetObj(file, name + "|hL"), "vl,d0", blue);
	draw(shift(0, 0.5)*switch, rGetObj(file, name + "|hLS", error=false), "vl,d0", black);
	draw(switch, rGetObj(file, name + "|hLS", error=false), "vl,d0", heavygreen);

	limits((0, -10), (1200, 10), Crop);

	AddToLegend(Date(dates[d_i]));
	//AttachLegend("Method 2", NE, NE);

	xaxis(YEquals(0, false), dashdotted);
	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

label("vertical beam position", (600, 0), N);

real y1 = 3.4, y2 = 4.3;
filldraw((0, y1)--(1200, y1)--(1200, y2)--(0, y2)--cycle, black+opacity(0.2), nullpen);
filldraw((0, -y1)--(1200, -y1)--(1200, -y2)--(0, -y2)--cycle, black+opacity(0.2), nullpen);

label("removed band", (800, y2), N);

//----------------------------------------------------------------------------------------------------

for (int d_i: dates.keys) {
	string name = "45 far: y vs. x";
	string file = "../alignment/elastic/"+dates[d_i]+"/alignment_analysis.root";
	write(dates[d_i]);

	NewPad("$x \ung{mm}$", "$y \ung{mm}$");
	draw(switch, rGetObj(file, name + "#1"), "p", black);
	draw(switch, rGetObj(file, name + "#3"), "p", black); // blue

	draw(switch, rGetObj(file, name + "#5"), "l", magenta+1pt);

	limits((-5, -10), (5, 10), Crop);
	AddToLegend(Date(dates[d_i]));
	//AttachLegend("Method 1", NE, NE);

	xaxis(YEquals(0, false), dashdotted);
	xaxis(YEquals(-3.36, false), dotted);
	xaxis(YEquals(+3.42, false), dotted);
}

dotfactor = 10;
dot((0, 0), magenta);
label("beam position", (0, 0), NE);

//----------------------------------------------------------------------------------------------------

GShipout("al_el_plots_sum_slides", hSkip=5mm, vSkip=1mm);

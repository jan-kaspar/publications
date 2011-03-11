import root;
import pad_layout;

StdFonts();

string file = "../alignment/elastic/2010_09_21/alignment_plots.root";
int reduceHits = 1;

useDefaultLabel = false;

string sectors[] = { "45" };
string units[] = { "far" };
string coords[] = { "y" };

transform switch = (0, 0, 0, 1, 1, 0);


// ----- y vs. x plots -----
for (int s: sectors.keys) {
	for (int u: units.keys) {
		string label = sectors[s] + " " + units[u];
		string name = label + ": y vs. x";
		write(name);
	
		NewPad("$x \un{mm}$", "$y \un{mm}$");
		TGraph_reducePoints = reduceHits;
		draw(switch, rGetObj(file, name + "#1"), "p", red);
		draw(switch, rGetObj(file, name + "#3"), "p", blue);

		TGraph_reducePoints = 1;
		draw(switch, rGetObj(file, name + "#2"), "l", red);
		draw(switch, rGetObj(file, name + "#4"), "l", blue);
		draw(switch, rGetObj(file, name + "#5"), "l", heavygreen);

		limits((-5, -10), (5, 10), Crop);
		AddToLegend(label);
		AttachLegend("method 1", NW, NW);
		xaxis(YEquals(0, false), gray+dotted);
		yaxis(XEquals(0, false), gray+dotted);
	}

	//NewRow();
}

//NewPage();


// ----- dy vs. y plots ------
for (int s: sectors.keys) {
	for (int c: coords.keys) {
		string label = sectors[s];
		string co = coords[c];
		string name = label + ": d" + co + " vs. " + co;
		write(name);
	
		NewPad("$" + co + "_N \un{mm}$", "$" + co + "_F - "+co+"_N \un{mm}$");
		TGraph_reducePoints = reduceHits;
		draw(rGetObj(file, name + "#1"), "p", red);
		draw(rGetObj(file, name + "#3"), "p", blue);

		TGraph_reducePoints = 1;
		draw(rGetObj(file, name + "#2"), red);
		draw(rGetObj(file, name + "#4"), blue);
		draw(rGetObj(file, name + "#5"), heavygreen);

		limits((-10, -0.5), (+10, +0.5), Crop);
		AddToLegend(label);
		AttachLegend("method 2", NW, NW);
		xaxis(YEquals(0, false), gray+dotted);
		yaxis(XEquals(0, false), gray+dotted);
	}

	//NewRow();
}

//NewPage();
NewRow();


// ----- y_56 vs. y_45 plots ------
real s = 1/sqrt(2);
transform rot = (0, 0, s, s, -s, s);

for (int c: coords.keys) {
	string co = coords[c];

	for (int u: units.keys) {
		string un = units[u];
		string name = un+": "+co+"_56 vs. "+co+"_45";
		write(name);
	
		NewPad("$" + co + "_{45} \un{mm}$", "$"+co+"_{56} \un{mm}$");
		AddToLegend(un + " units");
		TGraph_reducePoints = reduceHits;
		draw(rot, rGetObj(file, name + "#1"), "p", red);
		draw(rot, rGetObj(file, name + "#3"), "p", blue);

		TGraph_reducePoints = 1;
		draw(rot, rGetObj(file, name + "#2"), "l", red);
		draw(rot, rGetObj(file, name + "#4"), "l", blue);
		draw(rot, rGetObj(file, name + "#5"), "l", heavygreen);

		draw((-15, +15)--(+15, -15), gray+dotted);

		limits((-10, -10), (+10, +10), Crop);
		AttachLegend("method 3", NE, NE);
	}

	//NewRow();
}

/*
NewPage();

for (int c: coords.keys) {
	string co = coords[c];
	write("d"+co+"_{56} vs. d"+co+"_{45}");

	NewPad("$\De_{F-N}" +co+ "_{45} \un{mm}$", "$\De_{F-N}"+co+"_{56} \un{mm}$");
	if (c == 0) {
		AddToLegend("diagonal 56 top", blue);
		AddToLegend("diagonal 56 bottom", red);
	}
	TGraph_reducePoints = reduceHits;
	draw(rGetObj(file, "d"+co+"_56 vs. d"+co+"_45" + "#1"), "p", blue);
	draw(rGetObj(file, "d"+co+"_56 vs. d"+co+"_45" + "#2"), "p", red);
	AttachLegend(NE, NE);
	xaxis(YEquals(0, false), gray+dotted);
	yaxis(XEquals(0, false), gray+dotted);
}
*/

//NewPage();

// ----- y distributions  ------
for (int s: sectors.keys) {
	for (int u: units.keys) {
		string label = sectors[s] + " " + units[u];
		string name = label + ": y distributions";
		write(name);
	
		NewPad("$y \un{mm}$", "");
		//scale(Linear, Linear(true));
		draw(rGetObj(file, name + "#0"), black);
		draw(rGetObj(file, name + "#1#0"), magenta);
		limits((-10, 0), (+10, 250), Crop);
		AddToLegend(label);
		AttachLegend("method 4", NW, NW);
		//yaxis(XEquals(0, false), gray+dotted);
	}

	//NewRow();
}

GShipout(hSkip=1mm, vSkip=1mm);

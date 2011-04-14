include root;
include pad_layout;

StdFonts();

string base_dir = "/mnt/pctotem31/software/offline/311/user/elastic_models/data";

string[] files = {
	"3500GeV_0_20_1E4", 
//	"7000GeV_0_20_4E3", 
};

string[] flabels = {
	"$\sqrt s = 7\,{\rm TeV}$",
	"$\sqrt s = 14\,{\rm TeV}$",
};
	
string[] tags = {"islam_bfkl", "islam_cgc", "ppp2", "ppp3", "bsw", "bh"};
pen[] colors = {black, black+dashed, red, red+dashed, blue, heavygreen};
string[] labels = {"Islam et al. (BFKL)", "Islam et al. (CGC)", "Petrov-Predazzi-Prokudin, 2 pomerons", "Petrov-Predazzi-Prokudin, 3 pomerons",
	"Bourrely-Soffer-Wu", "Block-Halzen"};

//----------------------------------------------------------------------------------------------------

void DrawOptimized(real min, real max, real yScale, rObject obj, pen p, string label = "")
{
	//draw(yscale(yScale), o, p, label);
	int N = obj.iExec("GetN");
	guide g;

	bool inRange = false;
	for (int i = 0; i < N; ++i) {
		real[] x = {0};
		real[] y = {0};
		obj.vExec("GetPoint", i, x, y);
		real yy = yScale*y[0];
	
		if (yy >= min && yy <= max) {
			g = g--Scale((x[0], yy));
			inRange = true;
		} else {
			if (inRange) {
				draw(g, p, label);
				label = "";
				g = nullpath;
			}
			inRange = false;
		}
	}
	
	if (inRange)
		draw(g, p, label);
}

//----------------------------------------------------------------------------------------------------

void DrawLegend(string label="", pair al=NE)
{
	currentpicture.legend.delete();
	/*
	for (int i : tags.keys)
		AddToLegend(labels[i], colors[i]);
	*/
	AttachLegend(label, al, al);
}

//----------------------------------------------------------------------------------------------------


// ---------- sigma large -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=2, step=0.5);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\d\si/\d t\un{mb/GeV^2}$");
	scale(Linear, Log);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".root", "differential cross section/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labels[t]);
	}

	limits((0, 1e-15), (20, 1e3), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_dsdt_large");

// ---------- sigma narrow -----------

TGraph_reducePoints = 1;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\d\si/\d t\un{mb/GeV^2}$");
	scale(Linear, Log);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".root", "differential cross section/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labels[t]);
	}

	limits((0, 1e-7), (5, 1e3), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_dsdt_narrow");

// ---------- B -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$B(t)\un{GeV^{-2}}$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "B/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labels[t]);
	}

	limits((0, -10), (5, 30), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_B");


// ---------- phase -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\hbox{phase}\un{\pi}$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "phase/PH/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(0.01, 1.99, 1/3.141593, o, colors[t]);
	}

	limits((0, 0), (5, +2), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_phase");


// ---------- rho -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\rh(t)$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "rho/PH/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(-6.5, +6.5, 1, o, colors[t]);
	}

	limits((0, -6), (5, +6), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_rho");

// ---------- R -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$R(t)$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "R/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(-6.5, +6.5, 1, o, colors[t]);
	}

	limits((0, -0.2), (5, +0.1), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_R");

// ---------- Z -----------

TGraph_reducePoints = 10;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$Z(t)$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "Z/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(-6.5, +6.5, 1, o, colors[t]);
	}

	limits((0, -0.2), (5, +0.1), Crop);
		
	DrawLegend(flabels[f]);
}

GShipout("el_mod_Z");

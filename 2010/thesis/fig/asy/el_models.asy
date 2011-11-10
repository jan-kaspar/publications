include root;
include pad_layout;

StdFonts();
xSizeDef = 6.1cm;
ySizeDef = 6.1cm;

string base_dir = "../elastic_models/data";

string[] files = {
	"3500GeV_0_20_4E3", 
	"7000GeV_0_20_4E3", 
};

string[] flabels = {
	"$\sqrt s = 7\,{\rm TeV}$",
	"$\sqrt s = 14\,{\rm TeV}$",
};
	
string[] tags = {"islam_bfkl", "islam_cgc", "ppp2", "ppp3", "bsw", "bh" };
pen[] colors = {black, black+dashed, red, red+dashed, blue, heavygreen, magenta};
string[] labels = {"Islam et al. (HP)", "Islam et al. (LxG)", "Petrov-Predazzi-Prokudin, 2 pomerons", "Petrov-Predazzi-Prokudin, 3 pomerons",
	"Bourrely-Soffer-Wu", "Block-Halzen", "Jenkovszky et al."};

string[] labelsS = {"Islam et al. (HP)", "Islam et al. (LxG)", "Petrov et al. (2P)", "Petrov et al. (3P)",
	"Bourrely et al.", "Block et al.", "Jenkovszky et al."};

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

void AdjustPlot(int f, bool l=false, pair alig=NE)
{
	if (f > 0)
		currentpad.yLabel = "";

	currentpicture.legend.delete();

	if (l) {
		if (f == 0) {
			AddToLegend(labelsS[0], colors[0]);
			AddToLegend(labelsS[1], colors[1]);
			AddToLegend(labelsS[4], colors[4]);
		} else {
			AddToLegend(labelsS[2], colors[2]);
			AddToLegend(labelsS[3], colors[3]);
			AddToLegend(labelsS[5], colors[5]);
		}
	}

	AttachLegend(flabels[f], alig, alig);
}

//----------------------------------------------------------------------------------------------------


// ---------- sigma large -----------

TGraph_reducePoints = 3;
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
		
	AdjustPlot(f, true);
}

GShipout("el_mod_dsdt_large", hSkip=2mm);

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
		
	AdjustPlot(f, true);
}

GShipout("el_mod_dsdt_narrow", hSkip=2mm);

// ---------- B -----------

TGraph_reducePoints = 3;
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
	xaxis(YEquals(0, false), dotted);
		
	AdjustPlot(f, true);
}

GShipout("el_mod_B", hSkip=2mm);


// ---------- phase -----------

TGraph_reducePoints = 3;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\arg F(t)/\pi$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "phase/PH/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(0.01, 1.99, 1/3.141593, o, colors[t]);
	}

	limits((0, 0), (5, +2), Crop);
		
	AdjustPlot(f);
}

GShipout("el_mod_phase", hSkip=2mm);


// ---------- rho -----------

TGraph_reducePoints = 1;
xTicksDef = LeftTicks(Step=1, step=0.2);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$\rh(t)$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "rho/PH/" + tags[t], error=false);
		if (o.valid)
			DrawOptimized(-8, +8, 1, o, colors[t]);
	}

	limits((0, -6), (5, +6), Crop);
		
	AdjustPlot(f);
}

GShipout("el_mod_rho", hSkip=2mm);

// ---------- Z -----------

ySizeDef = 5.5cm;
TGraph_reducePoints = 1;
//xTicksDef = LeftTicks();
xTicksDef = LeftTicks(Step=1, step=0.2);
yTicksDef = RightTicks(Step=2, step=1);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$Z(t)\un{\%}$");
	scale(Linear, Linear);

	for (int t : tags.keys) {
		//TGraph_lowLimit = 5e-2; TGraph_highLimit = +inf;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "Z/" + tags[t], error=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
		/*
		TGraph_lowLimit = -inf; TGraph_highLimit = 1e-1;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "low |t| Z/" + tags[t], error=false, search=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
		*/
	}

	limits((0, -16), (5, +2), Crop);
		
	AdjustPlot(f, true, SE);
}

GShipout("el_mod_Z", hSkip=10mm);

// ---------- C -----------

TGraph_reducePoints = 1;
xTicksDef = LeftTicks();
//xTicksDef = LeftTicks(Step=1, step=0.2);
yTicksDef = RightTicks(Step=2, step=1);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$C(t)\un{\%}$");
	scale(Log, Linear);

	for (int t : tags.keys) {
		TGraph_lowLimit = 5e-2; TGraph_highLimit = +inf;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "C/" + tags[t], error=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
		
		TGraph_lowLimit = -inf; TGraph_highLimit = 1e-1;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "low |t| C/" + tags[t], error=false, search=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
	}

	limits((1e-3, -12), (5, +2), Crop);
		
	AdjustPlot(f, true, SW);
}

GShipout("el_mod_C", hSkip=10mm);

// ---------- R -----------

TGraph_reducePoints = 1;
xTicksDef = LeftTicks();
//xTicksDef = LeftTicks(Step=1, step=0.2);
yTicksDef = RightTicks(Step=3, step=1);
for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\un{GeV^2}$", "$R(t)\un{\%}$");
	scale(Log, Linear);

	for (int t : tags.keys) {
		TGraph_lowLimit = 5e-2; TGraph_highLimit = +inf;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "R/" + tags[t], error=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
		
		TGraph_lowLimit = -inf; TGraph_highLimit = 1e-1;
		rObject o = rGetObj(base_dir+"/"+files[f] + ".details.root", "low |t| R/" + tags[t], error=false, search=false);
		if (o.valid)
			draw(yscale(100), o, colors[t]);
	}

	limits((1e-3, -27), (5, +3), Crop);
		
	AdjustPlot(f, true, SW);
}

GShipout("el_mod_R", hSkip=10mm);

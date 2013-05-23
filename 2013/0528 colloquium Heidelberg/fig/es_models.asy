include root;
include pad_layout;

StdFonts();
xSizeDef = 6.1cm;
ySizeDef = 6.1cm;

string base_dir = "/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/src/IOMC/Elegent/data";

string[] files = {
	"3500GeV_0_20_4E3", 
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

void AdjustPlot(int f, bool l=false, pair alig=NE, bool eraseYLabel=true, real legLineLength=1cm)
{
	if (f > 0 && eraseYLabel)
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

	//AttachLegend(flabels[f], alig, alig);
	add(BuildLegend(flabels[f], legLineLength, alig), point(alig), Fill(white));
}

//----------------------------------------------------------------------------------------------------


// ---------- sigma large -----------

TGraph_reducePoints = 3;
xTicksDef = LeftTicks(Step=2, step=0.5);

for (int f = 0; f < files.length; ++f) {
	NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 8cm, 8cm);
	scale(Linear, Log);

	for (int t : tags.keys) {
		rObject o = rGetObj(base_dir+"/"+files[f] + ".root", "differential cross section/PH/" + tags[t], error=false);
		if (o.valid)
			draw(o, colors[t], labelsS[t]);
	}

	limits((0, 1e-12), (10, 1e3), Crop);
		
	//AdjustPlot(f, true);
	AttachLegend();
}


NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 8cm, 8cm);
scale(Linear, Log);

int f = 0, t = 0;
rObject o = rGetObj(base_dir+"/"+files[f] + ".root", "differential cross section/PH/" + tags[t], error=false);
if (o.valid)
	draw(o, colors[t], labelsS[t]);

draw(Label("diffraction/Pomeron exchange", 1, E), (0.5, 0.5)--(2, 0.5), BeginArrow);

draw(Label("TODO", 1, S), (2, -4)--(2, -7), BeginArrow);

draw(Label("parton scattering/pQCD", 1, S), (7, -7.2)--(7, -10), BeginArrow);

limits((0, 1e-12), (10, 1e3), Crop);
AttachLegend();




GShipout("es_models");


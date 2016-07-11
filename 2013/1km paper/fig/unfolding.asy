import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis/";

string diagonals[] = { "45t_56b" };
string diagonal_labels[] = { "45t -- 56b" };

string model = "new_fit:2,KL,con-g_fit";

string extensions[] = {
//	"x+1",
//	"x-1",
//	"y+1",
//	"y-1",
};

xSizeDef = 10cm;
ySizeDef = 6cm;

//TGraph_x_min = 6e-4;

//----------------------------------------------------------------------------------------------------

for (int dgni : diagonals.keys)
{
	string dir = topDir + "unsmearing_correction/numerical_integration/DS2b," + diagonals[dgni] + "/" + model;
	
	NewPad("$|t|\ung{GeV^2}$", "unfolding correction $\cal U$");
	currentpad.xTicks = LeftTicks(0.002, 0.001);
	currentpad.yTicks = RightTicks(0.005, 0.001);

	draw(rGetObj(dir + "/numerical_integration.root", "unsm_corr"), red+1pt, "central");

	for (int ei : extensions.keys)
	{
		string f_ni = dir + "/numerical_integration_" + extensions[ei] + ".root";
		draw(rGetObj(f_ni, "unsm_corr"), StdPen(ei+1), replace(extensions[ei], "_", "\_"));
	}

	limits((0.000, 0.975), (0.01, 1.005), Crop);

	for (real y = 0.975; y <= 1.005; y += 0.005)
		xaxis(YEquals(y, false), (fabs(y - 1.) < 1e-4) ? dotted : dotted);

	for (real x = 0.000; x <= 0.01; x += 0.002)
		yaxis(XEquals(x, false), dotted);

	yaxis(XEquals(6e-4, false), dashed);

	//AttachLegend(diagonal_labels[dgni], SE, SE);
}


GShipout(margin=0pt);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string topDir = "../analysis/";

string f = topDir + "/acceptance_correction/dist_diffRL_th_y/fit.root";

string datasets[] = {
/*
	"DS2",
	"DS3",
*/

	"DS4-b648-time20-21",
//	"DS4-b648-time25-26",
	"DS4-b648-time30-31",

/*
	"DS4-b2990-time20-21",
	"DS4-b2990-time25-26",
	"DS4-b2990-time30-31",
	
	"DS4-b26-time30-31",
*/
};

string diagonals[] = {
//	"45b_56t",
	"45t_56b"
};

//----------------------------------------------------------------------------------------------------

xSizeDef = 7cm;
ySizeDef = 4.5cm;

//----------------------------------------------------------------------------------------------------

void DrawFitFunction(rObject obj, real norm, string label, pen p, bool addFitStat=true)
{
	int ndf = obj.iExec("GetNDF");
	real chi2 = obj.rExec("GetChisquare");

	if (addFitStat)
		label += format(", $\ch^2/\hbox{ndf} = %#.2f$", chi2/ndf);

	transform tr = scale(1e6, norm);
	if (currentpicture.scale.y.scale.logarithmic)
		tr = scale(1e6, 1.)*shift(0., log10(norm));

	draw(tr, obj, p, label);
}

//----------------------------------------------------------------------------------------------------

for (int dgni : diagonals.keys)
{
	NewPad("$\theta_y^{*R} - \theta_y^{*L} \ung{\mu rad}$");
	scale(Linear, Log);	

	for (int dsi : datasets.keys)
	{
		string dir = datasets[dsi] + ", " + diagonals[dgni];

		real scale = 0.1^dsi;

		pen p = StdPen(dsi + 1);

		rObject h = rGetObj(f, dir+"/th_y_diffLR_safe");
		real entries = h.rExec("GetEntries");
		draw(scale(1e6, 1.)*shift(0., -log10(entries) - dsi), h, "eb", p);

		//DrawFitFunction(rGetObj(f, dir+"/f_gaus_nom"), 1./entries * scale, "Gauss, $\si$=RMS, norm.~from hist.~entries", red+dashed, false);
		DrawFitFunction(rGetObj(f, dir+"/f_gaus"), 1./entries * scale, "Gauss", p);
		//DrawFitFunction(rGetObj(f, dir+"/f_dgaus"), 1./entries, "Gauss + Gauss", heavygreen);
	}

	limits((-15, 1e1), (+15, 2e5), Crop);
	//AttachLegend(NW, NE);
}

GShipout(margin=0mm, vSkip=0pt);

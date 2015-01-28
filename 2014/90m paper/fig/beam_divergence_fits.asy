import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");

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

//xSizeDef = 7cm;
//ySizeDef = 4.5cm;
xSizeDef = 10cm;
ySizeDef = 6cm;

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
	NewPad("$\theta_y^{*\rm R} - \theta_y^{*\rm L} \ung{\mu rad}$", "events per bin");
	scale(Linear, Log);	

	for (int dsi : datasets.keys)
	{
		string dir = datasets[dsi] + ", " + diagonals[dgni];

		real scale = 0.1^dsi;

		pen p = StdPen(dsi + 1);

		rObject h = rGetObj(f, dir+"/th_y_diffLR_safe");
		real entries = h.rExec("GetEntries");
		real binWidth = h.rExec("GetBinWidth", 1);
		draw(scale(1e6, 1.)*shift(0., log10(binWidth) - dsi), h, "eb", p);

		//DrawFitFunction(rGetObj(f, dir+"/f_gaus_nom"), 1./entries * scale, "Gauss, $\si$=RMS, norm.~from hist.~entries", red+dashed, false);
		//DrawFitFunction(rGetObj(f, dir+"/f_gaus"), 1./entries * scale, "Gauss", p);
		DrawFitFunction(rGetObj(f, dir+"/f_gaus"), binWidth * scale, "Gauss", p);
		//DrawFitFunction(rGetObj(f, dir+"/f_dgaus"), 1./entries, "Gauss + Gauss", heavygreen);

		// check
		int nb = h.iExec("GetNbinsX");
		real sum = 0;
		for (int bi = 1; bi <= nb; ++bi)
		{
			sum += h.rExec("GetBinContent", bi) * binWidth;
		}

		write(format("entries = %.1f", entries) + format(", sum = %.1f", sum));
	}

	limits((-15, 6e-2), (+15, 2e3), Crop);
	//AttachLegend(NW, NE);
}

GShipout(margin=0mm, vSkip=0pt);

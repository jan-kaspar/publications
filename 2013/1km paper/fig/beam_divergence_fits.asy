import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis/";

string f = topDir + "/beam_divergence/dist_diffRL_th_y/fit.root";

string datasets[] = {
	"DS2a-b100, 23-24",
	"DS2b-b100, 30-31",
};

string diagonals[] = {
//	"45b_56t",
	"45t_56b"
};

//----------------------------------------------------------------------------------------------------

xSizeDef = 6.5cm;
ySizeDef = 4.5cm;

//----------------------------------------------------------------------------------------------------

void DrawFitFunction(RootObject obj, real norm, string label, pen p, bool addFitStat=true)
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

		RootObject h = RootGetObject(f, dir+"/th_y_diffLR_safe");
		real entries = h.rExec("GetEntries");
		real binWidth = h.rExec("GetBinWidth", 1);
		draw(scale(1e6, 1.)*shift(0., log10(binWidth) - dsi), h, "eb", p);

		//DrawFitFunction(RootGetObject(f, dir+"/f_gaus_nom"), 1./entries * scale, "Gauss, $\si$=RMS, norm.~from hist.~entries", red+dashed, false);
		//DrawFitFunction(RootGetObject(f, dir+"/f_gaus"), 1./entries * scale, "Gauss", p);
		DrawFitFunction(RootGetObject(f, dir+"/f_gaus"), binWidth * scale, "Gauss", p);
		//DrawFitFunction(RootGetObject(f, dir+"/f_dgaus"), 1./entries, "Gauss + Gauss", heavygreen);

		// check
		int nb = h.iExec("GetNbinsX");
		real sum = 0;
		for (int bi = 1; bi <= nb; ++bi)
		{
			sum += h.rExec("GetBinContent", bi) * binWidth;
		}

		write(format("entries = %.1f", entries) + format(", sum = %.1f", sum));
	}

	limits((-4, 6e-2), (+4, 2e3), Crop);
	//AttachLegend(NW, NE);

	for (real x = -4; x <= 4; x += 1)
		yaxis(XEquals(x, false), dotted);

	for (real y = -1; y <= 3; y += 1)
		xaxis(YEquals(10^y, false), dotted);
}

GShipout(margin=0mm, vSkip=0pt);

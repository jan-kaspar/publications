import root;
import pad_layout;

include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/plots/base.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

texpreamble("\def\fbox#1#2#3#4{
\hbox to 1.4cm{\hfil#2\hfil}%
\hbox to 1.4cm{\hfil#3\hfil}%
\hbox to 1.4cm{\hfil#4\hfil}%
}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/";

string fits[] = {
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:3,KL,con,chisq,,st+sy_noNorm",
	//"1000-ob-0-1,90-DS4-sc-ob/pervojsep-1000,v,v,v,v-all,v,v,f,v:3,KL,per-jun15,chisq,,st+sy_noNorm",
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:3,KL,per-jun15,chisq,,st+sy_noNorm",
};

pen fitPens[] = {
	black,
	//red,
	blue
};

string fitLabels[] = {
	"Cahn/KL, constant",
	//"Cahn/KL, mid-peripheral",
	"Cahn/KL, peripheral",
};

drawGridDef = true;

xSizeDef = 6.9cm;
ySizeDef = 6cm;

//-----------------------------------------------------------------------------------------------------

void PlotOneFit(string dir, string desc, pen p)
{
	// ----- results file ------

	Results ra[] = { new Results };
	int ret = ParseData(dir + "/fit.out", ra);
	if (ret != 0 || ! ra[0].Valid())
		return;

	// ----- ROOT file -----

	string f = dir + "/impactParameterDistributions.root";

	RootObject g_prf_sq = RootGetObject(f, "g_A_mod2");
	draw(g_prf_sq, p, desc+":");
	AddToLegend("\fbox{}{"
		+ format("$%#.2f\un{fm}$", ra[0].b_rms_el) + "}{"
		+ format("$%#.2f\un{fm}$", ra[0].b_rms_inel) + "}{"
		+ format("$%#.2f\un{fm}$", ra[0].b_rms_tot) + "}"
	);

	//real b_rms_el, b_rms_inel, b_rms_tot;

	/*
	AddToLegend(format("$\sqrt{\langle b^2 \rangle_{\rm el}} = %#.2f\un{fm}$", ra[0].b_rms_el));
	AddToLegend(format("$\sqrt{\langle b^2 \rangle_{\rm inel}} = %#.2f\un{fm}$", ra[0].b_rms_inel));
	AddToLegend(format("$\sqrt{\langle b^2 \rangle_{\rm tot}} = %#.2f\un{fm}$", ra[0].b_rms_tot));
	*/
}

//----------------------------------------------------------------------------------------------------

bool fitStSy = true;

NewPad("$b\ung{fm}$", "$|{\cal P}(b)|^2$");
currentpad.xTicks = LeftTicks(0.5, 0.1);
currentpad.yTicks = RightTicks(0.05, 0.01);

AddToLegend("\fbox{}{$\sqrt{\langle b^2 \rangle_{\rm el}}$}{$\sqrt{\langle b^2 \rangle_{\rm inel}}$}{$\sqrt{\langle b^2 \rangle_{\rm tot}}$}");

for (int fi : fits.keys)
{
	pen p = fitPens[fi] + 1pt;
	
	PlotOneFit(topDir + "/data/" + fits[fi], fitLabels[fi], p);
}

limits((0, 0), (3, 0.32), Crop);
AttachLegend(BuildLegend(NE, lineLength=6mm), NE);

		
GShipout(vSkip=0mm, margin=1mm);

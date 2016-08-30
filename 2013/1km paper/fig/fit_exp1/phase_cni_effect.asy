import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/";

string fits[] = {
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:1,KL,con,chisq,,st+sy_noNorm",
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:1,SWY,con,chisq,,st+sy_noNorm",
	//"1000-ob-0-1,90-DS4-sc-ob/pervojsep-1000,v,v,v,v-all,v,v,f,v:1,KL,per-jun15,chisq,,st+sy_noNorm",
	"1000-ob-0-1,90-DS4-sc-ob/simsep-1000,v,v,v-all,v,v,f:3,KL,per-jun15,chisq,,st+sy_noNorm",
};

pen fitPens[] = {
	black,
	magenta+dashed,
	//red,
	blue
};

string fitLabels[] = {
	"Cahn/KL, constant",
	"SWY, constant",
	//"Cahn/KL, mid-peripheral",
	"Cahn/KL, peripheral",
};

drawGridDef = true;

xSizeDef = 6cm;
ySizeDef = 4.0cm;

//-----------------------------------------------------------------------------------------------------

pad p_phase = NewPad("$|t|\ung{GeV^2}$", "$\arg {\cal A}^{\rm N}\ung{\pi}$");

pad p_cni_effect = NewPad("$|t|\ung{GeV^2}$", "$\displaystyle {\d\si^{\rm C+N}/\d t - \d\si^{\rm N}/\d t \over \d\si^{\rm N}/\d t}$");
p_cni_effect.xTicks = LeftTicks(0.05, 0.01);
p_cni_effect.yTicks = RightTicks(0.01, 0.005);

//-----------------------------------------------------------------------------------------------------

void PlotPhase(RootObject o, pen p, string label="")
{
	if (!o.valid)
		return;

	guide g;

	int N = o.iExec("GetN");
	real sh = 0;
	real prev_y = 0;
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya[] = {0.};
		o.vExec("GetPoint", i, xa, ya);
		real x = xa[0];
		real y = ya[0];

		real th = 4;
		if (i > 0)
		{
			if (y - prev_y > th)
				sh -= 2pi;
			if (y - prev_y < -th)
				sh += 2pi;
		}
	
		g = g -- (x, y+sh);

		prev_y = y;
	}

	draw(scale(1, 1./pi) * g, p, label);
}

//-----------------------------------------------------------------------------------------------------

void PlotEffect(RootObject g_CH, RootObject g_H, pen p, string label="")
{
	guide g;
	int N = g_CH.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya_CH[] = {0.};
		real ya_H[] = {0.};
		g_CH.vExec("GetPoint", i, xa, ya_CH);
		g_H.vExec("GetPoint", i, xa, ya_H);
		
		real eff = (ya_CH[0] - ya_H[0]) / ya_H[0];

		g = g -- (xa[0], eff);
	}
	
	draw(g, p, label);
}

//-----------------------------------------------------------------------------------------------------

void PlotOneFit(string dir, string desc, pen p)
{
	// ----- ROOT file -----
	string f = dir + "/fit.root";

	RootObject g_fit_CH = RootGetObject(f, "g_fit_CH", error=false);
	RootObject g_fit_H = RootGetObject(f, "g_fit_H", error=false);
	RootObject g_Phase_H = RootGetObject(f, "g_Phase_H", error=false);

	if (!g_fit_CH.valid)
		return;

	SetPad(p_phase);
	PlotPhase(g_Phase_H, p, desc);
	
	SetPad(p_cni_effect);
	PlotEffect(g_fit_CH, g_fit_H, p, desc);
}

//----------------------------------------------------------------------------------------------------

for (int fi : fits.keys)
{
	pen p = fitPens[fi] + 1pt;

	PlotOneFit(topDir + "/data/" + fits[fi], "nuclear phase: " + fitLabels[fi], p);
}

//----------------------------------------------------------------------------------------------------

SetPad(p_phase);
limits((0, -1), (0.8, 1), Crop);

SetPad(p_cni_effect);
limits((0, -0.03), (0.2, 0.05), Crop);

//----------------------------------------------------------------------------------------------------
		
GShipout(hSkip=3mm, vSkip=0mm, margin=0mm);

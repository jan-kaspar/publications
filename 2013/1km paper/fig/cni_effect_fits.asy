import pad_layout;
import root;

//include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/coulomb_analysis/exploration/common_code.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis_combined/coulomb_analysis/";

xSizeDef = 8cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------

void PlotEffGraph(rObject g_CH, rObject g_H, pen p, string label)
{
	guide g;

	int N = g_CH.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya[] = {0.};
		
		g_CH.vExec("GetPoint", i, xa, ya);
		real t = xa[0];
		real cs_CH = ya[0];
		
		g_H.vExec("GetPoint", i, xa, ya);
		real cs_H = ya[0];

		if (t > TGraph_x_max)
			continue;
	
		real eff = (cs_CH - cs_H) / cs_H;
	
		g = g -- Scale((t, eff));
	}

	draw(g, p, label);
}

//----------------------------------------------------------------------------------------------------

void PlotPhase(rObject o, pen p, string label="")
{
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

	draw(g, p, label);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

bool plotPhase = true;

pad pPhase, pEffect;

void InitPlots()
{
	if (plotPhase)
		pPhase = NewPad("$|t|\ung{GeV^2}$", "$\arg {\cal A^{\rm N}}$");

	pEffect = NewPad("$|t|\ung{GeV^2}$", "$\displaystyle {\d\si^{\rm C+N}/\d t - \d\si^{\rm N}/\d t \over \d\si^{\rm N}/\d t}$");
	currentpad.xTicks = LeftTicks(0.05, 0.01);
	currentpad.yTicks = RightTicks(0.01, 0.005);
}

//----------------------------------------------------------------------------------------------------

void FinalisePlots()
{
	if (plotPhase)
	{
		SetPad(pPhase);
		limits((0, -4), (0.8, 2), Crop);
	}

	SetPad(pEffect);
	limits((0, -0.05), (0.2, 0.05), Crop);

	for (real x=0.; x <= 0.2; x += 0.05)
		yaxis(XEquals(x, false), dotted);

	for (real y=-0.05; y <= 0.05; y += 0.01)
		xaxis(YEquals(y, false), dotted);

	AttachLegend(NW, NE);
}

//----------------------------------------------------------------------------------------------------

void PlotCurve(string option, pen p, string label)
{
	string fn = topDir + "data/" + option + "/fit.root";

	if (plotPhase)
	{
		SetPad(pPhase);
		TGraph_x_max = 0.8;
		PlotPhase(rGetObj(fn, "g_Phase_H"), p, "");
	}
	
	SetPad(pEffect);
	TGraph_x_max = 0.25;
	PlotEffGraph(rGetObj(fn, "g_fit_CH"), rGetObj(fn, "g_fit_H"), p, label);
}

//----------------------------------------------------------------------------------------------------

void AddText(string l)
{
	SetPad(pEffect);
	AddToLegend(l);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

InitPlots();


//AddText("<{\it different $\rh$, same shape (constant):}");
PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:1,KL,con,chisq,,st+sy", red+dashed, "$N_b = 1$, constant");
PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:2,KL,con,chisq,,st+sy", blue+dashed, "$N_b = 2$, constant");
PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:3,KL,con,chisq,,st+sy", heavygreen+dashed, "$N_b = 3$, constant");

PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:1,KL,per-exa1-1,chisq,,st+sy", red, "$N_b = 1$, peripheral");
PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:2,KL,per-exa2-1,chisq,,st+sy", blue, "$N_b = 2$, peripheral");
PlotCurve("1000-ob-0-1,90-DS4-sc-ob/parcmp:3,KL,per-exa3-1,chisq,,st+sy", heavygreen, "$N_b = 3$, peripheral");

FinalisePlots();

GShipout(margin=0mm);

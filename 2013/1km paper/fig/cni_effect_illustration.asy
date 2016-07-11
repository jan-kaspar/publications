import root;
import pad_layout;

// TODO: needed?
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/coulomb_analysis/exploration/common_code.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis_combined/coulomb_analysis/exploration/";

xSizeDef = 9cm;
ySizeDef = 6cm;

drawGridDef = true;

//----------------------------------------------------------------------------------------------------

void PlotEffGraph(rObject g_CH, rObject g_H, pen p, string label)
{
	guide g;

	int N = g_CH.iExec("GetN");
	// note: starting at 10 to avoid plotting problems of AcrobatReader
	for (int i = 10; i < N; ++i)
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

guide BuildEffGraph(rObject g_CH, rObject g_H)
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

	return g;
}

//----------------------------------------------------------------------------------------------------

void PlotCurve(string option, pen p, string label)
{
	string fn = topDir + "test2.root";

	TGraph_x_max = 0.25;
	PlotEffGraph(rGetObj(fn, option + "/g_FCH_Rho2"), rGetObj(fn, option + "/g_FH_Rho2"), p, label);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\displaystyle {\d\si^{\rm C+N}/\d t - \d\si^{\rm N}/\d t \over \d\si^{\rm N}/\d t}$");
currentpad.xTicks = LeftTicks(0.05, 0.01);
currentpad.yTicks = RightTicks(0.01, 0.005);

AddToLegend("<{\it different $\rh$, same shape (constant):}");
PlotCurve("p-con-rho0.05", red, "$\rh = 0.05$");
PlotCurve("p-con-rho0.10", blue, "$\rh = 0.10$");
PlotCurve("p-con-rho0.15", heavygreen, "$\rh = 0.15$");

AddToLegend("<{\it $\rh = $ 0.10, different shapes:}");
PlotCurve("p-std-rho0.10", red+dashed, "standard");
PlotCurve("p-bai-rho0.10", blue+dashed, "Bailly");
PlotCurve("p-per-rho0.10-4.3-2.311-0.283", heavygreen+dashed, "peripheral");


draw(Label("region of Coulomb dominance", 1., E), (0.005, 0.045){0.3, -1}..{1, 0}(0.03, 0.035), BeginArrow);

draw(Label("region of sensitivity to phase at $|t| \approx 0$", 1., E), (0.01, 0.011)--(0.025, 0.025), BeginArrow);

draw((0.065, -0.025)--(0.050, -0.025), EndArrow);
draw((0.19, -0.022)--(0.19, -0.008), EndArrow);
label("region of sensitivity to phase at higher $|t|$", (0.065, -0.025), E);

limits((0, -0.03), (0.2, 0.05), Crop);

AttachLegend(NW, NE);

GShipout(margin=0mm);

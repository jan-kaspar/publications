import pad_layout;
import root;
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/coulomb_analysis/exploration/common_code.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis_combined/coulomb_analysis/exploration/";

xSizeDef = 8cm;

//----------------------------------------------------------------------------------------------------

void PlotRelGraph(rObject o, pen p, string label)
{
	guide g;

	int N = o.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = {0.};
		real ya[] = {0.};
		o.vExec("GetPoint", i, xa, ya);
		real x = xa[0];
		real y = ya[0];

		if (x > TGraph_x_max)
			continue;
	
		real y_ref = A_ref * exp(-B_ref * x);
	
		real y_rel = (y - y_ref) / y_ref;

		g = g -- Scale((x, y_rel));
	}

	draw(g, p, label);
}

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

bool plotPhase = false;

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
		limits((0, -5), (0.3, 2), Crop);
	}

	SetPad(pEffect);
	limits((0, -0.05), (0.2, 0.05), Crop);

	for (real x=0.; x <= 0.2; x += 0.05)
		yaxis(XEquals(x, false), dotted);

	for (real y=-0.05; y <= 0.05; y += 0.01)
		xaxis(YEquals(y, false), dotted);

	draw(Label("region of Coulomb dominance", 1., E, Fill(white+opacity(0.8))), (0.005, 0.04)--(0.03, 0.04), BeginArrow);
	
	draw(Label("region of sensitivity to phase at $|t| \approx 0$", 1., E, Fill(white+opacity(0.8))), (0.01, -0.001)--(0.02, 0.015), BeginArrow);

	label("region of sensitivity to phase at higher $|t|$", (0.04, -0.025), E, Fill(white+opacity(0.8)));

	AttachLegend(NW, NE);
}

//----------------------------------------------------------------------------------------------------

void PlotCurve(string option, pen p, string label)
{
	string fn = topDir + "test2.root";

	if (plotPhase)
	{
		SetPad(pPhase);
		TGraph_x_max = 0.3;
		PlotPhase(rGetObj(fn, option + "/g_FH_Theta"), p, "");
	}
	
	SetPad(pEffect);
	TGraph_x_max = 0.25;
	//PlotRelGraph(rGetObj(fn, option + "/g_FCH_dsdt"), p, label);
	PlotEffGraph(rGetObj(fn, option + "/g_FCH_Rho2"), rGetObj(fn, option + "/g_FH_Rho2"), p, label);
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


AddText("<{\it different $\rh$, same shape:}");
PlotCurve("p-con-rho0.05", red, "$\rh = 0.05$");
PlotCurve("p-con-rho0.10", blue, "$\rh = 0.10$");
PlotCurve("p-con-rho0.15", heavygreen, "$\rh = 0.15$");

AddText("<{\it $\rh = $ 0.10, different shapes:}");
PlotCurve("p-std-rho0.10", red+dashed, "standard");
PlotCurve("p-per-rho0.10-1-4-0.3", blue+dashed, "peripheral (example 1)");
PlotCurve("p-per-rho0.10-5-4-0.3", heavygreen+dashed, "peripheral (example 2)");

FinalisePlots();

GShipout(margin=0mm);

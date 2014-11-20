import root;
import pad_layout;
include "../analysis/plots/systematics/common_code";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

AddAllModes();

string topDir = "../analysis/";

string dataset = "DS4";
string diagonal = "combined";
string mf = topDir + "systematics/"+dataset+"/matrix_direct_"+diagonal+".root";

xSizeDef = 6.5cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------

int ci = -1;

void PlotMode(string label, string tag)
{
	string pth = "all/contribution: " + tag + ", fit crop";
	rObject obj = rGetObj(mf, pth, error=true);
	pen p = StdPen(++ci);
	draw(scale(1, 100) * shift(0, -1), obj, "l,d0", p, label);
}

//----------------------------------------------------------------------------------------------------

void PlotAll()
{
	AddToLegend("<{\it alignment}:");
	PlotMode("horizontal", "de_th_x");
	PlotMode("vertical", "de_th_y");
	
	AddToLegend("<{\it alignment + optics}:");
	PlotMode("tilt in $x$-$y$ plane", "tilt");
	
	AddToLegend("<{\it optics}:");
	PlotMode("eigen mode 1", "scale_mode1");
	PlotMode("eigen mode 2", "scale_mode2");
	
	AddToLegend("<{\it acceptance correction}:");
	PlotMode("beam divergence~RMS uncertainty", "de_si_th_y");
	PlotMode("beam divergence left-right asymmetry", "sm_asym");
	PlotMode("beam divergence non-gaussianity", "sm_non_gauss");
	
	AddToLegend("<{\it uncorrelated 1-RP efficiencies}:");
	PlotMode("slope uncertainty", "eff_slp");
	
	AddToLegend("<{\it beam momentum}:");
	PlotMode("offset from nominal", "de_p");
	
	AddToLegend("<{\it unfolding}:");
	PlotMode("$\th_x^*$ resolution uncertainty", "unfolding");
	//PlotMode("$\th_y^*$ resolution uncertainty", "unsm-sigma-y");
	//PlotMode("model dependence", "unsm-model");
	
	AddToLegend("<{\bf envelope of uncertainties}:");
	
	rObject h_env_anal = rGetObj(mf, "all analysis/g_envelope");
	draw(scale(1, +100), h_env_anal, "l", black+1.5pt, "$\pm 1\un{\si}$");
	draw(scale(1, -100), h_env_anal, "l", black+1.5pt);
}


//----------------------------------------------------------------------------------------------------

xTicksDef = LeftTicks(0.05, 0.01);
yTicksDef = RightTicks(0.5, 0.1);

NewPad("$|t|\ung{GeV^2}$", "relative cross-section variation $\ung{\%}$");

ci = -1;
PlotAll();

limits((0, -1), (0.2, +1), Crop);

for (real y = -1; y <= +1; y += 0.5)
	xaxis(YEquals(y, false), dotted);

for (real x = 0; x <= 0.2; x += 0.05)
	yaxis(XEquals(x, false), dotted);

frame f_legend;
f_legend = BuildLegend(vSkip=-1mm, lineLength=6mm, 4);

//----------------------------------------------------------------------------------------------------

yTicksDef = RightTicks(0.1, 0.02);

NewPad("$|t|\ung{GeV^2}$", "relative cross-section variation $\ung{\%}$");

ci = -1;
PlotAll();

limits((0, -0.2), (0.2, +0.2), Crop);

for (real y = -0.2; y <= +0.2; y += 0.1)
	xaxis(YEquals(y, false), dotted);

for (real x = 0; x <= 0.2; x += 0.05)
	yaxis(XEquals(x, false), dotted);

//----------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
attach(f_legend);
FixPad(340, 140);

GShipout(hSkip=5mm, vSkip=0mm, margin=0mm);

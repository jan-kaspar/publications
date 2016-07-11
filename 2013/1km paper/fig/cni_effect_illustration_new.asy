import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis_combined/coulomb_analysis/exploration/";

xSizeDef = 7cm;
ySizeDef = 6cm;

drawGridDef = true;

//----------------------------------------------------------------------------------------------------

void PlotCurve(string option, pen p, string label="")
{
	string fn = topDir + "test2_new.root";

	TGraph_x_max = 0.25;
	draw(RootGetObject(fn, option + "/g_C"), p, label);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\displaystyle {\d\si^{\rm C+N}/\d t - \d\si^{\rm N}/\d t \over \d\si^{\rm N}/\d t}$");
currentpad.xTicks = LeftTicks(0.05, 0.01);
currentpad.yTicks = RightTicks(0.01, 0.005);

PlotCurve("p-con-rho0.05-swy", red, "SWY");
PlotCurve("p-con-rho0.05-kl", blue, "KL");
PlotCurve("p-con-rho0.05-cahn", heavygreen+dashed, "Cahn");

PlotCurve("p-con-rho0.10-swy", red);
PlotCurve("p-con-rho0.10-kl", blue);
PlotCurve("p-con-rho0.10-cahn", heavygreen+dashed);

PlotCurve("p-con-rho0.15-swy", red);
PlotCurve("p-con-rho0.15-kl", blue);
PlotCurve("p-con-rho0.15-cahn", heavygreen+dashed);

limits((0, -0.03), (0.2, 0.05), Crop);

AttachLegend("exponential modulus, constant phase");

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "");
currentpad.xTicks = LeftTicks(0.05, 0.01);
currentpad.yTicks = RightTicks(0.01, 0.005);

PlotCurve("p-per-rho0.05-4.3-2.311-0.283-kl", blue, "KL");
PlotCurve("p-per-rho0.05-4.3-2.311-0.283-cahn", heavygreen+dashed, "Cahn");

PlotCurve("p-per-rho0.10-4.3-2.311-0.283-kl", blue);
PlotCurve("p-per-rho0.10-4.3-2.311-0.283-cahn", heavygreen+dashed);

PlotCurve("p-per-rho0.15-4.3-2.311-0.283-kl", blue);
PlotCurve("p-per-rho0.15-4.3-2.311-0.283-cahn", heavygreen+dashed);

limits((0, -0.03), (0.2, 0.05), Crop);

AttachLegend("exponential modulus, peripheral phase");

GShipout(margin=0mm, hSkip=0mm);

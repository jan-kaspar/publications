import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 5.8cm;

string dir = "../unfolding";
string diag = "45t_56b";

//--------------------------------------------------

NewPad("$\th'\un{\mu rad}$", "$h'(\th')$\quad (arbitrary units)");
scale(Linear, Log);
TGraph_errorBarPen = black+0.2pt;
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "fit#1"), "p,sebc", mCi, "data");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "fit#0"), red+1pt, "fit");
limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend();

GShipout("felm_unfolding_m1_fit");


//--------------------------------------------------

NewPad("$\th\un{\mu rad}$", "smearing correction");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "th_corr_with_err"), "l,ec", red, "$\si=12\,\rm\mu rad$");
draw(xscale(1e6), rGetObj(dir+"/method1_13_"+diag+".root", "th_correction"), blue, "$\si=13\,\rm\mu rad$");

limits((134, 0.3), (500, 1.7), Crop);
yaxis(XEquals(170, false), dashed);
xaxis(YEquals(1, false), black+dashed);
AttachLegend("");

GShipout("felm_unfolding_m1_correction");


//--------------------------------------------------

NewPad("$\th'\un{\mu rad}$", "$h'(\th')$\quad (arbitrary units)");
scale(Linear, Log);
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "mc test#1#0"), "p,sebc", mCi, "data");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "mc test#1|th_smear_test"), "", red+1pt, "re-smeared");
AddToLegend("distribution");

limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend("");

GShipout("felm_unfolding_m1_test");

//--------------------------------------------------
//--------------------------------------------------

NewPad(false, autoSize=false);
unitsize(1cm);

real dy = 0.2;
real x = 0;
label("true", (x, dy)); label("(unsmeared)", (x, -dy));

x += 3; label("measured", (x, 0));
x += 3; label("1 extra", (x, dy)); label("smearing", (x, -dy));
x += 3; label("2 extra", (x, dy)); label("smearings", (x, -dy));
x += 3; label("3 extra", (x, dy)); label("smearings", (x, -dy));

string cl[] = {"correction", "correction 1", "correction 2", "correction 3"};

for (int xi = 0; xi < 4; ++xi) {
	draw((3*xi+1, 0)--(3*xi+2, 0), black, EndArrow);
	draw((3*xi+0.3, -0.5)..(3*xi+1.5, -1)..(3*xi+2.7, -0.5), black, BeginArrow);
	label(cl[xi], (3*xi+1.5, -1.1), S);
}

//for (int xi = 0; xi < 3; ++xi)
//	draw((+1.5, -1.7)..((3*xi+4.5)/2, -1.9 - 0.2*xi)..(3*xi+4.5, -1.7));

GShipout("felm_unfolding_m2_scheme");

NewPad("$\th'\un{\mu rad}$", "$h'(\th')$\quad (arbitrary units)");
scale(Linear, Log);
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 1"), red+1pt, "meas. + extrap.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 2"), blue+1pt, "1 extra sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 3"), magenta+1pt, "2 extra sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 4"), heavygreen+1pt, "3 extra sm.");
limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend(SW, SW);

GShipout("felm_unfolding_m2_addsm");

//--------------------------------------------------

NewPad("$\th\un{\mu rad}$", "smearing correction");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_01"), black+1pt, "correction");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_12"), red+1pt, "correction 1");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_23"), blue+1pt, "correction 2");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_34"), magenta+1pt, "correction 3");
limits((134, 0), (500, 2), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend();

GShipout("felm_unfolding_m2_corrections");

//--------------------------------------------------

NewPad("$\th\un{\mu rad}$", "smearing correction");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "th_corr_with_err"), "l,ec", red, "fit-based method");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_01"), blue, "bin-based method");
limits((134, 0), (500, 2), Crop);
yaxis(XEquals(170, false), dashed);
xaxis(YEquals(1, false), black+dashed);
AttachLegend();

GShipout("felm_unfolding_m1m2_cmp");

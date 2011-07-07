import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 6cm;

string dir = "../unfolding";
string diag = "45t_56b";

//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
scale(Linear, Log);
TGraph_errorBarPen = black+0.2pt;
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "fit#1"), "p,sebc", mCi, "corrected data");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "fit#0"), red+1pt, "fit");
limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend();

GShipout("felm_unfolding_m1_fit");


//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "th_corr_with_err"), "l,ec", red, "$\si=12\,\rm\mu rad$");
draw(xscale(1e6), rGetObj(dir+"/method1_13_"+diag+".root", "th_correction"), blue, "$\si=13\,\rm\mu rad$");

limits((134, 0.3), (500, 1.7), Crop);
yaxis(XEquals(170, false), dashed);
xaxis(YEquals(1, false), black+dashed);
AttachLegend("");

GShipout("felm_unfolding_m1_correction");


//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
scale(Linear, Log);
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "mc test#1#0"), "p,sebc", mCi, "corrected data");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "mc test#1|th_smear_test"), "", red+1pt, "result re-smeared");

limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend("");

GShipout("felm_unfolding_m1_test");

//--------------------------------------------------
//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
scale(Linear, Log);
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 1"), red+1pt, "corrected data");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 2"), blue+1pt, "+1 add. sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 3"), magenta+1pt, "+2 add. sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th dist comparison|smearing 4"), heavygreen+1pt, "+3 add. sm.");
limits((134, 1e-2), (500, 1e5), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend(SW, SW);

GShipout("felm_unfolding_m2_addsm");

//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_01"), black+1pt, "true / measured");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_12"), red+1pt, "measured / 1 add. sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_23"), blue+1pt, "1 add. sm. / 2 add. sm.");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_34"), magenta+1pt, "2 add. sm. / 3 add. sm.");
limits((134, 0), (500, 2), Crop);
yaxis(XEquals(170, false), dashed);
AttachLegend();

GShipout("felm_unfolding_m2_corrections");

//--------------------------------------------------

NewPad("$\th\un{\mu rad}$");
draw(xscale(1e6), rGetObj(dir+"/method1_"+diag+".root", "th_corr_with_err"), "l,ec", red, "method 1");
draw(xscale(1e6), rGetObj(dir+"/method2_"+diag+".root", "th correction comparison|th_corr_01"), blue, "method 2");
limits((134, 0), (500, 2), Crop);
yaxis(XEquals(170, false), dashed);
xaxis(YEquals(1, false), black+dashed);

GShipout("felm_unfolding_m1m2_cmp");

AttachLegend();

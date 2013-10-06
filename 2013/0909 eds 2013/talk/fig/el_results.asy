import root;
import pad_layout;

xSizeDef = 6cm;
xSizeDef = 10cm;

//----------------------------------------------------------------------------------------------------

pen err_pen = red;
real w_err_bar = 0.002;

void DrawErr(real t, real atd, real an, real ln, real y_sug = -1)
{
	real a = 500.9, b = -19.46, c = -2.853;
	real y = (y_sug < 0) ? a * exp(b*t + c*t*t) : y_sug;
	real den = 100.;

	real tot = sqrt(atd^2 + an^2 + ln^2);

	//draw(Scale((t-1.5*xs, y*(1-atd/den)))--Scale((t-1.5*xs, y*(1+atd/den))), heavygreen+1.5pt);
	//draw(Scale((t-0.5*xs, y*(1- an/den)))--Scale((t-0.5*xs, y*(1+ an/den))), orange+1.5pt);
	//draw(Scale((t+0.5*xs, y*(1- ln/den)))--Scale((t+0.5*xs, y*(1+ ln/den))), blue+1.5pt);
	//draw(Scale((t+1.5*xs, y*(1-tot/den)))--Scale((t+1.5*xs, y*(1+tot/den))), red+1.5pt);

	real w = w_err_bar;
	filldraw(Scale((t-w, y*(1-tot/den)))--Scale((t+w, y*(1-tot/den)))--Scale((t+w, y*(1+tot/den)))--Scale((t-w, y*(1+tot/den)))--cycle, err_pen, black+0.05pt);
	//draw(Scale((t, y*(1-tot/den)))--Scale((t, y*(1+tot/den))), err_pen);
	//draw(Scale((t-w, y*(1-tot/den)))--Scale((t+w, y*(1-tot/den))), err_pen);
	//draw(Scale((t-w, y*(1+tot/den)))--Scale((t+w, y*(1+tot/den))), err_pen);
}

//----------------------------------------------------------------------------------------------------

void DrawTotalErr(real t, real y, real ep, real em)
{
	real den = 100.;

	//draw(Scale((t-1.5*xs, y*(1-atd/den)))--Scale((t-1.5*xs, y*(1+atd/den))), heavygreen+1.5pt);
	//draw(Scale((t-0.5*xs, y*(1- an/den)))--Scale((t-0.5*xs, y*(1+ an/den))), orange+1.5pt);
	//draw(Scale((t+0.5*xs, y*(1- ln/den)))--Scale((t+0.5*xs, y*(1+ ln/den))), blue+1.5pt);
	//draw(Scale((t+1.5*xs, y*(1-tot/den)))--Scale((t+1.5*xs, y*(1+tot/den))), red+1.5pt);

	real w = w_err_bar;
	filldraw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den)))--Scale((t+w, y*(1+ep/den)))--Scale((t-w, y*(1+ep/den)))--cycle, err_pen, black+0.05pt);
	//draw(Scale((t, y*(1+em/den)))--Scale((t, y*(1+ep/den))), err_pen);
	//draw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den))), err_pen);
	//draw(Scale((t-w, y*(1+ep/den)))--Scale((t+w, y*(1+ep/den))), err_pen);
}

//----------------------------------------------------------------------------------------------------

void DrawSimpleErr(real t, real e)
{
	real den = 1.;
	real w = w_err_bar;
	real y = 80 * exp(-18.9 * t - 5.1 * t*t);
	real em = -e, ep = e;
	filldraw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den)))--Scale((t+w, y*(1+ep/den)))--Scale((t-w, y*(1+ep/den)))--cycle, err_pen, black+0.05pt);
}

//----------------------------------------------------------------------------------------------------
// 7 TeV
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", axesAbove=false);
scale(Linear, Log);


TH1_lowLimit = -inf; TH1_highLimit = 0.38; draw(rGetObj("7_h3.root", "h_avg"), "vl,eb", red, "$\be^*=90\un{m}$");
err_pen = red;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
//DrawErr(0.40, 12.3, 1.3, 4., 0.109);

//TF1_lowLimit = 0;
//draw(rGetObj("7_normalize_merged.root", "cross section/fit1|ff1"), heavygreen+2pt);

TH1_lowLimit = 0.37;
TH1_highLimit = 2.5;
draw(rGetObj("7_h1.root", "h1"), "vl,eb", blue, "$\be^*=3.5\un{m}$, RPs at $7\un{\si}$");
err_pen = blue;
w_err_bar = 0.005;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);


filldraw((2, -6)--(3.5, -6)--(3.5, -5)--(2, -5)--cycle, heavygreen, nullpen);
AddToLegend("$\be^*=3.5\un{m}$, RPs at $18\un{\si}$", mSq+5pt+heavygreen);


// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical unc.", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic unc.", (shift(0, -1)*psy).fit());

currentpad.xTicks = LeftTicks(Step=0.5, 0.1);
limits((0, 1e-7), (4, 1e3), Crop);
AttachLegend();

GShipout("el_results_7");

//----------------------------------------------------------------------------------------------------
// 8 TeV
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV}$", xSize=8cm, axesAbove=false);
scale(Linear, Log);

TGraph_errorBar = None;


string analDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic";

TGraph_highLimit = 0.3;
draw(shift(0, log10(1./0.899)), rGetObj(analDir+"/4000GeV,beta90,low_t/tabulation/tabulation.root", "g_dsdt_full"), "p", red, mTD+1.5pt+red);

TH1_highLimit = 0.2;
//draw(rGetObj(analDir+"/4000GeV,beta1000/tabulation/tabulation.root", "h_dsdt"), "eb", blue, "$\be^* = 1000\un{m}$");
draw(rGetObj(analDir+"/4000GeV,beta1000/tabulation/tabulation.root", "g_dsdt_full"), "p", blue, mTU+1pt+blue);

AddToLegend("$\be^* = 1000\un{m}$", mTU+3pt+blue);
AddToLegend("$\be^* = 90\un{m}$, low statistics", mTD+3pt+red);


// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("stat.~$\oplus$ syst.~uncert.", pse.fit());

filldraw((2e-2, -0.8)--(1.4, -0.8)--(1.4, -0.2)--(2e-2, -0.2)--cycle, heavygreen, nullpen);
AddToLegend("$\be^*=90\un{m}$, high statistics", mSq+5pt+heavygreen);

limits((0, 1e-1), (1.5, 2e3), Crop);
AttachLegend("full $|t|$-range");

//--------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV}$", xSize=6cm, axesAbove=false);
scale(Linear, Log);

string analDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic";

TH1_highLimit = 0.2;
draw(rGetObj(analDir+"/4000GeV,beta1000/tabulation/tabulation.root", "g_dsdt_full"), "p", blue, mTU+1pt+blue, "$\be^* = 1000\un{m}$");

draw(shift(0, log10(1./0.899)), rGetObj(analDir+"/4000GeV,beta90,low_t/tabulation/tabulation.root", "g_dsdt_full"), "p", red, mTD+2pt+red, "$\be^* = 90\un{m}$");

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("stat.~$\oplus$ syst.~uncert.", pse.fit());

limits((0, 3e2), (0.02, 2e3), Crop);
AttachLegend("low-$|t|$ detail");

GShipout("el_results_8");

//----------------------------------------------------------------------------------------------------
// 2.76 TeV
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV}$", axesAbove=true);
scale(Linear, Log);

filldraw((0.06, -1.8)--(0.4, -1.8)--(0.4, -1.2)--(0.06, -1.2)--cycle, heavygreen, nullpen);
filldraw((0.4, -1.8)--(0.5, -1.8)--(0.5, -1.2)--(0.4, -1.2)--cycle, heavygreen+opacity(0.5), nullpen);

AddToLegend("$\be^* = 11\un{m}$, RPs at $5\un{\si}$", mSq+5pt+heavygreen);
AddToLegend("$\be^* = 11\un{m}$, RPs at $13\un{\si}$", mSq+5pt+(heavygreen+opacity(0.5)));

limits((0, 1e-2), (0.7, 1e2), Crop);
AttachLegend();

GShipout("el_results_2p76");

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/plots/run_info.asy";

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000";

xSizeDef = 15cm;
ySizeDef = 4cm;

real timestamp0 = 1351029600;
transform unixToHours = scale(1/3600, 1) * shift(-timestamp0, 0);
transform paperTimeShift = shift(-23, 0);

//----------------------------------------------------------------------------------------------------

void DrawBox(real l, real r, real y, string label, pen c)
{
	real h = 10;
	filldraw(swToHours*((l, y)--(r, y)--(r, y+h)--(l, y+h)--cycle), c+opacity(0.3), nullpen);
	label(label, swToHours*((l+r)/2, y + h/2), c);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

/*
NewPad("time$\ung{h}$", "", xTicks=LeftTicks(Step=1, n=6), ySize=3cm);
currentpad.yTicks = NoTicks();

DrawBox(1351112950-timestamp0, 1351117225-timestamp0, 20, "DS2a", red);
DrawBox(1351118770-timestamp0, 1351146451-timestamp0, 20, "DS2b", red);

for (int i : runs.keys)
	DrawBox(ts_from[i], ts_to[i], 5, format("%i", runs[i]), blue);

limits((22, 0), (33, 35), Crop);
DrawRunBoundaries();
*/

//----------------------------------------------------------------------------------------------------

/*
NewRow();

NewPad("", "RP position$\ung{mm}$", xTicks=LeftTicks(Step=1, n=6));
TGraph_reducePoints = 100;

AddToLegend("verticals", solid);
AddToLegend("horizontals", longdashed);

draw(unixToHours, RootGetObject(topDir+"/plots/rp.root", "XRPH.B6L5.B2:MEAS_MOTOR_LU"), red+longdashed);
draw(unixToHours, RootGetObject("../rp.root", "XRPH.A6L5.B2:MEAS_MOTOR_LU"), blue+longdashed);
draw(unixToHours, RootGetObject("../rp.root", "XRPH.A6R5.B1:MEAS_MOTOR_LU"), heavygreen+longdashed);
draw(unixToHours, RootGetObject("../rp.root", "XRPH.B6R5.B1:MEAS_MOTOR_LU"), magenta+longdashed);

draw(unixToHours, RootGetObject("../rp.root", "XRPV.B6L5.B2:MEAS_MOTOR_LU"), red, "left far");
draw(unixToHours, RootGetObject("../rp.root", "XRPV.A6L5.B2:MEAS_MOTOR_LU"), blue, "left near");
draw(unixToHours, RootGetObject("../rp.root", "XRPV.A6R5.B1:MEAS_MOTOR_LU"), heavygreen, "right near");
draw(unixToHours, RootGetObject("../rp.root", "XRPV.B6R5.B1:MEAS_MOTOR_LU"), magenta, "right far");

draw(unixToHours, RootGetObject("../rp.root", "XRPV.B6L5.B2:MEAS_MOTOR_RU"), red);
draw(unixToHours, RootGetObject("../rp.root", "XRPV.A6L5.B2:MEAS_MOTOR_RU"), blue);
draw(unixToHours, RootGetObject("../rp.root", "XRPV.A6R5.B1:MEAS_MOTOR_RU"), heavygreen);
draw(unixToHours, RootGetObject("../rp.root", "XRPV.B6R5.B1:MEAS_MOTOR_RU"), magenta);

limits((22, -10), (33, +10), Crop);
DrawRunBoundaries();
AttachLegend(3, S, S);
*/

//----------------------------------------------------------------------------------------------------

NewRow();

NewPad("time\ung{h}", "rate$\ung{Hz}$", xTicks=LeftTicks(Step=1, n=6), yTicks=RightTicks(50., 10.));
DrawRunBands(paperTimeShift, 0, 400, false);

//TGraph_reducePoints = 5;
TGraph_errorBar = None;
dotfactor = 4;
string f = topDir + "/plots/rates.root";
draw(paperTimeShift * unixToHours, RootGetObject(f, "g_rate_t2"), "d", blue);
draw(paperTimeShift * unixToHours, RootGetObject(f, "g_rate_rp"), "d", red);

AddToLegend("T2 rate", mCi+1pt+blue);
AddToLegend("RP rate", mCi+1pt+red);

limits((0, 0), (9.2, 400), Crop);
AttachLegend(BuildLegend(NE, lineLength=5mm, vSkip=0.5mm), NE);

//----------------------------------------------------------------------------------------------------

/*

NewRow();

NewPad("", "rate$\ung{Hz}$", xTicks=LeftTicks(Step=1, n=6));

rObject o = RootGetObject(topDir+"DS2a/distributions_45t_56b.root", "metadata/h_timestamp_dgn");
o.vExec("Rebin", 10);
o.vExec("Scale", 1/10);
draw(swToHours, o, "d0", black, "diagonal rates from RP data");

rObject o = RootGetObject(topDir+"DS2b/distributions_45t_56b.root", "metadata/h_timestamp_dgn");
o.vExec("Rebin", 10);
o.vExec("Scale", 1/10);
draw(swToHours, o, "d0", black);

rObject o = RootGetObject(topDir+"DS2b-firstParts/distributions_45t_56b.root", "metadata/h_timestamp_dgn");
o.vExec("Rebin", 10);
o.vExec("Scale", 1/10);
draw(swToHours, o, "d0", magenta, "``first parts''");

rObject o = RootGetObject(topDir+"DS2b-lastParts/distributions_45t_56b.root", "metadata/h_timestamp_dgn");
o.vExec("Rebin", 10);
o.vExec("Scale", 1/10);
draw(swToHours, o, "d0", green, "``last parts''");

limits((22, 0), (33, 20), Crop);
DrawRunBoundaries();
AttachLegend();

//----------------------------------------------------------------------------------------------------


NewRow();

string datasets[] = { "DS2a", "DS2b" };

TGraph_errorBar = None;
TGraph_reducePoints = 1;

NewPad("time$\ung{h}$", "destructive pile-up probability", xTicks=LeftTicks(Step=1, n=6));
for (int di : datasets.keys)
{
	currentpicture.legend.delete();

	draw(swToHours, RootGetObject(topDir+datasets[di]+"/pileup_fit_combined.root", "45b_56t/dgn.src"), "p", blue, mTU+2pt+blue, "45 bot -- 56 top (far)");
	draw(swToHours, RootGetObject(topDir+datasets[di]+"/pileup_fit_combined.root", "45b_56t/dgn"), "l", blue+dashed);
	
	draw(swToHours, RootGetObject(topDir+datasets[di]+"/pileup_fit_combined.root", "45t_56b/dgn.src"), "p", red, mTD+2pt+red, "45 top -- 56 bot (close)");
	draw(swToHours, RootGetObject(topDir+datasets[di]+"/pileup_fit_combined.root", "45t_56b/dgn"), "l", red+dashed);
}
AddToLegend("linear fit per run", black+dashed);

limits((22, 0), (33, 0.04), Crop);
AttachLegend();
DrawRunBoundaries();

*/

GShipout(margin=0mm);

import root;
import pad_layout;

string base_dir = "/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/user/elastic_analysis/low_t/";
string f = base_dir + "comparisons/dataset_cmp.root";
string fg = base_dir + "comparisons/dsdt_graph.root";

real xs = 0.004;

xSizeDef = 15cm;
ySizeDef = 8cm;

xTicksDef = LeftTicks(Step=0.05, step=0.01);

//----------------------------------------------------------------------------------------------------

void DrawErrSep(real t, real atd, real an, real ln)
{
	real tot = sqrt(atd^2 + an^2 + ln^2);
	
	draw((t, -15)--(t, +15), dotted);

	path p = (-0.5, -1)--(0.5, -1)--(0.5, 1)--(-0.5, 1)--cycle;

	filldraw(shift(t, 0)*scale(xs, atd)*shift(-1.5, 0)*p, heavygreen, nullpen);
	filldraw(shift(t, 0)*scale(xs, an)*shift(-0.5, 0)*p, orange, nullpen);
	filldraw(shift(t, 0)*scale(xs, ln)*shift(+0.5, 0)*p, blue, nullpen);
	filldraw(shift(t, 0)*scale(xs, tot)*shift(+1.5, 0)*p, red, nullpen);

	//draw(Scale((t-1.5*xs, -atd))--Scale((t-1.5*xs, +atd)), heavygreen+2.8pt);
	//draw(Scale((t-0.5*xs, - an))--Scale((t-0.5*xs, + an)), orange+2.8pt);
	//draw(Scale((t+0.5*xs, - ln))--Scale((t+0.5*xs, + ln)), blue+2.8pt);
	//draw(Scale((t+1.5*xs, -tot))--Scale((t+1.5*xs, +tot)), red+2.8pt);

}

//----------------------------------------------------------------------------------------------------

void DrawErr(real t, real atd, real an, real ln, bool separate=false)
{
	real a = 500.9, b = -19.46, c = -2.853;
	real y = a * exp(b*t + c*t*t);
	real den = 100.;

	real tot = sqrt(atd^2 + an^2 + ln^2);

	//draw(Scale((t-1.5*xs, y*(1-atd/den)))--Scale((t-1.5*xs, y*(1+atd/den))), heavygreen+1.5pt);
	//draw(Scale((t-0.5*xs, y*(1- an/den)))--Scale((t-0.5*xs, y*(1+ an/den))), orange+1.5pt);
	//draw(Scale((t+0.5*xs, y*(1- ln/den)))--Scale((t+0.5*xs, y*(1+ ln/den))), blue+1.5pt);
	//draw(Scale((t+1.5*xs, y*(1-tot/den)))--Scale((t+1.5*xs, y*(1+tot/den))), red+1.5pt);

	real w = 0.002;
	filldraw(Scale((t-w, y*(1-tot/den)))--Scale((t+w, y*(1-tot/den)))--Scale((t+w, y*(1+tot/den)))--Scale((t-w, y*(1+tot/den)))--cycle, red, nullpen);
}

//----------------------------------------------------------------------------------------------------

//NewPad("$|t|\ung{GeV^2}$");
NewPad("", "$\d\si_{\rm el}/\d t$ uncertainty$\ung{\%}$", ySize=4.5cm, yTicks = RightTicks(Step=5, step=1));

DrawErrSep(0.01, 1.0, 1.3, 4.);
DrawErrSep(0.06, 0.3, 1.3, 4.);
DrawErrSep(0.10, 0.9, 1.3, 4.);
DrawErrSep(0.12, 1.2, 1.3, 4.);
DrawErrSep(0.16, 3.0, 1.3, 4.);
DrawErrSep(0.20, 4.5, 1.3, 4.);
DrawErrSep(0.30, 8.3, 1.3, 4.);
DrawErrSep(0.40, 12.3, 1.3, 4.);
limits((0, -15), (0.45, +15), Crop);
xaxis(YEquals(0, false), dashed);
xaxis(YEquals(+10, false), dotted);
xaxis(YEquals(+5, false), dotted);
xaxis(YEquals(-5, false), dotted);
xaxis(YEquals(-10, false), dotted);

AddToLegend("analysis $t$-dependent", heavygreen+3pt);
AddToLegend("analysis normalization", orange+3pt);
AddToLegend("luminosity", blue+3pt);
AddToLegend("total", red+3pt);
AttachLegend(2, NW, NW);

NewRow();

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si_{\rm el}/\d t\ung{mb/GeV^2}$");
scale(Linear, Log);

AddToLegend("this publication", black);

draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/publication1.root", "tc#1"), "vl,ec", blue+1pt, "EPL 95");
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/publication2.root", "c1#1"), "l,ec", heavygreen, "EPL 96");

draw(rGetObj(f, "h_avg"), "vl,d0,ec");

TF1_lowLimit = 0; TF1_highLimit = 0.2;
draw(rGetObj(fg, "ff2"), "l", heavygreen);
TGraph_lowLimit = 0.2; TGraph_highLimit = +inf;
draw(rGetObj(fg, "g_dsdt"), "p,ieb", mCi+1pt+black, "");

DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4.);
DrawErr(0.30, 8.3, 1.3, 4.);
DrawErr(0.40, 12.3, 1.3, 4.);

for (real y = -1; y <= 2; y += 1)
	draw((0, y)--(0.45, y), dotted);

for (real x = 0; x <= 0.45; x += 0.05)
	draw((x, -2)--(x, 3), dotted);

real x1=0.035, x2=0.175, y1 = -1.2, y2=0.5;

filldraw((x1, y1)--(x2, y1)--(x2, y2)--(x1, y2)--cycle, white, nullpen);

real w = 0.002, h = 0.15, wh = 0.01;
real x = 0.05, y = 0, y0 = 0.5;

y = y0-0.2;
draw((x-wh, y)--(x+wh, y), heavygreen);
label("low-$|t|$ extrapolation", (x+wh, y), 2E);

y = y0-0.6;
draw((x, y), mCi+1pt+black); label("bin control points", (x+wh, y), 2E);

y = y0-1;
filldraw((x-w, y-h)--(x+w, y-h)--(x+w, y+h)--(x-w, y+h)--cycle, black+opacity(TH1_errorContourOpacity), nullpen);
label("statistical uncertainty", (x+wh, y), 2E);

y = y0-1.4;
filldraw((x-w, y-h)--(x+w, y-h)--(x+w, y+h)--(x-w, y+h)--cycle, red, nullpen);
label("systematic uncertainty", (x+wh, y), 2E);


limits((0, 1e-2), (0.45, 1e3), Crop);
AttachLegend();

GShipout("dsdt", vSkip=0pt);

//----------------------------------------------------------------------------------------------------

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 11;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path det_shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
det_shape = scale(10) * rotate(45) * det_shape;

//----------------------------------------------------------------------------------------------------

/*
string dataSets[] = { "NN_2011_10_20_1", "NN_2011_10_20_2", "NN_2011_10_20_3" };

xSizeDef = 6cm;
ySizeDef = 6cm;

xTicksDef = LeftTicks(Step=10, step=2);
//yTicksDef = RightTicks(Step=0.2, step=0.1);
yTicksDef = RightTicks(Step=10, step=2);

TH2_z_min = 0;
TH2_z_max = log10(250);


NewPad("$x\ung{mm}$", "$y\ung{mm}$");
scale(Linear, Linear, Log);
draw(rGetObj(base_dir+dataSets[2]+"/distributions_45t_56b.root", "hit distributions/h_y_R_F_vs_x_R_F_raw"), "p");
draw(rGetObj(base_dir+dataSets[2]+"/distributions_45b_56t.root", "hit distributions/h_y_R_F_vs_x_R_F_raw"), "p");

draw(shift(0, -6.4)*det_shape);
draw(shift(0, +6.5)*scale(1, -1)*det_shape);

label("beam halo", (-15, 0));
draw((-10, 2)--(-4, 6), EndArrow);
draw((-10, -3)--(-2, -6), EndArrow);

label("low-$\xi$ protons", (+15, 0));
draw((15, 2)--(2, 18), EndArrow);
draw((15, -3)--(2, -18), EndArrow);

limits((-30, -30), (30, +30), Crop);
AttachLegend("diagonal cut");

NewPad("$x\ung{mm}$");
scale(Linear, Linear, Log);
draw(rGetObj(base_dir+dataSets[2]+"/distributions_45t_56b.root", "hit distributions/h_y_R_F_vs_x_R_F_sel"), "p,bar");
draw(rGetObj(base_dir+dataSets[2]+"/distributions_45b_56t.root", "hit distributions/h_y_R_F_vs_x_R_F_sel"), "p");

draw(shift(0, -6.4)*det_shape);
draw(shift(0, +6.5)*scale(1, -1)*det_shape);

label("aperture limitations", (+11, 0));
draw((15, 3){0, 1}..{-1, 0}(2, 28), EndArrow);
draw((15, -3){0, -1}..{-1, 0}(2, -28), EndArrow);

limits((-30, -30), (30, +30), Crop);
AttachLegend("all cuts");

GShipout("hit_dist", hSkip=0mm);
*/

//----------------------------------------------------------------------------------------------------

xSizeDef = 6cm;
ySizeDef = 6cm;

//yTicksDef = RightTicks(Step=10, step=2);
yTicksDef = RightTicks();

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t$: DS2 / DS1");
draw(rGetObj(base_dir + "comparisons/dataset_cmp.root", "ds2_over_ds1"), "vl,ec", blue);
limits((0, 0.8), (0.4, 1.2), Crop);
xaxis(YEquals(1, false), dashed);

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t$: DS3 / DS1");
draw(rGetObj(base_dir + "comparisons/dataset_cmp.root", "ds3_over_ds1"), "vl,ec", blue);
limits((0, 0.8), (0.4, 1.2), Crop);
xaxis(YEquals(1, false), dashed);

GShipout("dsdt_dataset_ratio");

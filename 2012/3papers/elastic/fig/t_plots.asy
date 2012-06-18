import root;
import pad_layout;
import latex_aux_parser;

ParseAuxFile("../elastic.aux");

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts");

texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string base_dir = "/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/user/elastic_analysis/low_t/";
string f =  "../tabulation/dataset_cmp.root";
string fg = "../tabulation/tab_this_pub.root";
string models_dir = "/mnt/pctotem31/software/offline/311.old/user/elastic_data_model_cmp";

real xs = 0.004;

xSizeDef = 15.5cm;
ySizeDef = 8cm;

xTicksDef = LeftTicks(Step=0.05, step=0.01);

/*

//----------------------------------------------------------------------------------------------------

void DrawErrSep(real t, real atd, real an, real ln)
{
	real tot = sqrt(atd^2 + an^2 + ln^2);
	
	draw((t, -15)--(t, +15), dashed);

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

NewPad("$|t|\ung{GeV^2}$", "$\d\si_{\rm el}/\d t\ung{mb/GeV^2}$", ySize=13cm);
scale(Linear, Log);

for (real y = -1; y <= 2; y += 1)
	draw((0, y)--(0.45, y), dotted);

for (real x = 0; x <= 0.45; x += 0.05)
	draw((x, -2)--(x, 3), dotted);

AddToLegend("this publication", black);

//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/publication1.root", "tc#1"), "vl,ec", blue+1pt, "Ref.~["+GetLatexReference("bibcite", "epl95")+"]");
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/publication2.root", "c1#1"), "l,ec", heavygreen, "EPL 96");


TF1_lowLimit = 0; TF1_highLimit = 0.2;
draw(rGetObj(fg, "ff2"), "l", magenta+1pt, "extrapolation to $t=0$");

draw(rGetObj(f, "h_avg"), "vl,d0,eb");

//TGraph_lowLimit = 0.2; TGraph_highLimit = +inf;
//draw(rGetObj(fg, "g_stat_err"), "p,ieb", mCi+1pt+black, "");

DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
DrawErr(0.40, 12.3, 1.3, 4., 0.109);

picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical uncertainties", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = red;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic uncertainties", (shift(0, -1)*psy).fit());

limits((0, 1e-2), (0.45, 1e3), Crop);
AttachLegend();

NewRow();

//------------------------------------

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

GShipout("dsdt", vSkip=0pt);

//----------------------------------------------------------------------------------------------------
// infit plot

picture infit = new picture;
currentpicture = infit;

unitsize(550mm, 16mm);

scale(Linear, Log);

for (real y = 2; y <= 2; y += 1)
	draw((0, y)--(0.2, y), dotted);

for (real x = 0.; x <= 0.2; x += 0.05)
	draw((x, 1)--(x, 3), dotted);

// EPL 96
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", heavygreen);
TGraph_errorBar = None;
TGraph_lowLimit = -inf; TGraph_highLimit = +inf;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);

// extrapolation to 0
TF1_lowLimit = 0; TF1_highLimit = 0.2;
draw(rGetObj(fg, "ff2"), "l", black, "extrapolation to $t=0$");

// this publication
TH1_lowLimit = 0.; TH1_highLimit = 0.45;
draw(rGetObj(f, "h_avg"), "vl,d0", red+0.6pt);
draw(rGetObj(fg, "g_stat_err"), "p,iebx", red);

err_pen = red;
w_err_bar = 0.001;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
DrawErr(0.40, 12.3, 1.3, 4., 0.109);

// t_min arrows
real t_min = 0.005; draw(Label("$|t|_{\rm min} = 5\cdot 10^{-3}\un{GeV^2}$", 0, E, UnFill), (t_min, 1.25)--(t_min, 2.5), red, EndArrow);
real t_min = 0.02; draw(Label("$|t|_{\rm min} = 2\cdot 10^{-2}\un{GeV^2}$", 0, E, UnFill), (t_min, 1.55)--(t_min, 2.4), heavygreen, EndArrow);

limits((0, 1e1), (0.2, 1e3), Crop);
AttachLegend();

xaxis(BottomTop, LeftTicks(Step=0.05, step=0.01));
yaxis(LeftRight, RightTicks());

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si_{\rm el}/\d t\ung{mb/GeV^2}$", xTicks=LeftTicks(Step=0.2, step=0.1), 15.5cm, 7.5cm);
scale(Linear, Log);

for (real y = -5; y <= 3; y += 1)
	draw((0, y)--(2.5, y), dotted);

for (real x = 0.; x <= 2.5; x += 0.2)
	draw((x, -5)--(x, 3), dotted);

// EPL 95
TH1_lowLimit = -inf; TH1_highLimit = +inf;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl", blue, "Ref.~["+GetLatexReference("bibcite", "epl95")+"]");
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "p,iebx", blue);

err_pen = blue;
w_err_bar = 0.008;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);

// EPL 96
TH1_highLimit = 0.4;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", heavygreen, "Ref.~["+GetLatexReference("bibcite", "epl96")+"]");
TGraph_highLimit = 0.4;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);

// this publication

//TF1_lowLimit = 0; TF1_highLimit = 0.2;
//draw(rGetObj(fg, "ff2"), "l", heavygreen+1pt);

TH1_lowLimit = 0.; TH1_highLimit = 0.45;
draw(rGetObj(f, "h_avg"), "vl,d0", red+0.6pt, "this publication");
TGraph_highLimit = 0.45;
draw(rGetObj(fg, "g_stat_err"), "p,iebx", red);

err_pen = red;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
DrawErr(0.40, 12.3, 1.3, 4., 0.109);


// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical uncertainties", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic uncertainties", (shift(0, -1)*psy).fit());

limits((0, 1e-5), (2.5, 1e3), Crop);
AttachLegend(SW, SW);

attach(bbox(infit, 1mm, FillDraw(white)), point(NE), SW*0.000000001);

GShipout("dsdt_comp", vSkip=0pt);

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si_{\rm el}/\d t\ung{mb/GeV^2}$", xTicks=LeftTicks(Step=0.2, step=0.1), 15.5cm, 8cm);
scale(Linear, Log);

// models
TGraph_lowLimit = -inf; TGraph_highLimit = +inf;
string[] tags = { "bh", "bsw", "islam_cgc", "jenkovszky", "ppp3" };
pen[] colors = { red, blue, green, magenta, orange };
string labels[] = { "Block et al.", "Bourrely et al.", "Islam et al. (LxG)", "Jenkovszky et al.", "Petrov et al. (3P)" };

for (int t : tags.keys) {
	rObject o = rGetObj(models_dir+"/3500GeV_0_20_4E3.root", "differential cross section/PH/" + tags[t]);
	if (o.valid)
		draw(o, colors[t], labels[t]);
}

//draw(rGetObj("khoze.root", "c1_n2|khoze1"), orange, "Khoze et al. (i)");
//draw(rGetObj("khoze.root", "c1_n2|khoze2"), orange+dashed, "Khoze et al. (ii)");

//draw(rGetObj("ostapchenko.root", "ostapchenko"), cyan, "Ostapchenko");
//draw(rGetObj("menon.root", "menon"), red, "Fagundes et al.");

// EPL 95
TH1_lowLimit = -inf; TH1_highLimit = +inf;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl", black, "TOTEM");
TGraph_lowLimit = -inf; TGraph_highLimit = +inf;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "p,iebx", black);

err_pen = black;
w_err_bar = 0.008;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);

// EPL 96
//TH1_highLimit = 0.4;
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", heavygreen, "Ref.~["+GetLatexReference("bibcite", "epl96")+"]");
//TGraph_highLimit = 0.4;
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);

// this publication

//TF1_lowLimit = 0; TF1_highLimit = 0.2;
//draw(rGetObj(fg, "ff2"), "l", heavygreen+1pt);

TH1_lowLimit = 0.; TH1_highLimit = 0.45;
draw(rGetObj(f, "h_avg"), "vl,d0", black+0.6pt, "");
TGraph_lowLimit = -inf; TGraph_highLimit = 0.45;
draw(rGetObj(fg, "g_stat_err"), "p,iebx", black);

err_pen = black;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
DrawErr(0.40, 12.3, 1.3, 4., 0.109);

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical uncertainties", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = black;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic uncertainties", (shift(0, -1)*psy).fit());

limits((0, 1e-5), (2.5, 1e3), Crop);
AttachLegend(NE, NE);

GShipout("dsdt_models", vSkip=0pt);


//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si_{\rm el}/\d t\ung{mb/GeV^2}$", xTicks=LeftTicks(Step=0.2, step=0.1), 15.5cm, 8cm);
scale(Linear, Log);

for (real y = -8; y <= 3; y += 1)
	draw((0, y)--(3.5, y), dotted);

for (real x = 0.; x <= 3.5; x += 0.2)
	draw((x, -8)--(x, 3), dotted);

// EPL 95
TH1_lowLimit = -inf; TH1_highLimit = 2.4;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl", blue, "EPL 95");
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "p,iebx", blue);

err_pen = blue;
w_err_bar = 0.008;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);

// EPL 96
TH1_highLimit = 0.4;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", heavygreen, "EPL 96");
TGraph_highLimit = 0.4;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);

// this publication

//TF1_lowLimit = 0; TF1_highLimit = 0.2;
//draw(rGetObj(fg, "ff2"), "l", heavygreen+1pt);

TH1_lowLimit = 0.; TH1_highLimit = 0.45;
draw(rGetObj(f, "h_avg"), "vl,d0", red+0.6pt, "this publication");
TGraph_highLimit = 0.45;
draw(rGetObj(fg, "g_stat_err"), "p,iebx", red);

err_pen = red;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
DrawErr(0.40, 12.3, 1.3, 4., 0.109);

filldraw((2.3, -4.6)--(3., -8)--(3.5, -8)--(3.5, -6)--(2.3, -4.2)--cycle, orange, nullpen);

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical uncertainties", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic uncertainties", (shift(0, -1)*psy).fit());

limits((0, 1e-8), (3.5, 1e3), Crop);
AttachLegend(SW, SW);

GShipout("dsdt_outlook", vSkip=0pt);

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

string dataSets[] = { "NN_2011_10_20_1", "NN_2011_10_20_2", "NN_2011_10_20_3" };

xSizeDef = 5.5cm;
ySizeDef = 5.5cm;

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

NewPad("$|t|\ung{GeV^2}$", "$B(t)\ung{GeV^{-2}}$", xTicks=LeftTicks(Step=0.5, step=0.1), 12cm, 10cm);
TGraph_highLimit = +inf;

string[] tags = { "bh", "bsw", "islam_cgc", "jenkovszky", "ppp3" };
for (int t : tags.keys) {
	rObject o = rGetObj(models_dir+"/3500GeV_0_20_4E3.details.root", "B/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, black+0.2pt);
}

AddToLegend("several phenomenological models", black+0.2pt);

TGraph_errorBar = None;

draw(rGetObj("../tabulation/B.root", "1/gB_var"), "p,l,eb", blue+1pt, mCi+1pt+blue, "EPL 95");
draw(rGetObj("../tabulation/B.root", "3/gB_var"), "p,l,eb", red+1pt, mCi+1pt+red, "this analysis");

AddToLegend("(vertical error bars: statistical uncertainties only)");
AddToLegend("(horizontal error bars: fit regions)");


limits((0., -10), (2.2, 30), Crop);
AttachLegend();

GShipout("B_t");

//----------------------------------------------------------------------------------------------------

/*
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
*/

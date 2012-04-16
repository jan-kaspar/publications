import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 5.8cm;

string dir = "../background";
string diag = "45t_56b";

real g_a, g_m, g_s;

real gauss(real x)
{
	return g_a * exp(-((x - g_m)/g_s)^2/2);
}

void GetGauss(rObject o)
{
	g_a = o.rExec("GetParameter", 2);
	g_m = o.rExec("GetParameter", 3);
	g_s = o.rExec("GetParameter", 4);
}

void GetSignal(rObject o)
{
	g_a = o.rExec("GetParameter", 0);
	g_m = 0;
	g_s = o.rExec("GetParameter", 1);
}


//----------------------------------------------------------------------------------------------------
// INTEGRAL

NewPad("$q_1/\si_1$", "$h_1$");
//scale(Linear, Log);
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel"), "vl,ec");
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel|ff"), blue+1pt);

//GetSignal(robj);
//draw(graph(gauss, -12, +12, 1000), heavygreen+1pt);

GetGauss(robj);
draw(graph(gauss, -12, +12, 1000), red+1pt);

limits((-12, 1e-0), (+12, 1700), Crop);

AttachLegend("cut 1");


NewPad("$q_4/\si_4$", "$h_2$");
//scale(Linear, Log);
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq4_dist_sel"), "vl,ec");
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq4_dist_sel|ff"), blue+1pt);

//GetSignal(robj);
//draw(graph(gauss, -12, +12, 1000), heavygreen+1pt);

GetGauss(robj);
draw(graph(gauss, -12, +12, 1000), red+1pt);

limits((-12, 1e-0), (+12, 1700), Crop);

AttachLegend("cut 4");

GShipout("felm_background_int_dg_fit");

//----------------------------------------------------------------------------------------------------

NewPad("$(\th_x^{*R} - \th_x^{*L})/\si$", "$$");
//scale(Linear, Log);

filldraw((-3, 0)--(+3, 0)--(+3, 200)--(-3, 200)--cycle, palegreen, nullpen);
label(rotate(90)*Label("selection region"), (0, 130), heavygreen);

draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel"), "vl,ec");
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel|ff"), blue+1pt);

label("signal", (5.5, 150), blue);
label(rotate(-35)*Label("background"), (7.5, 30), red);

//GetSignal(robj);
//draw(graph(gauss, -12, +12, 1000), heavygreen+1pt);

GetGauss(robj);
draw(graph(gauss, -12, +12, 1000), red+1pt);

limits((-12, 1e-0), (+12, 200), Crop);


GShipout("felm_background_int_dg_fit_cut1");

//----------------------------------------------------------------------------------------------------
// DISTRIBUTION

NewPad("$|t_x|\ung{GeV^2}$", "$|t_y|\ung{GeV^2}$", 5.2cm, 5.2cm, axesAbove=true);
scale(Linear, Linear, Log);
//TH2_palette = Gradient(blue, green, red, black);
TH2_palette = Gradient(blue, heavygreen, yellow, red, black);
draw(rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "hxy_L"), "p,bar");
limits((0, 0), (1.2, 1.2), Crop);

draw((0, 0.35)--(1.2, 0.35)--(0, 1.2)--cycle, red+dashed+1pt);

GShipout("felm_background_dist_txty");

//--------------------

NewPad("$|t_x|\ung{GeV^2}$", "$\d N/\d t_x$", 5.2cm, 5.2cm);
scale(Linear, Log);
draw(rGetObj(dir+"/h_x_r_45b_fit.root", "Canvas_1|hx_R"), "vl,ec", black);
TF1_lowLimit = 0.01;
draw(rGetObj(dir+"/h_x_r_45b_fit.root", "Canvas_1|hx_R|PrevFitTMP"), red+1pt);
limits((0, 1e0), (2, 1e3), Crop);

GShipout("felm_background_dist_tx");

//--------------------

NewPad("$|t|\ung{GeV^2}$", "$\d N_{\rm B}/\d t$");
scale(Linear, Log);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el"), "vl,ec", red);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el|ffel"), heavygreen+2pt);

draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc"), "vl,ec", blue);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc|ffel"), heavygreen+2pt);
limits((0, 1e1), (2.5, 1e6), Crop);

GShipout("felm_background_dist_t_el");

//----------------------------------------------------------------------------------------------------
// COMPARISON

/*
NewPage();
NewPad("$|t|\ung{GeV^2}$", "$\d N/\d t$");
scale(Linear, Log);
draw(shift(0, log10(1/0.05)), rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "h_t"), black+1pt, "signal+background");

//old background calculation
//draw(rGetObj(dir+"/background_with_errors2_45b_56t.root", "bckg_with_err"), "l,ec", red+1pt, "background new");
//draw(rGetObj(dir+"/background_with_errors_45b_56t.root", "bckg_with_err"), "l,ec", green+1pt, "background old");

draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc|ffel"), blue);
draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_max"), blue+dashed);
draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_min"), blue+dashed);


draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el|ffel"), red);
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_max"), red+dashed);
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_min"), red+dashed);

limits((0, 1e1), (2.5, 1e6), Crop);
yaxis(XEquals(0.36, false), dashed);
//AttachLegend("diagonal 45 bottom -- 56 top");


GShipout("felm_background_cmp");
*/
//--------------------

NewPad("$|t|\ung{GeV^2}$", "$\d N/\d t$");
currentpad.xTicks = LeftTicks(Step=0.5, step=0.1);
scale(Linear, Log);
//draw(shift(0, log10(1/0.05)), rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "h_t"), black, "");
draw(shift(0, log10(exp(11.6575) / exp(-3.7151))), rGetObj(dir+"/hubert/52_00a_correction_steps_bot_45_top_56.root", "tc|bot45_top56_t"), "vl,ec", blue, "");

label(rotate(-40)*Label("signal+background"), (1.5, 3.7), blue);

// old
//draw(rGetObj(dir+"/background_with_errors2_45b_56t.root", "bckg_with_err"), "l,ec", red+1pt, "background new");
//draw(rGetObj(dir+"/background_with_errors_45b_56t.root", "bckg_with_err"), "l,ec", green+1pt, "background old");

draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc"), "vl,ec", red);
//draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc|ffel"), red+1.5pt);

label(rotate(-49)*Label("background"), (1.2, 2.7), red);

TGraph_lowLimit = 0.6;
//draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_max"), red+dashed);
//draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_min"), red+dashed);
TGraph_lowLimit = -inf;

limits((0, 1e1), (2.5, 1e6), Crop);
//yaxis(XEquals(0.36, false), dashed);
AttachLegend("before acceptance correction");


GShipout("felm_background_before");

//--------------------

NewPad("$|t|\ung{GeV^2}$", "$\d N/\d t$");
currentpad.xTicks = LeftTicks(Step=0.5, step=0.1);
scale(Linear, Log);
//draw(shift(0, log10(1/0.05)), rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "h_t"), black, "");
draw(shift(0, log10(exp(11.6575) / exp(-3.7151))), rGetObj(dir+"/hubert/52_00a_correction_steps_bot_45_top_56.root", "tc|bot45_top56_t"), "vl,ec", black, "");

// old
//draw(rGetObj(dir+"/background_with_errors2_45b_56t.root", "bckg_with_err"), "l,ec", red+1pt, "background new");
//draw(rGetObj(dir+"/background_with_errors_45b_56t.root", "bckg_with_err"), "l,ec", green+1pt, "background old");

draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc"), "vl,ec", blue);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el_acc|ffel"), red+1.5pt);

TGraph_lowLimit = 0.6;
draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_max"), red+dashed);
draw(rGetObj(dir+"/mc2_anal.root", "h_el_acc/graphs|g_min"), red+dashed);
TGraph_lowLimit = -inf;

limits((0, 1e1), (2.5, 2e7), Crop);
//yaxis(XEquals(0.36, false), dashed);
AttachLegend("before acceptance correction");


NewPad("$|t|\ung{GeV^2}$", "$\d N/\d t$");
currentpad.xTicks = LeftTicks(Step=0.5, step=0.1);
scale(Linear, Log);

draw(shift(0, log10(exp(11.6575) / exp(-3.7151))), rGetObj(dir+"/hubert/52_00a_correction_steps_bot_45_top_56.root", "tc|bot45_top56_t_corr_dist"), "vl,ec", black, "");

draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el"), "vl,ec", blue);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el|ffel"), red+1.5pt);
TGraph_lowLimit = 0.3;
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_max"), red+dashed);
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_min"), red+dashed);
TGraph_lowLimit = -inf;


limits((0, 1e1), (2.5, 2e7), Crop);
//yaxis(XEquals(0.36, false), dashed);
AttachLegend("after acceptance correction");

GShipout("felm_background_cmp");

//--------------------

NewPad("$|t|\ung{GeV^2}$", "$\d N/\d t$");
currentpad.xTicks = LeftTicks(Step=0.5, step=0.1);
scale(Linear, Log);

draw(shift(0, log10(exp(11.6575) / exp(-3.7151))), rGetObj(dir+"/hubert/52_00a_correction_steps_bot_45_top_56.root", "tc|bot45_top56_t_corr_dist"), "vl,ec", black, "signal+background");

//draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el"), blue);
draw(rGetObj(dir+"/mc2.root", "nx=+0.0, ny=+0.0/h_el|ffel"), red+1.5pt, "background");
TGraph_lowLimit = 0.3;
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_max"), red+dashed);
draw(rGetObj(dir+"/mc2_anal.root", "h_el/graphs|g_min"), red+dashed);
TGraph_lowLimit = -inf;


limits((0, 1e1), (2.5, 2e7), Crop);
//yaxis(XEquals(0.36, false), dashed);
AttachLegend();

GShipout("felm_background_cmp_sum");


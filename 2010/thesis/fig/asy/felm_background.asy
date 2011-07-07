import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 6cm;

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

NewPad("$q_1/\si_1$", "");
//scale(Linear, Log);
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel"), "p");
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq1_dist_sel|ff"), blue+1pt);

GetSignal(robj);
draw(graph(gauss, -12, +12, 1000), heavygreen+1pt);

GetGauss(robj);
draw(graph(gauss, -12, +12, 1000), red+1pt);

limits((-12, 1e-0), (+12, 1700), Crop);

AttachLegend("cut 1");


NewPad("$q_4/\si_4$", "");
//scale(Linear, Log);
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq4_dist_sel"), "p");
draw(rGetObj(dir+"/bckg_45b_56t.root", "cq4_dist_sel|ff"), blue+1pt);

GetSignal(robj);
draw(graph(gauss, -12, +12, 1000), heavygreen+1pt);

GetGauss(robj);
draw(graph(gauss, -12, +12, 1000), red+1pt);

limits((-12, 1e-0), (+12, 1700), Crop);

AttachLegend("cut 4");

GShipout("felm_background_int_dg_fit");

//----------------------------------------------------------------------------------------------------
// DISTRIBUTION

NewPad("$|t_x|\un{GeV^2}$", "$|t_y|\un{GeV^2}$");
TH2_process = TH2_log;
draw(rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "hxy_L"), "p,i");
limits((0, 0), (1.2, 1.2), Crop);

draw((0, 0.4)--(1.2, 0.4)--(0, 1.2)--cycle, black);

GShipout("felm_background_dist_txty");

//--------------------

NewPad("$|t_x|\un{GeV^2}$", "");
scale(Linear, Log);
draw(rGetObj(dir+"/h_x_r_45b_fit.root", "Canvas_1|hx_R"), black);
TF1_lowLimit = 0.01;
draw(rGetObj(dir+"/h_x_r_45b_fit.root", "Canvas_1|hx_R|PrevFitTMP"), red+1pt);
limits((0, 1e-1), (2.5, 1e3), Crop);

GShipout("felm_background_dist_tx");

//--------------------

NewPad("$|t|\un{GeV^2}$", "");
scale(Linear, Log);
draw(rGetObj(dir+"/mc2.root", "h_m"));
draw(rGetObj(dir+"/mc2.root", "h_m|ffel"), red+1pt);
limits((0, 1e0), (2.5, 1e5), Crop);

GShipout("felm_background_dist_t_el");

//----------------------------------------------------------------------------------------------------
// COMPARISON

NewPage();
NewPad("$|t|\un{GeV^2}$", "$\d N/\d t$");
scale(Linear, Log);
draw(shift(0, log10(1/0.05)), rGetObj(dir+"/bckg_t_dist_from_th_x_45b_56t.root", "h_t"), black+1pt, "signal+background");
draw(rGetObj(dir+"/background2_with_errors_45b_56t.root", "bckg_with_err"), "l,ec", red+1pt, "background new");

limits((0, 1e1), (3, 1e6), Crop);
AttachLegend("diagonal 45 bottom -- 56 top");

GShipout("felm_background_cmp");

import root;
import pad_layout;

StdFonts();

//xSizeDef = 3.6cm; ySizeDef = xSizeDef;

//----------------------------------------------------------------------------------------------------

void DrawRegion(path p)
{
	filldraw(p, heavygreen+opacity(0.05), heavygreen);
}

//----------------------------------------------------------------------------------------------------


//string dir = "../alignment/elastic/2010_10_29-30";
string dir = "../alignment/elastic/2010_09_21";

string file = dir + "/selection.root";
string file_e = dir + "/alignment_errors.root";

string diag1 = "45 bottom - 56 top";
string diag2 = "45 top - 56 bottom";

real dxdx_d56t_a, dxdx_d56t_b;
real dxdx_d56b_a, dxdx_d56b_b;
real dyy_45_a, dyy_45_b;
real dyy_56_a, dyy_56_b;

real yy_near_n, yy_near_p, yy_far_n, yy_far_p;

real yx_45_near_a, yx_45_near_b;
real yx_45_far_a, yx_45_far_b;
real yx_56_near_a, yx_56_near_b;
real yx_56_far_a, yx_56_far_b;

include "../alignment/elastic/2010_09_21/cuts.cc";

TGraph_N_limit = 2000;

//----------------------------------------------------------------------------------------------------

// ----- th_x equal left and right -----
NewPad("$\left. x_F - x_N \right|_{45}\un{mm}$", "$\left. x_F - x_N \right|_{56}\un{mm}$");

TGraph_lowLimit = -1;
TGraph_highLimit = +1;

real w = 0.8, h = 0.08;
path p = (-w, -h)--(w, -h)--(w, h)--(-w, h)--cycle;
DrawRegion(shift(0, dxdx_d56t_b)*rotate(atan2(dxdx_d56t_a, 1)*180/3.141593)*p);

draw(rGetObj(file, diag1+"/cut 0/dx_56 vs dx_45"), "p", black);
draw(rGetObj(file, diag1+"/cut 1/dx_56 vs dx_45"), "p", red);

limits((-1, -1), (1, 1), Crop);
AttachLegend("cut 1");

/*
NewPad("$\left. x_F - x_N \right|_{45}\un{mm}$", "$\left. x_F - x_N \right|_{56}\un{mm}$");
DrawRegion(shift(0, dxdx_d56b_b)*rotate(atan2(dxdx_d56b_a, 1)*180/3.141593)*p);

draw(rGetObj(file, diag2+"/cut 0/dx_56 vs dx_45"), "p", black);
draw(rGetObj(file, diag2+"/cut 1/dx_56 vs dx_45"), "p", blue);

limits((-1, -1), (1, 1), Crop);
*/

TGraph_lowLimit = -inf;
TGraph_highLimit = +inf;

NewPad("distance from cut line$\un{mm}$");
draw(rGetObj(file_e, "dx_56 vs. dx_45 (45b-56t)"), "lR", black);
draw(rGetObj(file_e, "dx_56 vs. dx_45 (45b-56t)#0"), red+1pt);
limits((-0.2, 0), (0.2, 100), Crop);
yaxis(XEquals(-0.08, false), dotted);
yaxis(XEquals(+0.08, false), dotted);
AttachLegend();


NewRow();

// ----- th_y proportional to y -----
void DrawDyY(int rp1, int rp2, int rp3, int rp4, real a, real b)
{
	NewPad("$y_N\un{mm}$", "$y_F - y_N\un{mm}$");
	real h = 0.045;
	real w1 = -10, w2 = 10;
	path p = (w1, -h)--(w2, -h)--(w2, h)--(w1, h)--cycle;
	DrawRegion(shift(0, b)*rotate(a*180/3.141593)*p);
	
	draw(rGetObj(file, diag1+"/cut 1/"+format("%u", rp1)+", "+format("%u", rp2)+": (y_F - y_N) vs. y_N"), "p", black);
	draw(rGetObj(file, diag2+"/cut 1/"+format("%u", rp3)+", "+format("%u", rp4)+": (y_F - y_N) vs. y_N"), "p", black);
	
	draw(rGetObj(file, diag1+"/cut 2/"+format("%u", rp1)+", "+format("%u", rp2)+": (y_F - y_N) vs. y_N"), "p", red);
	draw(rGetObj(file, diag2+"/cut 2/"+format("%u", rp3)+", "+format("%u", rp4)+": (y_F - y_N) vs. y_N"), "p", blue);
	
	limits((-10, -0.3), (10, 0.3), Crop);
	//AttachLegend(format("%u", rp1) +", " + format("%u", rp3));
	AttachLegend("cut 2, sector 45", NW, NW);
}

DrawDyY(21, 25, 20, 24, dyy_45_a, dyy_45_b);
//DrawDyY(120, 124, 121, 125, dyy_56_a, dyy_56_b);

NewPad("distance from cut line$\un{mm}$");
currentpad.yTicks = RightTicks(Step=100, step=20);
draw(rGetObj(file_e, "45: dy vs. y"), "lR", black);
draw(rGetObj(file_e, "45: dy vs. y#0"), red+1pt);
limits((-0.2, 0), (0.2, 500), Crop);
yaxis(XEquals(-0.045, false), dotted);
yaxis(XEquals(+0.045, false), dotted);
AttachLegend();



NewRow();

// ----- x close to 0 -----

void DrawXY(int rp1, int rp2, real a, real b)
{
	NewPad("$x\un{mm}$", "$y\un{mm}$");
	
	real h1 = -11, h2 = 11;
	real w1 = -0.4, w2 = 0.4;
	path p = (w1, h1)--(w2, h1)--(w2, h2)--(w1, h2)--cycle;
	DrawRegion(shift(b, 0)*rotate(-a*180/3.141593)*p);
	
	draw(rGetObj(file, diag1+"/cut 2/"+format("%u", rp1)+": y vs. x"), "p", black);
	draw(rGetObj(file, diag1+"/cut 3/"+format("%u", rp1)+": y vs. x"), "p", red);
	
	draw(rGetObj(file, diag2+"/cut 2/"+format("%u", rp2)+": y vs. x"), "p", black);
	draw(rGetObj(file, diag2+"/cut 3/"+format("%u", rp2)+": y vs. x"), "p", blue);
	
	limits((-2, -10), (2, 10), Crop);
	AttachLegend("cut 3, 45 near");
	//AttachLegend(format("%u", rp1) +", " + format("%u", rp2));
}

DrawXY(21, 20, -0.036, -0.029);
//DrawXY(25, 24, -0.031, -0.027);

//DrawXY(120, 121, 0.042, -0.031);
//DrawXY(124, 125, 0.038, -0.030);

NewPad("distance from cut line$\un{mm}$");
draw(rGetObj(file_e, "45 near: y vs. x"), "lR", black);
draw(rGetObj(file_e, "45 near: y vs. x#0"), red+1pt);
limits((-1, 0), (1, 150), Crop);
yaxis(XEquals(-0.4, false), dotted);
yaxis(XEquals(+0.4, false), dotted);
AttachLegend();

GShipout(hSkip=2mm, vSkip=1mm);

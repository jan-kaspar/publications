import root;
import pad_layout;

StdFonts();

TGraph_reducePoints = 100;

string file = "../alignment/elastic/2010_10_29-30/selection.root";
//string file = "../alignment/elastic/2010_09_21/selection.root";
string diag = "45 bottom - 56 top";

// ----- th_x equal left and right -----
NewPad("$\left. x_F - x_N \right|_{45}\un{mm}$", "$\left. x_F - x_N \right|_{56}\un{mm}$");
real w = 0.8, h = 0.12;
path p = (-w, -h)--(w, -h)--(w, h)--(-w, h)--cycle;
filldraw(rotate(-45)*p, nullpen, red);

draw(rGetObj(file, diag+"/cut 0/dx_56 vs dx_45"), "p", black);
draw(rGetObj(file, diag+"/cut 1/dx_56 vs dx_45"), "p", red);

limits((-1, -1), (1, 1), Crop);


// ----- th_y proportional to y -----
NewPad("$y_N\un{mm}$", "$y_F - y_N\un{mm}$");
h = 0.06;
real w1 = 3, w2 = 8;
path p = (w1, -h)--(w2, -h)--(w2, h)--(w1, h)--cycle;
filldraw(shift(0, 0.002)*rotate(0.021*180/3.141593)*p, nullpen, red);

real w1 = -3, w2 = -8;
path p = (w1, -h)--(w2, -h)--(w2, h)--(w1, h)--cycle;
filldraw(shift(0, 0.070)*rotate(0.015*180/3.141593)*p, nullpen, red);

draw(rGetObj(file, diag+"/cut 1/120, 124: (y_F - y_N) vs. y_N"), "p", black);
draw(rGetObj(file, diag+"/cut 1/21, 25: (y_F - y_N) vs. y_N"), "p", black);

draw(rGetObj(file, diag+"/cut 3/120, 124: (y_F - y_N) vs. y_N"), "p", red);
draw(rGetObj(file, diag+"/cut 3/21, 25: (y_F - y_N) vs. y_N"), "p", red);

limits((-10, -0.3), (10, 0.3), Crop);


// ----- x close to 0 -----
NewPad("$x\un{mm}$", "$y\un{mm}$");

real h1 = 3, h2 = 10;
w1 = -0.4; w2 = 0.6;
path p = (w1, h1)--(w2, h1)--(w2, h2)--(w1, h2)--cycle;
filldraw(p, nullpen, red);

draw(rGetObj(file, diag+"/cut 3/120: y vs. x"), "p", black);
draw(rGetObj(file, diag+"/cut 4/120: y vs. x"), "p", red);

limits((-2, 3), (2, 10), Crop);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string topDir = "../analysis/";

transform xyswitch = (0, 0, 0, 1, 1, 0);

xSizeDef = 6cm;
ySizeDef = 1 * xSizeDef;

dotfactor = 1;

int ui = 3;
string period = "3";

//----------------------------------------------------------------------------------------------------

string rps[] = { "L_F", "L_N", "R_N", "R_F" };
string rp_labels[] = { "left far", "left near", "right near", "right far" };
real sh_top[] = { 9.5, 9.7, 8.5, 8.1 };
real sh_bot[] = { -7.7, -7.95, -9.7, -9.5 };
real sh_hor[] = { 3.6, 5.1, 7.8, 5.2 };

//----------------------------------------------------------------------------------------------------

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 11;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path det_shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
det_shape = scale(10) * rotate(45) * det_shape;

path hor_det_shape = shift(0, -cutEdge/sqrt(2)*10) * det_shape;

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$", "$y\ung{mm}$");

draw(shift(0, -sh_top[ui])*det_shape);
draw(shift(0, -sh_bot[ui])*scale(1, -1)*det_shape);

draw(shift(sh_hor[ui], 0)*rotate(-90)*hor_det_shape, blue);

//--------------------
string f = topDir+"DS2b/alignment.root";
string dir = "period " + period + "/unit " + rps[ui];


draw(xyswitch, rGetObj(f, dir+"/horizontal/horizontal graph fit/horizontal fit|merged"), "d", black);
draw(xyswitch, rGetObj(f, dir+"/horizontal/horizontal graph fit/horizontal fit|ff"), "l", cyan+1pt);
draw(xyswitch, rGetObj(f, dir+"/horizontal/horizontal profile/p"), "d0,eb", magenta+1pt);

//--------------------
string fData = topDir+"DS2b/alignment_horizontal.root";
string fFit = topDir+"DS2b/alignment_horizontal_fit.root";

TGraph_x_min = 7;
draw(rGetObj(fData, period+"/" + rps[ui]), "d", blue);
draw(rGetObj(fFit, "period "+period+"/unit R_N/graph fit/horizontal fit|ff"), heavygreen);
draw(rGetObj(fFit, "period "+period+"/unit R_N/profile/p"), "eb,d0", red+1pt);
//limits((0, -2), (15, +2), Crop);

limits((-5, -10), (+15, +10), Crop);
//AttachLegend(rp_labels[ui]);

GShipout(margin=0pt);

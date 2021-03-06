import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis/";

transform xyswitch = (0, 0, 0, 1, 1, 0);

xSizeDef = 6cm;
ySizeDef = 18/20 * xSizeDef;

dotfactor = 1;

int ui = 3;
string period = "3";

drawGridDef = false;

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

pen adashed = linetype(new real[] {7.1, 5});

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$", "$y\ung{mm}$");

//draw(shift(0, -sh_top[ui])*det_shape, black+1pt);
//draw(shift(0, -sh_bot[ui])*scale(1, -1)*det_shape, black+1pt);

//draw(shift(sh_hor[ui], 0)*rotate(-90)*hor_det_shape, blue+1pt);

//--------------------
string f = topDir+"DS2b/alignment.root";
string ff = topDir+"DS2b/alignment_fit.root";
string dir = "period " + period + "/unit " + rps[ui];

draw(xyswitch, RootGetObject(f, dir+"/horizontal/horizontal graph fit/horizontal fit|merged"), "d", black);
draw(xyswitch, RootGetObject(f, dir+"/horizontal/horizontal graph fit/horizontal fit|ff"), "l", heavygreen + adashed);
draw(xyswitch, RootGetObject(f, dir+"/horizontal/horizontal profile/p"), "d0,eb", heavygreen+1pt);

label(rotate(90)*Label("top RP"), (-4, 7), Fill(white+opacity(0.5)));
label(rotate(90)*Label("bottom RP"), (-4, -5), Fill(white+opacity(0.5)));

real l = 3, v = RootGetObject(ff, rps[ui] + "/c_fit").rExec("Eval", 1e5) / 1e3;
draw((-l, v)--(+l, v), blue + adashed);

//--------------------
string fData = topDir+"DS2b/alignment_horizontal.root";
string fFit = topDir+"DS2b/alignment_horizontal_fit.root";

TGraph_x_min = 7;
draw(RootGetObject(fData, period+"/" + rps[ui]), "d", black);
draw(RootGetObject(fFit, "period "+period+"/unit R_N/graph fit/horizontal fit|ff"), red+adashed);
draw(RootGetObject(fFit, "period "+period+"/unit R_N/profile/p"), "eb,d0", red+1pt);
//limits((0, -2), (15, +2), Crop);

label(rotate(90)*Label("horizontal RP"), (6.3, 5.5), Fill(white+opacity(0.5)));

limits((-5, -8), (+15, +10), Crop);
//AttachLegend(rp_labels[ui]);


draw(Label("beam", E), (0.2, 0.3)--(1.5, 1.5), BeginArrow);

GShipout(margin=0pt);

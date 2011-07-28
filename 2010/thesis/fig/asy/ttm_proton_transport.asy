unitsize(10mm);

StdFonts();

real z_IP = 0, z_v = 0.2, z_beg = 2, z_end = 7, z_la = 13, z_det_b = 9, z_det_e = 11.5;
real l_axis = 2, s_axis = 0.5, h_axis = 1.5, d_axis = 0.5, h_box = 0.7;
real y_lab = -1;

// s axis
draw((z_IP - s_axis, 0)--(z_det_e + l_axis, 0), EndArrow);
label("$s\equiv$ beam axis", (z_det_e + l_axis, 0), N);

// IP y axis
draw((z_IP, -d_axis)--(z_IP, h_axis), EndArrow);
label("$y$", (z_IP, h_axis), N);
label("IP", (z_IP, 0), SW, UnFill);

// local y axis
//draw((z_la, -d_axis)--(z_la, h_axis), EndArrow);
//label("$y$", (z_la, h_axis), N);

// LHC
filldraw((z_beg, h_box)--(z_beg, -h_box)--(z_end, -h_box)--(z_end, h_box)--cycle, lightgray, black);
label("LHC magnet lattice", ((z_beg + z_end)/2, y_lab), S);

// RP station
void DrawRP(pair p)
{
	real w = 0.07, h = 0.35;
	filldraw(shift(p)*((-w, -h)--(w, -h)--(w, h)--(-w, h)--cycle), black, nullpen);
}

real rp_h = 0.6, rp_f = 0.2;

DrawRP((z_det_b, rp_h));
DrawRP((z_det_b, -rp_h));
DrawRP((z_det_b + rp_f*(z_det_e-z_det_b), 0));
DrawRP((z_det_e - rp_f*(z_det_e-z_det_b), 0));
DrawRP((z_det_e, rp_h));
DrawRP((z_det_e, -rp_h));
label("RP station", ((z_det_b + z_det_e)/2, y_lab), S);

// proton track
real y_st = 0.8, th_y = -0.2;
real y_beg = y_st + (z_beg - z_IP) * th_y;
real y_end = 0.1, th_yp = 0.15;
real y_det = y_end + (z_det_e+s_axis - z_end) * th_yp;
real y_N = y_end + (z_det_b - z_end) * th_yp;
real y_F = y_end + (z_det_e - z_end) * th_yp;
real de = (z_end - z_beg) / 4;

draw(Label("$p^*$"), (z_v, y_st)--(z_beg, y_beg), blue+1pt, MidArrow(8));
draw((z_beg, y_beg){1, th_y}..(z_beg+de, -0.0)..(z_beg+2de, +0.5)..(z_beg+3de, -0.2)..{1, th_yp}(z_end, y_end), blue+dotted+1pt);
draw(Label("$p$", 0.5, N), (z_end, y_end)--(z_det_b, y_N), blue, MidArrow(8));
draw((z_det_b, y_N)--(z_det_e+s_axis, y_det), blue);

// IP vertex and scattering angle
draw((z_v, y_st)--(z_beg, y_st), dotted);
draw(arc((z_v, y_st), 0.75*(z_beg - z_v), 0, aTan(th_y)));

dot((z_v, y_st), blue);

label("$y^*$", (z_v, y_st), N+0.2E);
label("$\th_y^*$", (0.75*(z_beg - z_v), y_st), NW);

// angle and hits in station
draw((z_det_b, y_N)--(z_det_e, y_N), dotted);
label("$y_{\rm N}$", (z_det_b, y_N), NW);
label("$y_{\rm F}$", (z_det_e, y_F), NE);
draw(arc((z_det_b, y_N), 0.75*(z_det_e - z_det_b), 0, aTan(th_yp)));
label("$\th_y$", ((z_det_e + z_det_b)/2, y_F), 0.5*N);

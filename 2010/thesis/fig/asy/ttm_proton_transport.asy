unitsize(10mm);

StdFonts();

real z_IP = 0, z_v = 0.2, z_beg = 2, z_end = 7, z_la = 13, z_det_b = 9, z_det_e = 11.5;
real l_axis = 2, s_axis = 0.5, h_axis = 1.5, d_axis = 0.5, h_box = 0.7;
real x_lab = -1;

// s axis
draw((z_IP - s_axis, 0)--(z_det_e + l_axis, 0), EndArrow);
label("$s\equiv$ beam axis", (z_det_e + l_axis, 0), N);

// IP x axis
draw((z_IP, -d_axis)--(z_IP, h_axis), EndArrow);
label("$x$", (z_IP, h_axis), N);
label("IP", (z_IP, 0), SW, UnFill);

// local x axis
//draw((z_la, -d_axis)--(z_la, h_axis), EndArrow);
//label("$x$", (z_la, h_axis), N);

// LHC
filldraw((z_beg, h_box)--(z_beg, -h_box)--(z_end, -h_box)--(z_end, h_box)--cycle, lightgray, black);
label("LHC magnet lattice", ((z_beg + z_end)/2, x_lab), S);

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
label("RP station", ((z_det_b + z_det_e)/2, x_lab), S);

// proton track
real x_st = 0.8, th_x = -0.2;
real x_beg = x_st + (z_beg - z_IP) * th_x;
real x_end = 0.1, th_xp = 0.15;
real x_det = x_end + (z_det_e+s_axis - z_end) * th_xp;
real x_N = x_end + (z_det_b - z_end) * th_xp;
real x_F = x_end + (z_det_e - z_end) * th_xp;
real de = (z_end - z_beg) / 4;

draw(Label("$p^*$"), (z_v, x_st)--(z_beg, x_beg), blue+1pt, MidArrow(8));
draw((z_beg, x_beg){1, th_x}..(z_beg+de, -0.0)..(z_beg+2de, +0.5)..(z_beg+3de, -0.2)..{1, th_xp}(z_end, x_end), blue+dotted+1pt);
draw(Label("$p$", 0.5, N), (z_end, x_end)--(z_det_b, x_N), blue, MidArrow(8));
draw((z_det_b, x_N)--(z_det_e+s_axis, x_det), blue);

// IP vertex and scattering angle
draw((z_v, x_st)--(z_beg, x_st), dotted);
draw(arc((z_v, x_st), 0.75*(z_beg - z_v), 0, aTan(th_x)));

dot((z_v, x_st), blue);

label("$x^*$", (z_v, x_st), N+0.2E);
label("$\th_x^*$", (0.75*(z_beg - z_v), x_st), NW);

// angle and hits in station
draw((z_det_b, x_N)--(z_det_e, x_N), dotted);
label("$x_{\rm N}$", (z_det_b, x_N), NW);
label("$x_{\rm F}$", (z_det_e, x_F), NE);
draw(arc((z_det_b, x_N), 0.75*(z_det_e - z_det_b), 0, aTan(th_xp)));
label("$\th_x$", ((z_det_e + z_det_b)/2, x_F), 0.5*N);

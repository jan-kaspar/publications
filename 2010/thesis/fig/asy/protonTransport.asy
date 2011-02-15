unitsize(1cm);

StdFonts();

real z_IP = 0, z_det = 9, z_beg = 2, z_end = 7;
real l_axis = 2, h_axis = 1.5, h_box = 1;

draw((z_IP - l_axis, 0)--(z_det + l_axis, 0), EndArrow);
draw((z_IP, -h_axis)--(z_IP, h_axis), EndArrow);
draw((z_det, -h_axis)--(z_det, h_axis), EndArrow);
filldraw((z_beg, h_box)--(z_beg, -h_box)--(z_end, -h_box)--(z_end, h_box)--cycle, lightgray, black);

label("IP", (z_IP, 0), S, UnFill);
label("$x$", (z_IP, h_axis), N);
label("det", (z_det, 0), S, UnFill);
label("$x$", (z_det, h_axis), N);
label("$z\equiv$ beam axis", (z_det + l_axis, 0), N);
label("LHC magnet lattice", ((z_beg + z_end)/2, -h_box), S);

real x_st = 0.8, th_x = -0.2;
real x_beg = x_st + (z_beg - z_IP) * th_x;
real x_end = 0.2, th_xp = 0.1;
real x_det = x_end + (z_det - z_end) * th_xp;
real de = (z_end - z_beg) / 4;

draw((z_IP, x_st)--(z_beg, x_beg), blue+1pt);
draw((z_beg, x_beg){1, th_x}..(z_beg+de, -0.0)..(z_beg+2de, +0.5)..(z_beg+3de, -0.2)..{1, th_xp}(z_end, x_end), blue+dotted+1pt);
draw((z_end, x_end)--(z_det, x_det), blue+1pt);

draw((z_IP, x_st)--(z_beg, x_st), dotted);
draw(arc((z_IP, x_st), 0.75*(z_beg - z_IP), 0, aTan(th_x)));

label("$x^*$", (z_IP, x_st), NE);
label("$\th_x^*$", (0.75*(z_beg - z_IP), x_st), NW);
label("$x_{\rm det}$", (z_det, x_det), NW);

path p = (0.75*(z_beg - z_IP) - 0.8, x_st+0.5){1, 0.5}..{1, -0.5}(z_det-1, x_det+0.5);
label("optical functions", p, N);
draw(p, EndArrow);

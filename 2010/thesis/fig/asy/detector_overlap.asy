unitsize(1cm);

StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 25;
real margin_v_e = 0.1;
real margin_v_b = 0.2;
real margin_u = 0.1;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

// strips
pen strip_color = black;
real delta = (edge - margin_v_b - margin_v_e) / (strips - 1);
for (int i = 0; i < strips; ++i) {
	draw(Det, (margin_u, margin_v_b + i*delta)--(edge-margin_u, margin_v_b + i*delta), strip_color+0.1pt);
}

// clip shape and draw boundary
clip(Det, Det0Shape);
draw(Det, Det0Shape, black + 1pt);

//----------------------------------------------------------------------------------------------------

dot((0, 0), blue);

real m = 3;
real si_x = 0.8/7; // in cm
real si_y = 0.51/7;

real sx_hor = m*si_x, sy_top = m*si_y, sy_bot = m*si_y;
//real sx_hor = 0.64, sy_top = 1.0961, sy_bot = 1.1111;
//real sx_hor = 0., sy_top = 0., sy_bot = 0.;

real gap = 0.03;
sy_top += gap;
sy_bot += gap;
sx_hor += gap;

strip_color = blue; add(shift(0, +sy_top) * rotate(45) * shift(-cutEdge/2, -cutEdge/2) * Det);
strip_color = red; add(shift(+sx_hor, 0) * rotate(-45) * shift(-cutEdge/2, -cutEdge/2) * Det);
strip_color = heavygreen; add(shift(0, -sy_bot) * rotate(-135) * shift(-cutEdge/2, -cutEdge/2) * Det);

draw((1.5, 1.5)--(3, 3), red, BeginArrow);
label("\BiggerFonts overlap", (3, 3), NE, red);

label("\BiggerFonts top RP", (0, 2.6), heavygreen, UnFill);
label("\BiggerFonts horizontal RP", (2.6, 0), heavygreen, UnFill);
label("\BiggerFonts bottom RP", (0, -2.6), heavygreen, UnFill);

unitsize(1cm);

fonts10();

//----------------------------------------------------------------------------------------------------

picture Det;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 75;
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

dot((0, 0), red);

real m = 5;
real si_x = 0.8/7; // in cm
real si_y = 0.71/7;

real sx = m*si_x, sy = m*si_y;
strip_color = blue; add(shift(0, +sy) * rotate(45) * shift(-cutEdge/2, -cutEdge/2) * Det);
strip_color = red; add(shift(+sx, 0) * rotate(-45) * shift(-cutEdge/2, -cutEdge/2) * Det);
strip_color = heavygreen; add(shift(0, -sy) * rotate(-135) * shift(-cutEdge/2, -cutEdge/2) * Det);

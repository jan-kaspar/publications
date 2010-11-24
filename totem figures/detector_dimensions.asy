unitsize(1.5mm);

//----------------------------------------------------------------------------------------------------

picture Det0;

real edge = 36.070;
real cutEdge = 22.276 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);
real centerToOuterWindow = 14.717;
real windowThickness = 0.150;

int strips = 75;
real margin_v_f = 2;
real margin_v_l = 3;
real margin_u_f = 4;
real margin_u_l = 2;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

// strips
real delta = (edge - margin_v_l - margin_v_f) / (strips - 1);
for (int i = 0; i < strips; ++i) {
	draw(Det0, (margin_u_l, margin_v_l + i*delta)--(edge-margin_u_f, margin_v_l + i*delta), black+0.1pt);
}

// clip shape and draw boundary
clip(Det0, Det0Shape);
draw(Det0, Det0Shape, black + 2);


//----------------------------------------------------------------------------------------------------

void ShowLength(pair p1, pair p2, pair dir, string lab, real offset)
{
	// determine end points for arrows
	dir = unit(dir);
	real pr1 = dot(p1, dir);
	real pr2 = dot(p2, dir);

	real pr = max(pr1, pr2) + offset;

	pair p1p = p1 + (pr - pr1) * dir;
	pair p2p = p2 + (pr - pr2) * dir;

	// draw arrow
	draw(p1p--p2p, Arrows);

	// draw guide-lines
	draw(p1--p1p, dashed);
	draw(p2--p2p, dashed);
	
	// determine label angle and alignment
	real ang = 0;
	ang = degrees(p2p - p1p);
	if (90 < ang && ang < 180) {
		ang = ang + 180;
	}
	if (180 <= ang && ang < 270) {
		ang = ang - 180;
	}

	pair labPos = (p1p+p2p)/2;

	// draw label
	label(rotate(ang)*Label(lab), labPos, dir);
}

//----------------------------------------------------------------------------------------------------

real c = 80;

add(shift(0, 0) * rotate(45) * shift(-edge/2, -edge/2) * Det0);


real s2 = sqrt(2);
ShowLength((edge/s2, 0), (0, edge/s2), (1, 1), format("%#.3f", edge), 10);
ShowLength((-edge/s2, 0), (0, edge/s2), (-1, 1), format("%#.3f", edge), 10);
ShowLength((0, edge/s2), ((margin_v_f-margin_u_f)/s2, (edge-margin_v_f-margin_u_f)/s2), (1, 1), "\hskip12mm 0.9215", 5);
ShowLength((edge/s2, 0), ((edge-margin_v_l-margin_u_f)/s2, (margin_v_l-margin_u_f)/s2), (1, 1), "\hskip-8mm 1.4175", 5);
ShowLength((0, edge/s2), ((margin_v_f-margin_u_f)/s2, (edge-margin_v_f-margin_u_f)/s2), (-1, 1), "\hskip-8mm 2.38", 5);
ShowLength((-edge/s2, 0), ((-edge+margin_v_f+margin_u_l)/s2, (-margin_v_f+margin_u_l)/s2), (-1, 1), "\hskip6mm 0.7", 5);

ShowLength((-edge/s2, 0), (-edge/s2+eD, -eD), (-1, -1), format("%#.3f", edge-cutEdge), 5);
ShowLength((edge/s2, 0), (edge/s2-eD, -eD), (1, 0), format("%#.3f", (edge-cutEdge)/sqrt(2)), 5);
ShowLength((edge/s2-eD, -eD), (-edge/s2+eD, -eD), (0, -1), format("%#.3f", cutEdge*sqrt(2)), 5);

//----------------------------------------------------------------------------------------------------

real c = 80;
real g = 8;
real tw = 3;
real tww = 20;
real b = 20;
add(shift(c, 0) * rotate(45) * shift(-edge/2, -edge/2) * Det0);
ShowLength((c+edge/s2, 0), (c+edge/s2-eD, -eD), (1, 0), format("%#.3f", (edge-cutEdge)/sqrt(2)), 5);
ShowLength((c+edge/s2, 0), (c, -eD-g-tw), (1, 0), format("%#.3f", centerToOuterWindow), 10);

ShowLength((c-edge/s2+eD, -eD), (c-tww, -eD-g), (-1, 0), format("%#.3f", -(edge-cutEdge)/sqrt(2) + centerToOuterWindow - windowThickness), 5);
ShowLength((c-tww, -eD-g), (c-tww, -eD-g-tw), (-1, 0), format("%#.3f", windowThickness), 9);

ShowLength((c, -eD-g-tw), (c, -eD-b),  (1, 0), "DDL", 10);

draw((c-tww, -eD-g)--(c+tww, -eD-g), black+2);
draw((c-tww, -eD-g-tw)--(c+tww, -eD-g-tw), black+2);

filldraw(shift(c, -eD-b)*scale(0.5)*unitcircle, black);

//import pad_layout;
import three;
import math;

unitsize(1cm);

currentprojection = orthographic((-1.0, -0.4, 4), (0, 1, 0));

// basic shape
real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);
real cE2 = 2.22721 / 2;

path3 DetShape = (cutEdge, 0, 0)--(edge, 0, 0)--(edge, edge, 0)--(0, edge, 0)--(0, cutEdge, 0)--cycle;

// add strips
int nStrips = 23;
real margin = 0.1;

// strips
real delta = (edge - 2 * margin) / (nStrips - 1);
path3 strips[];
for (int i = 0; i < nStrips; ++i) {
	real y = margin + i*delta;
	real x0 = margin;
	if (y < cutEdge) x0 = cutEdge - y;
	path3 strip = (x0, y, 0)--(edge-margin, y, 0);
	strips.push( strip );
}


void DrawDet(transform3 align, string L)
{
	draw(surface(align * DetShape), white, nolight);
	draw(align * DetShape, black+2);
	for (int i = 0; i < strips.length; ++i) {
		draw(align * strips[i], gray);
	}

	real aLen = 4;
	draw(align * ((edge/2, edge/2, 0)--(edge/2, edge/2+aLen, 0)), EndArrow3);
	label(L, align * (edge/2, edge/2+aLen * 1.08, 0));
}

//----------------------------------------------------------------------------------------------------

real d = 3;

DrawDet(shift(0, 0, 3*d) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "$U$");
DrawDet(shift(0, 0, 2*d) * rotate(45, (0, 0, 1)), "$V$");
DrawDet(shift(0, 0, 1*d) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "$U$");
DrawDet(shift(0, 0, 0*d) * rotate(45, (0, 0, 1)), "$V$");

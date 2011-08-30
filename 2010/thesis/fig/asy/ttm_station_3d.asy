import three;
import math;

StdFonts();

void PreparePicture()
{
	unitsize(1cm);
	currentprojection = perspective(3*(-12, 6.5, 9), up=Y, autoadjust=true, center=false);
	//currentprojection = orthographic((-1.0, 0.4, 1), (0, 1, 0));
}

//----------------------------------------------------------------------------------------------------

transform3 ZRot(real phi)
{
	return rotate(phi, (0, 0, 1));
}

//----------------------------------------------------------------------------------------------------

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


void DrawDet(transform3 align, string L, triple aligPoint = (4, 4, 0)) {
	draw(align * DetShape, black+2);
	for (int i = 0; i < strips.length; ++i) {
		draw(align * strips[i], gray);
	}

	real aLen = 4;
	draw(align * ((edge/2, edge/2, 0)--(edge/2+aLen, edge/2, 0)), EndArrow3);
	draw(align * ((edge/2, edge/2, 0)--(edge/2, edge/2+aLen, 0)), EndArrow3);
	label("$u$", align * (edge/2+aLen * 1.08, edge/2, 0));
	label("$v$", align * (edge/2, edge/2+aLen * 1.08, 0));

	label(XY*Label("" + L), align * aligPoint);
}

//----------------------------------------------------------------------------------------------------

PreparePicture();

// RP 120
draw((0, edge/sqrt(2), -3)--(0, edge/sqrt(2), 0), dotted);
DrawDet(rotate(45, (0, 0, 1)), "1200");
draw((0, edge/sqrt(2), 0)--(0, edge/sqrt(2), 6), dotted);

DrawDet(shift(0, 0, 6) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "1201");
draw((0, edge/sqrt(2), 6)--(0, edge/sqrt(2), 8.7), dotted, EndBar3(20));
draw((0, edge/sqrt(2), 9)--(0, edge/sqrt(2), 10), dotted, BeginBar3(20));

draw((0, 0, 0)--(0, cE2, 0), dotted);
draw((0, 0, 6)--(0, cE2, 6), dotted);

// RP 121
draw((0, -edge/sqrt(2), -3)--(0, -edge/sqrt(2), 0), dotted);
DrawDet(rotate(-135, (0, 0, 1)), "1210");
draw((0, -edge/sqrt(2), 0)--(0, -edge/sqrt(2), 6), dotted);
DrawDet(shift(0, 0, 6) * rotate(180, (0, 1, 0)) * rotate(-135, (0, 0, 1)), "1211");
draw((0, -edge/sqrt(2), 6)--(0, -edge/sqrt(2), 8.7), dotted);

draw((0, 0, 0)--(0, -cE2, 0), dotted);
draw((0, 0, 6)--(0, -cE2, 6), dotted);

// RP 122
draw((edge/sqrt(2), 0, 10)--(edge/sqrt(2), 0, 13.5), dotted, EndBar3(20));
draw((edge/sqrt(2), 0, 13.8)--(edge/sqrt(2), 0, 15), dotted, BeginBar3(20));
DrawDet(shift(0, 0, 15) * rotate(-45, (0, 0, 1)), "1220", (-0.275, 4., 0));
draw((edge/sqrt(2), 0, 15)--(edge/sqrt(2), 0, 18), dotted);
DrawDet(shift(0, 0, 18) * rotate(180, (1, 0, 0)) * rotate(-45, (0, 0, 1)), "1221", (4., -0.275, 0));
draw((edge/sqrt(2), 0, 18)--(edge/sqrt(2), 0, 20), dotted);

draw((0, 0, 15)--(cE2, 0, 15), dotted);
draw((0, 0, 18)--(cE2, 0, 18), dotted);

// axes and beam line
draw((0, 0, -3)--(0, 0, 8.7), dashed, EndBar3(20));
draw((0, 0, 9)--(0, 0, 13.5), dashed, BeginBar3(20), EndBar3(20));
draw((0, 0, 13.8)--(0, 0, 20), dashed, BeginBar3(20));
label(zscale3(-1)*ZY*Label("beam line"), (0, -0.5, 11));

real aLen = 3;
real az = 10;
draw((0, 0, az)--(1.5*aLen, 0, az), black+1, EndArrow3(9));
draw((0, 0, az)--(0, aLen, az), black+1, EndArrow3(9));
draw((0, 0, az)--(0, 0, az+aLen), black+1, EndArrow3(9));
label("$x$", (1.5*aLen, 0, az), E);
label("$y$", (0, aLen, az), N);
label("$z$", (0, 0, az+aLen), S);

import three;
import math;

StdFonts();

void PreparePicture()
{
	unitsize(1cm);
	currentprojection = perspective(3*(-12, 6, 10), up=Y, autoadjust=true, center=false);
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


void DrawDet(transform3 align, string L, triple aligPoint = (4, 4, 0))
{
	draw(align * DetShape, black+2);
	for (int i = 0; i < strips.length; ++i) {
		draw(align * strips[i], gray);
	}

	real aLen = 4;
	draw(align * ((edge/2, edge/2, 0)--(edge/2+aLen, edge/2, 0)), EndArrow3);
	draw(align * ((edge/2, edge/2, 0)--(edge/2, edge/2+aLen, 0)), EndArrow3);
	label("$u$", align * (edge/2+aLen * 1.08, edge/2, 0));
	label("$v$", align * (edge/2, edge/2+aLen * 1.08, 0));
	dot(align * (edge/2, edge/2, 0), black+3pt);

	//label(XY*Label("" + L), align * aligPoint);
	label(Label(L), align * aligPoint);
}

//----------------------------------------------------------------------------------------------------

PreparePicture();

real xSh = 0.7;

real zb = -3, ze = 20;
real zv1 = 0, zv2 = 6, zh1 = 13.5, zh2 = 17;
real zd1 = 8, zd2 = 12.5, zg = 0.06, za = 10;

// RP 120 (top)
draw((0, edge/sqrt(2), zb)--(0, edge/sqrt(2), zv1), dotted);
DrawDet(shift(xSh, 0, zv1) * rotate(45, (0, 0, 1)), "top-1");
draw((0, edge/sqrt(2), zv1)--(xSh, edge/sqrt(2), zv1), red+1pt, EndArrow3);
dot((0, edge/sqrt(2), zv1), red+3pt);
draw((0, edge/sqrt(2), zv1)--(0, edge/sqrt(2), zv2), dotted);

DrawDet(shift(-xSh, 0, zv2) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "top-2");
draw((0, edge/sqrt(2), zv2)--(-xSh, edge/sqrt(2), zv2), red+1pt, EndArrow3);
dot((0, edge/sqrt(2), zv2), red+3pt);
draw((0, edge/sqrt(2), zv2)--(0, edge/sqrt(2), zd1-zg), dotted, EndBar3(20));
draw((0, edge/sqrt(2), zd1+zg)--(0, edge/sqrt(2), za), dotted, BeginBar3(20));

draw((0, 0, zv1)--(0, cE2, zv1), heavygreen);
draw((0, 0, zv2)--(0, cE2, zv2), heavygreen);
dot((0, 0, zv1), black+3pt);
dot((0, 0, zv2), black+3pt);

// RP 121 (bottom)
draw((0, -edge/sqrt(2), zb)--(0, -edge/sqrt(2), zv1), dotted);
DrawDet(shift(-xSh, 0, zv1) * rotate(-135, (0, 0, 1)), "bot-1");
draw((0, -edge/sqrt(2), zv1)--(-xSh, -edge/sqrt(2), zv1), red+1pt, EndArrow3);
dot((0, -edge/sqrt(2), zv1), red+3pt);

draw((0, -edge/sqrt(2), zv1)--(0, -edge/sqrt(2), zv2), dotted);
DrawDet(shift(xSh, 0, zv2) * rotate(180, (0, 1, 0)) * rotate(-135, (0, 0, 1)), "bot-2");
draw((0, -edge/sqrt(2), zv2)--(xSh, -edge/sqrt(2), zv2), red+1pt, EndArrow3);
dot((0, -edge/sqrt(2), zv2), red+3pt);
draw((0, -edge/sqrt(2), zv2)--(0, -edge/sqrt(2), za), dotted);

draw((0, 0, zv1)--(0, -cE2, zv1), heavygreen);
draw((0, 0, zv2)--(0, -cE2, zv2), heavygreen);

// RP 122 (hor)
draw((edge/sqrt(2), 0, 10)--(edge/sqrt(2), 0, zd2-zg), dotted, EndBar3(20));
draw((edge/sqrt(2), 0, zd2+zg)--(edge/sqrt(2), 0, zh1), dotted, BeginBar3(20));

DrawDet(shift(0, -xSh, zh1) * rotate(-45, (0, 0, 1)), "hor-1", (-0.275, 4., 0));
draw((edge/sqrt(2), 0, zh1)--(edge/sqrt(2), -xSh, zh1), red+1pt, EndArrow3);
dot((edge/sqrt(2), 0, zh1), red+3pt);

draw((edge/sqrt(2), 0, zh1)--(edge/sqrt(2), 0, zh2), dotted);

DrawDet(shift(0, +xSh, zh2) * rotate(180, (1, 0, 0)) * rotate(-45, (0, 0, 1)), "hor-2", (4., -0.275, 0));
draw((edge/sqrt(2), 0, zh2)--(edge/sqrt(2), xSh, zh2), red+1pt, EndArrow3);
dot((edge/sqrt(2), 0, zh2), red+3pt);

draw((edge/sqrt(2), 0, zh2)--(edge/sqrt(2), 0, ze), dotted);

draw((0, 0, zh1)--(cE2, 0, zh1), heavygreen);
draw((0, 0, zh2)--(cE2, 0, zh2), heavygreen);
dot((0, 0, zh1), black+3pt);
dot((0, 0, zh2), black+3pt);

// axes and beam line
draw((0, 0, zb)--(0, 0, zd1-zg), blue, EndBar3(20));
draw((0, 0, zd1+zg)--(0, 0, zd2-zg), blue, BeginBar3(20), EndBar3(20));
draw((0, 0, zd2+zg)--(0, 0, ze), blue, BeginBar3(20), EndArrow3(9));
label(zscale3(-1)*ZY*Label("beam"), (0, -0.3, ze), blue);

real aLen = 3;
real az = 10;
draw(Label("$x$", 1), (0, 0, az)--(aLen, 0, az), black+1, EndArrow3(9));
draw(Label("$y$", 1), (0, 0, az)--(0, aLen, az), black+1, EndArrow3(9));
draw(Label("$z$", 1, S), (0, 0, az)--(0, 0, az+aLen*0.7), black+1, EndArrow3(9));

draw(Label("$U$", 1), (0, 0, az)--(aLen/sqrt(2), aLen/sqrt(2), az), black+1, EndArrow3(9));
draw(Label("$V$", 1), (0, 0, az)--(-aLen/sqrt(2), aLen/sqrt(2), az), black+1, EndArrow3(9));

draw(arc((0, 0, az), (aLen, 0, az), (-aLen, 0, az), (0, 0, 1)), dotted);
draw((0, 0, az)--(-aLen, 0, az), dotted);
draw((0, 0, az)--(0, -aLen, az), dotted);

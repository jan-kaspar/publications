import three;
import math;

StdFonts();

unitsize(3mm);
currentprojection = orthographic((-1.0, 0.4, 1), (0, 1, 0));

//----------------------------------------------------------------------------------------------------

transform3 ZRot(real phi)
{
	return rotate(phi, (0, 0, 1));
}

//----------------------------------------------------------------------------------------------------

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);

path3 Det0 = (cutEdge, 0, 0)--(edge, 0, 0)--(edge, edge, 0)--(0, edge, 0)--(0, cutEdge, 0)--cycle;
path3 Det = rotate(45, (0, 0, 1)) * Det0;


void DrawStation(int id, transform3 pos, string label)
{
	real dY = 0.5;
	real dX = 0;
	real lY = 2.6;
	real lX = 2.8;
	real dZ = 8;
	real f1 = -1.3, f2 = -0.3, f3 = 0.3, f4 = 1.3;
	if (id < 10) dZ = -dZ;

	draw(shift(0, +dY, f1*dZ) * pos * Det, black+1);
	draw(shift(0, -dY, f1*dZ) * pos * ZRot(180) * Det, black+1);
	label(project(Label(format("%03i", 10*id + 0)), X, Y, pos * (0, lY+dY, f1*dZ)));
	label(project(Label(format("%03i", 10*id + 1)), X, Y, pos * (0, -lY-dY, f1*dZ)));
	
	draw(shift(+dX, 0, f2*dZ) * pos * ZRot(-90) * Det, black+1);
	draw(shift(+dX, 0, f3*dZ) * pos * ZRot(-90) * Det, black+1);
	label(project(Label(format("%03i", 10*id + 2)), X, Y, pos * (dX+lX, 0, f2*dZ)));
	label(project(Label(format("%03i", 10*id + 3)), X, Y, pos * (dX+lX, 0, f3*dZ)));
	
	draw(shift(0, +dY, f4*dZ) * pos * Det, black+1);
	draw(shift(0, -dY, f4*dZ) * pos * ZRot(180) * Det, black+1);
	label(project(Label(format("%03i", 10*id + 4)), X, Y, pos * (0, lY+dY, f4*dZ)));
	label(project(Label(format("%03i", 10*id + 5)), X, Y, pos * (0, -lY-dY, f4*dZ)));
	
	label(project(Label(format("station %02i", id)), Z, Y, pos * (0, -5, 0)));
	label(project(Label(label), Z, Y, pos * (0, -8, 0 + f4*dZ)));
}

DrawStation(12, shift(0, 0, +65), "+220 m");
DrawStation(10, shift(0, 0, +25), "+210 m");
DrawStation( 0, shift(0, 0, -25), "-210 m");
DrawStation( 2, shift(0, 0, -65), "-220 m");


// axes and beam line
draw((0, 0, 0)--(8, 0, 0), black+2, EndArrow3(10));
draw((0, 0, 0)--(0, 5.5, 0), black+2, EndArrow3(10));
draw((0, 0, 0)--(0, 0, 8), black+2, EndArrow3(10));
label("$x$", (8, 0, 0), E);
label("$y$", (0, 5.5, 0), N);
label("$z$", (0, 0, 8), S);
draw((0, 0, -80)--(0, 0, +80), dashed);

label(project(Label("beam axis"), Z, Y, (0, +1, -4)));

draw((0, -4, 0)--(0, -4, 5), black+2, EndArrow3(10));
draw((0, -6, 5)--(0, -6, 0), black+2, EndArrow3(10));
label(project(Label("beam 1"), Z, Y, (0, -4, -4)));
label(project(Label("beam 2"), Z, Y, (0, -6, -4)));

label(project(Label("\SetFontSizesXX LHC: sector 45, RP: left arm, CMS: z+, Towards: Jura"), Z, Y, (0, +10, -40)));
label(project(Label("\SetFontSizesXX LHC: sector 56, RP: right arm, CMS: z-, Towards: lake"), Z, Y, (0, +10, +40)));

shipout(bbox(3mm, nullpen));

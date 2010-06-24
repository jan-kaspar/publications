import graph;

size(7cm, 7cm, IgnoreAspect);

real p = 7e3, m = 0.938;
real E = sqrt(p^2 + m^2);

real rapidity(real th)
{
	real pz = p*cos(th);
	return log((E + pz) / (E - pz)) / 2.;
}

real pseudorapidity(real th)
{
	return -log(tan(th/2));
}

picture p1 = currentpicture;

scale(Log, Linear);

draw(graph(rapidity, 1e-6, pi/2), blue+1pt, "rapidity");
draw(graph(pseudorapidity, 1e-6, pi/2), red+1pt, "pseudorapidity");

xaxis("$\th$", Bottom, LeftTicks);
yaxis("$y, \et$", Left, RightTicks(trailingzero));

attach(legend(linelength=5mm), (2, 12), W);
currentpen += blue;
label("$9.61$", (-6, 9.61), SE*2.5);

shipout(bbox(2mm, nullpen));

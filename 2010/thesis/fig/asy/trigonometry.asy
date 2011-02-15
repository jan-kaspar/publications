import pad_layout;

StdFonts();

real min = 0;
real max = 3.141593/2;

real id(real x)
{
	return x;
}

bool plAbs = false;

real effCos(real x)
{
	return cos(x) - 1;
}

real sinDif(real x)
{
	real v = (sin(x) - x);
	return (plAbs) ? fabs(v) : v;
}

real cosDif(real x)
{
	real v = (cos(x) - 1);
	return (plAbs) ? fabs(v) : v;
}

real tanDif(real x)
{
	return (tan(x) - x);
}

NewPad("$x$", "");
scale(Linear, Linear);

draw(graph(id, min, max), black, "$x$");
draw(graph(sin, min, max), red, "$\sin x$");
draw(graph(cos, min, max), heavygreen, "$\cos x$");
draw(graph(tan, min, max*0.9), blue, "$\tan x$");

limits((min, 0), (max, 3), Crop);
AttachLegend(NW, NW);



NewPad("$x$", "");
scale(Linear, Linear);

draw(graph(sinDif, min, max), red, "$\sin x - x$");
draw(graph(cosDif, min, max), heavygreen, "$\cos x - 1$");
draw(graph(tanDif, min, max*0.9), blue, "$\tan x - x$");

//draw((min, +5)--(max, +5), dotted, "$\pm 5\%$ band");
//draw((min, -5)--(max, -5), dotted);

limits((min, -1), (max, 2), Crop);
AttachLegend(NW, NW);



min = 1e-4;
plAbs = true;
NewPad("$x$", "");
scale(Log, Log);

draw(graph(sinDif, min, max), red, "$\sin x - x$");
draw(graph(cosDif, min, max), heavygreen, "$\cos x - 1$");
draw(graph(tanDif, min, max*0.9), blue, "$\tan x - x$");

yaxis(XEquals(1e-1, false), dotted);
yaxis(XEquals(1e-2, false), dotted);
yaxis(XEquals(1e-3, false), dotted);

xaxis(YEquals(1e-11, false), dotted);
xaxis(YEquals(1e-9, false), dotted);
xaxis(YEquals(1e-7, false), dotted);
xaxis(YEquals(1e-5, false), dotted);
xaxis(YEquals(1e-3, false), dotted);
xaxis(YEquals(1e-1, false), dotted);

limits((min, 1e-13), (max, 1e1), Crop);
AttachLegend(NW, NW);

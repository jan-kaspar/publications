import pad_layout;

xSizeDef = 8cm;
ySizeDef = 8cm;

//----------------------------------------------------------------------------------------------------

real y, ys = 0.15;

void DrawPointUnc(real v, real u, pen p = red)
{
	draw((v, y), mCi+3pt+p);
	draw((v-u, y)--(v+u, y), p+1pt);

	y -= ys;
}

//----------------------------------------------------------------------------------------------------

void DrawRange(real vf, real vt)
{
	real h = 0.05;
	filldraw((vf, y-h)--(vt, y-h)--(vt, y+h)--(vf, y+h)--cycle, cyan, nullpen);
}

//----------------------------------------------------------------------------------------------------

string MeasDesc(real vr)
{
	int v = floor(vr + 0.5);

	if (v == 2) return "\vbox{\hbox{previous measurement}\hbox{($\be^* = 90\un{m}$)}}";
	if (v == 0) return "\vbox{\hbox{this analysis}\hbox{($\be^* = 1000\un{m}$)}}";

	return "";
}

//----------------------------------------------------------------------------------------------------

NewPad("$\si_{\rm tot}\ung{mb}$");
currentpad.xTicks = LeftTicks(Step=2, step=1);
currentpad.yTicks = RightTicks(rotate(0)*Label(""), MeasDesc, Step=1, step=0);

y = 2;
// TODO
DrawPointUnc(101.7, 2.9, heavygreen);

y = 0 + 2.5ys;

DrawPointUnc(103.228, 2.455);
DrawPointUnc(103.189, 2.471);
DrawPointUnc(103.072, 2.471);

DrawRange(102.4, 103.5);
DrawPointUnc(103.148, 2.479);
DrawRange(102.7, 103.3);
DrawPointUnc(103.275, 2.478);
DrawRange(102.7, 103.3);
DrawPointUnc(103.083, 2.472);

limits((98, -1), (106, 3), Crop);
for (real x = 98; x < 106; x += 1)
	yaxis(XEquals(x, false), dotted);

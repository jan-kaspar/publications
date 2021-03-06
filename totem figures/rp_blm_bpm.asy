real x(real z)
{
	real sign = (z > 0) ? +1 : -1;
	real z0 = sign * 200;
	real x0 = sign * 20;
	real sc = 3;

	return sc*(z-z0) + x0;
}

//----------------------------------------------------------------------------------------------------

void DrawRP(string name, real z, real dz=0)
{
	real y0 = 0;
	real y1 = 5;
	real y2 = 10;
	real y3 = 15;

	name += format(", $z = %#.3f\un{m}$", z);

	real x = x(z), xl = x(z+dz);
	draw(rotate(90)*Label(name, 0), (xl, y3){0, -1}..{0, -1}(xl, y2)..(x, y1){0, -1}..{0, -1}(x, y0), blue, EndArrow);
}

//----------------------------------------------------------------------------------------------------

void DrawBPM(string name, real z, real dz=0)
{
	real y0 = -5;
	real y1 = -10;
	real y2 = -15;
	real y3 = -20;

	real x = x(z), xl = x(z+dz);
	draw(rotate(90)*Label(name, 0), (xl, y3){0, 1}..(xl, y2)..(x, y1)..{0, 1}(x, y0), heavygreen, EndArrow);
}

//----------------------------------------------------------------------------------------------------

void DrawBLM(string name, string name_alt="", real z, real dz=0)
{
	real y0 = 0;
	real y1 = 5;
	real y2 = 10;
	real y3 = 45;

	if (name_alt != "")
	{
		//name = "\vtop{\hbox{"+name+"}\vskip-1mm\hbox{\SmallerFonts\it("+replace(name_alt, "_", "\_")+")}}";
		name = replace(name_alt, "_", "\_");
	}

	real x = x(z), xl = x(z+dz);
	draw(rotate(90)*Label(name, 0), (xl, y3){0, -1}..{0, -1}(xl, y2)..(x, y1){0, -1}..{0, -1}(x, y0), red, EndArrow);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

picture p_main;
currentpicture = p_main;
unitsize(1mm);

//----------------------------------------------------------------------------------------------------
// axis

real z_min = 200, z_max = 228, z_Step = 5, z_step = 1;

//draw((x(-z_max), 0)--(x(-z_min), 0), black);
draw((0, 0)--(x(+z_min), 0), black+dotted);
draw((x(+z_min), 0)--(x(+z_max), 0), black, EndArrow);

for (real z = z_min; z < z_max; z += z_Step)
{
	real l = 1.;
	draw(Label(format("%.0f", z), 0.5, 1.5S), (x(z), -l)--(x(z), +l), black+1pt);
	//draw(Label(format("%.0f", -z), 0.5, 1.5S), (x(-z), -l)--(x(-z), +l), black+1pt);
}

for (real z = z_min; z < z_max; z += z_step)
{
	real l = 0.5;
	draw((x(z), -l)--(x(z), +l));
}

dotfactor = 10;
dot((0, 0));
label("IP5", (0, 0), N);

//----------------------------------------------------------------------------------------------------
// sector 56

DrawBPM("BPMWT.C6R5.B1", 203.152);
DrawRP("XRPV.C6R5.B1 (56-210-nr-tp/bt)", 203.377, -1);
DrawRP("XRPH.C6R5.B1 (56-210-nr-hr)", 203.826);
DrawBLM("BLMEI.A6R5", "BLMEI.06R5.B1E10_XRP.C6R5.B1", 204.993);

DrawRP("XRPH.D6R5.B1 (56-210-fr-hr)", 212.551, -2.0);
DrawRP("XRPV.D6R5.B1 (56-210-fr-tp/bt)", 213.000, -1.0);
DrawBPM("BPMWT.D6R5.B1", 213.225);
DrawBLM("BLMEI.B6R5", "BLMEI.06R5.B1E10_XRP.D6R5.B1", 214.314, -1.0);

DrawBPM("BPMWT.A6R5.B1", 214.403);
DrawRP("XRPV.A6R5.B1 (56-220-nr-tp/bt)", 214.628, -0.1);
DrawRP("XRPH.A6R5.B1 (56-220-nr-hr)", 215.077, +0.7);

DrawRP("XRPH.E6R5.B1 (56-220-cyl)", 215.710, +1.8);
DrawBLM("BLMEI.C6R5", "BLMEI.06R5.B1E10_XRP.E6R5.B1", 216.675, +2);

DrawRP("XRPH.B6R5.B1 (56-220-fr-hr)", 219.551, +0.4);
DrawRP("XRPV.B6R5.B1 (56-220-fr-tp/bt)", 220.000, +1.5);
DrawBPM("BPMWT.B6R5.B1", 220.225);
DrawBLM("BLMEI.D6R5", "BLMEI.06R5.B1E10_XRP.B6R5.B1", 221.314, +1.4);

DrawBLM("BLMTI.A6R5 and BLMTS.A6R5", "BLMTI.06R5.B1E10_TCL.6R5.B1 and BLMTS", 223.314, +1);

DrawBLM("BLMQI.C6R5", "BLMQI.06R5.B1E10_MQML_XRP", 226.702);

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
attach(rotate(-90) * p_main.fit());

shipout(bbox(nullpen, xmargin=5mm));


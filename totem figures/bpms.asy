unitsize(0.5mm);

real max_s = 280;
real s_d1 = 72.287;
real s_d2 = 158.200;
real sep = 20;

draw((-max_s, -sep)--(-s_d2, -sep)--(-s_d1, 0)--(s_d1, 0)--(s_d2, +sep)--(max_s, +sep), blue, EndArrow);
draw((-max_s, +sep)--(-s_d2, +sep)--(-s_d1, 0)--(s_d1, 0)--(s_d2, -sep)--(max_s, -sep), heavygreen, BeginArrow);


label("beam 1", (max_s, sep), E*1.5, blue);
label("beam 2", (-max_s, sep), W*1.5, heavygreen);
label("IP5", (0, 0), N);


void DrawBPM(real s, int beam, string name, real correction = 0, int dip = 0, bool printZ = false)
{
	real y = 0;
	real am = 0;
	if (abs(s) < s_d1) am = 0;
	else
		if (abs(s) > s_d2) am = sep;
		else {
			am = (abs(s) - s_d1) / (s_d2 - s_d1) * sep;
		}

	if (beam == 1) y = +am;
	if (beam == 2) y = -am;
	if (s < 0) y = -y;

	filldraw(shift(s, y)*scale(1)*unitcircle);

	pen p = black;
	if (dip > 0) p = red;

	name = "BPM" + name;

	if (printZ)
		name += ", $z=" + format("%.3f", s) + "\,{\rm m}$";

	if (y >= 0) label(rotate(90)*Label(name), (s + correction, y), N, p);
	else label(rotate(90)*Label(name), (s + correction, y), S, p);
}

// left part
DrawBPM(-268.4290, 1, "R.7L5.B1");
DrawBPM(-268.4290, 2, ".7L5.B2");
DrawBPM(-231.5350, 1, "R.6L5.B1");
DrawBPM(-231.5350, 2, ".6L5.B2");

DrawBPM(-220.225, 2, "WT.B6L5.B2", 0, 1, true);
DrawBPM(-214.403, 2, "WT.A6L5.B2", +3, 1, true);

DrawBPM(-199.64, 1, "R.5L5.B1");
DrawBPM(-199.64, 2, ".5L5.B2");
DrawBPM(-172.2290, 1, "YA.4L5.B1");
DrawBPM(-172.2290, 2, "YA.4L5.B2");
DrawBPM(-151.1325, 1, "WB.4L5.B1");
DrawBPM(-151.1325, 2, "WB.4L5.B2", -4);

DrawBPM(-150.7010, 2, "WT.B4L5.B2", +3, 1, true);
DrawBPM(-148.7190, 2, "WT.A4L5.B2", +10, 1, true);

// central part
DrawBPM(-58.4570, 1, "SY.4L5");
DrawBPM(-31.5290, 1, "S.2L5");
DrawBPM(-21.6150, 1, "SW.1L5", 0, 0);

DrawBPM(58.4570, 1, "SY.4R5");
DrawBPM(31.5290, 1, "S.2R5");
DrawBPM(21.6150, 1, "SW.1R5", 0, 0);

// right part 
DrawBPM(148.7190, 1, "WT.A4R5.B1", -10, 1, true);
DrawBPM(150.7010, 1, "WT.B4R5.B1", -3, 1, true);

DrawBPM(151.1325, 1, "WB.4R5.B1", +4, 0);
DrawBPM(151.1325, 2, "WB.4R5.B2");
DrawBPM(172.2290, 1, "YA.4R5.B1");
DrawBPM(172.2290, 2, "YA.4R5.B2");

DrawBPM(199.64, 1, "R.5R5.B1");
DrawBPM(199.64, 2, ".5R5.B2");

DrawBPM(214.403, 1, "WT.A6R5.B1", -3, 1, true);
DrawBPM(220.225, 1, "WT.B6R5.B1", 0, 1, true);

DrawBPM(231.5350, 1, "R.6R5.B1");
DrawBPM(231.5350, 2, ".6R5.B2");
DrawBPM(268.4290, 1, "R.7R5.B1");
DrawBPM(268.4290, 2, ".7R5.B2");



real y_a = 0;
draw((-max_s, y_a)--(max_s, y_a), EndArrow);
label("$z\,({\rm m})$", (max_s, y_a), E);
for (real s = -250; s <= 250; s += 50) {
	real t = 2;
	draw((s, y_a-t)--(s, y_a+t));
	label(string(s), (s, y_a), S*2, UnFill);
}


texpreamble("\font\fTit=pplb8z at 20pt");
label("\fTit The BPMs around IP5", (0, 5sep), N);
label("BPMs in red mounted on TOTEM RP stations", (0, 5sep), S);

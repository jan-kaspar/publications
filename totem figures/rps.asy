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


void DrawRP(real s, int beam, string name, real correction = 0, bool printZ = true)
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

	name = "\hbox to35mm{" + replace(name, "_", "\_") + "}";

	if (printZ)
		name += "$z=" + format("%#+.3f", s) + "\,{\rm m}$";

	if (y >= 0) label(rotate(90)*Label(name), (s + correction, y), N, p);
	else label(rotate(90)*Label(name), (s + correction, y), S, p);
}

DrawRP(-148.944, 2, "XRPV.A4L5.B2", +12);
DrawRP(-149.393, 2, "XRPH.A4L5.B2", +4);
DrawRP(-150.027, 2, "XRPH.B4L5.B2", -4);
DrawRP(-150.476, 2, "XRPV.B4L5.B2", -12);

DrawRP(-214.628, 2, "XRPV.A6L5.B2", +10);
DrawRP(-215.077, 2, "XRPH.A6L5.B2", +2);
DrawRP(-219.551, 2, "XRPH.B6L5.B2", -2);
DrawRP(-220.000, 2, "XRPV.B6L5.B2", -10);

DrawRP(148.944, 1, "XRPV.A4R5.B1", -12);
DrawRP(149.393, 1, "XRPH.A4R5.B1", -4);
DrawRP(150.027, 1, "XRPH.B4R5.B1", +4);
DrawRP(150.476, 1, "XRPV.B4R5.B1", 12);

DrawRP(214.628, 1, "XRPV.A6R5.B1", -10);
DrawRP(215.077, 1, "XRPH.A6R5.B1", -2);
DrawRP(219.551, 1, "XRPH.B6R5.B1", +2);
DrawRP(220.000, 1, "XRPV.B6R5.B1", 10);

real y_a = 0;
draw((-max_s, y_a)--(max_s, y_a), EndArrow);
label("$z\,({\rm m})$", (max_s, y_a), E);
for (real s = -250; s <= 250; s += 50) {
	real t = 2;
	draw((s, y_a-t)--(s, y_a+t));
	label(string(s), (s, y_a), S*2, UnFill);
}


texpreamble("\font\fTit=pplb8z at 20pt");
label("\fTit TOTEM Roman Pots", (0, 5sep), N);

shipout(bbox(5mm, nullpen));

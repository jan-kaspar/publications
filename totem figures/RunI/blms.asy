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


void DrawBLM(real s, int beam, string name, real correction = 0, int forTotem = 0, bool printZ = false)
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
	if (forTotem > 0) p = red;

	name = "\hbox to68mm{" + replace(name, "_", "\_") + "}";

	if (printZ)
		name += "$z=" + format("%#+.3f", s) + "\,{\rm m}$";

	if (y >= 0) label(rotate(90)*Label(name), (s + correction, y), N, p);
	else label(rotate(90)*Label(name), (s + correction, y), S, p);
}

DrawBLM(-228.89  , 2, "BLMQI.06L5.B2E22_MQML", -13, 1, true);
DrawBLM(-226.7416, 2, "BLMQI.06L5.B2E21_MQML_XRP", -6, 1, true);
DrawBLM(-225.2220, 2, "BLMQI.06L5.B2E10_MQML", 1, 1, true);
DrawBLM(-221.0416, 2, "BLMEI.06L5.B2E10_XRP", 5, 1, true);
DrawBLM(-164.60  , 2, "BLMQI.04L5.B2E10_MQY_XRP", 0, 1, true);
DrawBLM(-153.5016, 2, "BLMEI.04L5.B2E10_XRP", 0, 1, true);

DrawBLM(153.3584, 1, "BLMEI.04R5.B1E10_XRP", 0, 1, true);
DrawBLM(162.10,   1, "BLMEI.04R5.B1E20_XRP", 0, 1, true);
DrawBLM(220.7584, 1, "BLMEI.06R5.B1E10_XRP", -5, 1, true);
DrawBLM(226.7020, 1, "BLMQI.06R5.B1E10_MQML_XRP", -1, 1, true);
DrawBLM(227.89,   1, "BLMQI.06R5.B2I20_MQML", 6, 1, true);
DrawBLM(229.09,   1, "BLMQI.06R5.B1E20_MQML", 13, 1, true);


real y_a = 0;
draw((-max_s, y_a)--(max_s, y_a), EndArrow);
label("$z\,({\rm m})$", (max_s, y_a), E);
for (real s = -250; s <= 250; s += 50) {
	real t = 2;
	draw((s, y_a-t)--(s, y_a+t));
	label(string(s), (s, y_a), S*2, UnFill);
}


texpreamble("\font\fTit=pplb8z at 20pt");
label("\fTit Some BLMs around IP5", (0, 5sep), N);
label("BLMs in red close to TOTEM RP stations", (0, 5sep), S);

shipout(bbox(5mm, nullpen));

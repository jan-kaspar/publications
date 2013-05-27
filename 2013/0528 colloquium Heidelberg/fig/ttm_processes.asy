import feynman;
import graph;

StdFonts();

pair ti = (-20, 50);
pair bi = (-20, 10);
pair tm = (0, 40);
pair m = (0, 30);
pair bm = (0, 20);
pair to = (+20, 50);
pair mo = (+20, 30);
pair bo = (+20, 10);

picture mp = new picture;

currentarrow = MidArrow(5);

//----------------------------------------------------------------------------------------------------

picture dp;
picture gp;
string label;

//----------------------------------------------------------------------------------------------------

void New(string l)
{
	label = l;
	dp = new picture;
	gp = new picture;

	unitsize(dp, 0.4mm);
	unitsize(gp, 2mm);
}

//----------------------------------------------------------------------------------------------------

void Finish(real col, real row)
{
	currentpicture = gp;
	limits((-12, -3.14), (12, 3.14));
	xaxis(Label("$\et$", 1), BottomTop, LeftTicks);
	yaxis(Label("$\ph$", 1), LeftRight, RightTicks);

	currentpicture = mp;
	pair c = (col*8.5cm, -row*3.5cm);
	frame df = dp.fit();
	frame gf = gp.fit();
	add(df, c, 5W+2N);
	add(gf, c, E);

	real xm = (min(df).x - max(df).x + max(gf).x - min(gf).x)/2;
	real h = max(max(df).y, max(gf).y);

	label(label, c+(xm, 1.7cm));
}

//----------------------------------------------------------------------------------------------------

New("{\bf Elastic Scattering} (ES),\quad $\approx 25\,\rm mb$");

currentpicture = dp;
drawFermion(ti--tm);
drawFermion(tm--to, red);
drawFermion(bi--bm);
drawFermion(bm--bo, blue, false);

drawDoubleLine(bm--tm);

drawVertex(tm);
drawVertex(bm);

currentpicture = gp;
dot((-11, 2), red);
dot((11, -2), blue);

draw(Label("\SmallerFonts rapidity gap", 0.5, N), (-10, 0)--(+10, 0), Arrows(5));

Finish(0, 0);

//--------------------

New("{\bf Single Diffraction} (SD),\quad $\approx 10\,\rm mb$");

currentpicture = dp;
drawFermion(ti--tm);
drawFermion(tm--to, red);
drawFermion(bi--bm);
drawFermion(bm--(bo+(0, +5)), blue, false);
drawFermion(bm--bo, blue, false);
drawFermion(bm--(bo+(0, -5)), blue, false);

drawDoubleLine(bm--tm);

drawVertex(tm);
drawVertex(bm);

currentpicture = gp;
dot((-11, 2), red);

for (int i = 0; i < 10; ++i) {
	dot((4+unitrand()*8, -3.14+unitrand()*2*3.14), blue);
}

draw(Label("\SmallerFonts rapidity gap", 0.5, N), (-10, 0)--(+5, 0), Arrows(5));

Finish(0, 1);

//--------------------

New("{\bf Double Diffraction} (DD),\quad $\approx 5\,\rm mb$");

currentpicture = dp;
drawFermion(ti--tm);
drawFermion(tm--(to+(0, +5)), red, false);
drawFermion(tm--to, red, false);
drawFermion(tm--(to+(0, -5)), red, false);
drawFermion(bi--bm);
drawFermion(bm--(bo+(0, +5)), blue, false);
drawFermion(bm--bo, blue, false);
drawFermion(bm--(bo+(0, -5)), blue, false);

drawDoubleLine(bm--tm);

drawVertex(tm);
drawVertex(bm);

currentpicture = gp;
for (int i = 0; i < 10; ++i)
	dot((-6-unitrand()*6, -3.14+unitrand()*2*3.14), red);

for (int i = 0; i < 10; ++i)
	dot((4+unitrand()*8, -3.14+unitrand()*2*3.14), blue);

draw(Label("\SmallerFonts rapidity gap", 0.5, N), (-6, 0)--(+3, 0), Arrows(5));


Finish(0, 2);

//--------------------

New("{\bf Central Diffraction} (CD),\quad $\approx 1\,\rm mb$");

currentpicture = dp;
drawFermion(ti--tm);
drawFermion(tm--to, red);
drawFermion(bi--bm);
drawFermion(bm--bo, blue);
drawFermion(m--(mo+(0, +5)), heavygreen, false);
drawFermion(m--mo, heavygreen, false);
drawFermion(m--(mo+(0, -5)), heavygreen, false);

drawDoubleLine(bm--m, erasebg=false);
drawDoubleLine(m--tm, erasebg=false);

drawVertex(tm);
drawVertex(m);
drawVertex(bm);

currentpicture = gp;
dot((-11, 2), red);
dot((11, -2), blue);

for (int i = 0; i < 10; ++i)
	dot((-3+unitrand()*6, -3.14+unitrand()*2*3.14), heavygreen);

draw(Label("\SmallerFonts rap.~gap", 0.5, N), (-10, 0)--(-3, 0), Arrows(5));
draw(Label("\SmallerFonts rap.~gap", 0.5, N), (+3, 0)--(+10, 0), Arrows(5));

Finish(0, 3);

shipout("ttm_diffractive_processes", bbox(2mm, nullpen));

//--------------------

mp = new picture;

New("{\bf Non-Diffractive process} (ND)");

currentpicture = dp;
drawFermion(ti--tm);
drawFermion(tm--to, black);
drawFermion(bi--bm);
drawFermion(bm--bo, black);

drawFermion((m+(0, +6))--(mo+(0, +15)), black, false);
drawFermion((m+(0, +4))--(mo+(0, +10)), black, false);
drawFermion((m+(0, +2))--(mo+(0, +5)), black, false);
drawFermion(m--mo, black, false);
drawFermion((m+(0, -2))--(mo+(0, -5)), black, false);
drawFermion((m+(0, -4))--(mo+(0, -10)), black, false);
drawFermion((m+(0, -6))--(mo+(0, -15)), black, false);

drawGluon(bm--tm, erasebg=false);

drawVertex(tm);
drawVertex(bm);

currentpicture = gp;
for (int i = 0; i < 30; ++i)
	dot((-6+unitrand()*12, -3.14+unitrand()*2*3.14), black);

Finish(0, 0);

shipout("ttm_non_diffractive_process", bbox(2mm, nullpen));

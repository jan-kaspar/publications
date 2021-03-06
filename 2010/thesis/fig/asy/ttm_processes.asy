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

New("Elastic Scattering (ES),\quad $\approx 30\,\rm mb$");

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

Finish(0, 0);

//--------------------

New("Single Diffraction (SD),\quad $\approx 10\,\rm mb$");

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

Finish(1, 0);

//--------------------

New("Double Pomeron Exchange (DPE),\quad $\approx 1\,\rm mb$");

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

Finish(0, 1);

//--------------------

New("Double Diffraction (DD),\quad $\approx 7\,\rm mb$");

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


Finish(1, 1);

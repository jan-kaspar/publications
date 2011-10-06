StdFonts();

int N_d = 6;
real rad = 0.1;
real alen = 1;

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

pair nom_u = (2, 1), nom_v = (1, 1), b = (-0.6, 0.2), a = (0.2, 0.5);

draw(shift(nom_v)*scale(rad)*unitcircle, blue);
draw(shift(nom_u)*scale(rad)*unitcircle, red);

draw((nom_v + b -0.5*a)--(nom_v + b + (N_d-0.5)*a), blue+dashed);
draw((nom_u + b -0.5*a)--(nom_u + b + (N_d-0.5)*a), red+dashed);

for (int i = 0; i < N_d; ++i) {
	if (i % 2 == 0) {
		pair p = nom_v + b + i*a;
		filldraw(shift(p)*scale(rad)*unitcircle, blue, nullpen);
		draw(p--(p + rotate(135)*(alen, 0)), blue, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), p, (i == 0) ? W : E, blue);
	} else {
		pair p = nom_u + b + i*a;
		filldraw(shift(p)*scale(rad)*unitcircle, red, nullpen);
		draw(p--(p + rotate(45)*(alen, 0)), red, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), p, W, red);
	}
}

draw(Label("$\De\vec b$", 0.5, 2*S, UnFill),(nom_v)--(nom_v + b), black, EndArrow);
draw(rotate(-20)*Label("$\De\vec a\,2\De z$", 0.5, NW), (nom_v + b + 0*a)--(nom_v + b + 2*a), black, EndArrow);

real x0 = -2, y0 = 0.5, xm = 5, ym = 4;
draw(Label("$x$", 1, E), (x0, y0)--(xm, y0), EndArrow);
draw(Label("$y$", 1, N), (x0, y0)--(x0, ym), EndArrow);

shipout("al_sing_modes_shr");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

real z_s = 0, x_v = 1.7, x_u = 2.2, dz = 1, al_v = 0.1, be_v = 0.5, al_u = 0.03, be_u = 0.2;

for (int i = 0; i < N_d; ++i) {
	if (i % 2 == 0) {
		real z0 = z_s + dz * i, dz = al_v*(dz*i) + be_v, z = z0 + dz;
		draw(shift(z0, x_v)*scale(rad)*unitcircle, blue);
		filldraw(shift(z, x_v)*scale(rad)*unitcircle, blue, nullpen);
		draw((z0, x_v)--(z0, x_v-alen), blue, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), (z0, x_v), W, blue);
	} else {
		real z0 = z_s + dz * i, dz = al_u*(dz*i) + be_u, z = z0 + dz;
		draw(shift(z0, x_u)*scale(rad)*unitcircle, red);
		filldraw(shift(z, x_u)*scale(rad)*unitcircle, red, nullpen);
		draw((z0, x_u)--(z0, x_u+alen), red, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), (z0, x_u), W, red);
	}
}

draw(Label("\SmallerFonts $\be_V$", 0, 2SE), (z_s, x_v)--(z_s + be_v, x_v), black, EndArrow);
draw(Label("\SmallerFonts $\al_V\,2\De z + \be_V$", 0, 2SE), (z_s + dz*2, x_v)--(z_s + dz*2*(1+al_v) + be_v, x_v), black, EndArrow);

real x0 = -0.5, y0 = 0.5, xm = 5.5, ym = 3;
draw(Label("$z$", 1, E), (x0, y0)--(xm, y0), EndArrow);
draw(Label("$x$", 1, N), (x0, y0)--(x0, ym), EndArrow);
label("two read-out groups", ((x0+xm)/2, ym), 3N);

//--------------------

real z_s = 8, x_v = 1.7, x_u = 2.2, dz = 1, al_v = 0.05, be_v = 0.5, al_u = al_v, be_u = be_v;

for (int i = 0; i < N_d; ++i) {
	if (i % 2 == 0) {
		real z0 = z_s + dz * i, dz = al_v*(dz*i) + be_v, z = z0 + dz;
		draw(shift(z0, x_v)*scale(rad)*unitcircle, blue);
		filldraw(shift(z, x_v)*scale(rad)*unitcircle, blue, nullpen);
		draw((z0, x_v)--(z0, x_v-alen), blue, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), (z0, x_v), W, blue);
	} else {
		pen col = (i == 3) ? heavygreen : red;
		real z0 = z_s + dz * i, dz = al_u*(dz*i) + be_u, z = z0 + dz;
		draw(shift(z0, x_u)*scale(rad)*unitcircle, col);
		filldraw(shift(z, x_u)*scale(rad)*unitcircle, col, nullpen);
		draw((z0, x_u)--(z0, x_u+ ((i==3) ? 0.6 : alen)), col, EndArrow);
		label("\SmallerFonts "+format("%u", i+1), (z0, x_u), W, col);
	}
}

draw(Label("\SmallerFonts $\be$", 0, 2SE), (z_s, x_v)--(z_s + be_v, x_v), black, EndArrow);
draw(Label("\SmallerFonts $\al\,2\De z + \be$", 0, 2SE), (z_s + dz*2, x_v)--(z_s + dz*2*(1+al_v) + be_v, x_v), black, EndArrow);

real x0 = -0.5, y0 = 0.5, xm = 6, ym = 3;
draw(Label("$z$", 1, E), (z_s+x0, y0)--(z_s+xm, y0), EndArrow);
draw(Label("$x$", 1, N), (z_s+x0, y0)--(z_s+x0, ym), EndArrow);
label("three read-out groups", (z_s+(x0+xm)/2, ym), 3N);

shipout("al_sing_modes_shz");


//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

real x_s = 0, r = 2, rh_v = 125, rh_u = 55, dr_v = 15, dr_u = 30;
real fa = 0.7, len = 2;

draw(arc((x_s, 0), r, 0, 180), black+dotted);

pair pn, pa;
pn = rotate(rh_u)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, red);
pa = rotate(rh_u+dr_u)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, red, nullpen);
draw((0, 0)--pn, dotted);
draw((0, 0)--pa, dotted);
draw(Label("\SmallerFonts $\De\rh_U$"), arc((0, 0), r*fa, rh_u, rh_u+dr_u), black);
draw(pn--(pn + rotate(45)*(len, 0)), red+dashed, EndArrow);
draw(pa--(pa + rotate(45)*(len, 0)), red+dashed);
draw(pa--(pa + rotate(45+dr_u)*(len, 0)), red, EndArrow);
draw(Label("\SmallerFonts $\De\rh_U$"), arc(pa, len*fa, 45, 45+dr_u), black);
label("\SmallerFonts 2,4,6", pn, 2E, red);
draw(Label("$\De\vec c$"), pn--pa, black, EndArrow);

pn = rotate(rh_v)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, blue);
pa = rotate(rh_v+dr_v)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, blue, nullpen);
draw((0, 0)--pn, dotted);
draw((0, 0)--pa, dotted);
draw(Label(""), arc((0, 0), r*fa, rh_v, rh_v+dr_v), black);
draw(pn--(pn + rotate(135)*(len, 0)), blue+dashed, EndArrow);
draw(pa--(pa + rotate(135)*(len, 0)), blue+dashed);
draw(pa--(pa + rotate(135+dr_v)*(len, 0)), blue, EndArrow);
draw(Label("\SmallerFonts $\De\rh_V$"), arc(pa, len*0.9, 135, 135+dr_v), black);
label("\SmallerFonts 1,3,5", pa, 2W, blue);


real x0 = -3, y0 = 0, xm = +3, ym = 4;
draw(Label("$x$", 1, E), (x_s+x0, y0)--(x_s+xm, y0), EndArrow);
draw(Label("$y$", 1, N), (x_s+(x0+xm)/2, y0)--(x_s+(x0+xm)/2, ym), EndArrow);
label("two read-out groups", (x_s+(x0+xm)/2, ym), 5N);

//--------------------

real x_s = 8, r = 2, rh_v = 125, rh_u = 55, rh_t = 15, dr_v = 15, dr_u = 15, dr_t = 15;
real fa = 0.7, len = 2;

draw(arc((x_s, 0), r, 0, 180), black+dotted);

pair pn, pa;
pn = (x_s, 0)+rotate(rh_u)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, red);
pa = (x_s, 0)+rotate(rh_u+dr_u)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, red, nullpen);
draw((x_s, 0)--pn, dotted);
draw((x_s, 0)--pa, dotted);
draw(Label(""), arc((x_s, 0), r*fa, rh_u, rh_u+dr_u), black);
draw(pn--(pn + rotate(45)*(len, 0)), red+dashed, EndArrow);
draw(pa--(pa + rotate(45)*(len, 0)), red+dashed);
draw(pa--(pa + rotate(45+dr_u)*(len, 0)), red, EndArrow);
draw(Label("\SmallerFonts $\De\rh$"), arc(pa, len*fa, 45, 45+dr_u), black);
label("\SmallerFonts 2,6", pn, 2E, red);

pn = (x_s, 0)+rotate(rh_t)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, heavygreen);
pa = (x_s, 0)+rotate(rh_t+dr_u)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, heavygreen, nullpen);
draw((x_s, 0)--pn, dotted);
draw((x_s, 0)--pa, dotted);
draw(Label(""), arc((x_s, 0), r*fa, rh_t, rh_t+dr_t), black);
draw(pn--(pn + rotate(0)*(len, 0)), heavygreen+dashed, EndArrow);
draw(pa--(pa + rotate(0)*(len, 0)), heavygreen+dashed);
draw(pa--(pa + rotate(0+dr_t)*(len, 0)), heavygreen, EndArrow);
draw(Label("\SmallerFonts $\De\rh$"), arc(pa, len*fa, 0, 0+dr_t), black);
label("\SmallerFonts 4", pn, 2NE, heavygreen);

pn = (x_s, 0)+rotate(rh_v)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, blue);
pa = (x_s, 0)+rotate(rh_v+dr_v)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, blue, nullpen);
draw((x_s, 0)--pn, dotted);
draw((x_s, 0)--pa, dotted);
draw(Label(""), arc((x_s, 0), r*fa, rh_v, rh_v+dr_v), black);
draw(pn--(pn + rotate(135)*(len, 0)), blue+dashed, EndArrow);
draw(pa--(pa + rotate(135)*(len, 0)), blue+dashed);
draw(pa--(pa + rotate(135+dr_v)*(len, 0)), blue, EndArrow);
draw(Label("\SmallerFonts $\De\rh$"), arc(pa, len*0.9, 135, 135+dr_v), black);
label("\SmallerFonts 1,3,5", pa, 2W, blue);


real x0 = -3.5, y0 = 0, xm = +3.5, ym = 4;
draw(Label("$x$", 1, E), (x_s+x0, y0)--(x_s+xm, y0), EndArrow);
draw(Label("$y$", 1, N), (x_s+(x0+xm)/2, y0)--(x_s+(x0+xm)/2, ym), EndArrow);

label("three read-out groups", (z_s+(x0+xm)/2, ym), 5N);

shipout("al_sing_modes_rotz");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

real x_s = 0, r = 2.5, rh_v = 100, rh_u = 80, al_u = -25, be_u = +15, al_v = 10, be_v = 20;
real fa = 0.95, len = 1.5;

draw(arc((x_s, 0), r, 0, 180), black+dotted);

pair pn, pa;
pn = rotate(rh_u)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, red);
draw(pn--(pn + rotate(45)*(len, 0)), red+dashed, EndArrow);
draw((0, 0)--pn, dotted);

pn = rotate(rh_v)*(r, 0); draw(shift(pn)*scale(rad)*unitcircle, blue);
draw(pn--(pn + rotate(135)*(len, 0)), blue+dashed, EndArrow);
draw((0, 0)--pn, dotted);

string lab[] = { "\al_U\,\De z + \be_U", "\al_U\,3\De z + \be_U", "\al_U\,5\De z + \be_U" };

for (int i = 0; i < 3; ++i) {
	real dr_u = al_u*(i + 1) + be_u;
	pa = rotate(rh_u+dr_u)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, red, nullpen);

	draw((0, 0)--pn, dotted);
	draw((0, 0)--pa, dotted);
	draw(pa--(pa + rotate(45)*(len, 0)), red+dashed);
	draw(pa--(pa + rotate(45+dr_u)*(len, 0)), red, EndArrow);
	draw(Label("\SmallerFonts $"+lab[i]+"$", 0.5, rotate(45+dr_u/2)*(1, 0)), arc(pa, len*fa, 45, 45+dr_u), black);
	label("\SmallerFonts "+format("%u", 2*i+2), pa, rotate(-45+dr_u/2)*(1.5, 0), red, UnFill);
	

	real dr_v = al_v*i + be_v;
	pa = rotate(rh_v+dr_v)*(r, 0); filldraw(shift(pa)*scale(rad)*unitcircle, blue, nullpen);

	draw((0, 0)--pa, dotted);
	//draw(pa--(pa + rotate(135)*(len, 0)), blue+dashed);
	draw(pa--(pa + rotate(135+dr_v)*(len, 0)), blue, EndArrow);
	if (i == 0)
		draw(Label("\SmallerFonts $\be_V$", 0.5, rotate(rh_v+dr_v/2)*(1, 0)), arc((0, 0), r*0.7, rh_v, rh_v+dr_v), black);
	label("\SmallerFonts "+format("%u", 2*i+1), pa, 1.5*S, blue, UnFill);
}


real x0 = -3, y0 = 0, xm = +3, ym = 4;
draw(Label("$x$", 1, E), (x_s+x0, y0)--(x_s+xm, y0), EndArrow);
draw(Label("$y$", 1, N), (x_s+(x0+xm)/2, y0)--(x_s+(x0+xm)/2, ym), EndArrow);

shipout("al_sing_modes_rotz_al");

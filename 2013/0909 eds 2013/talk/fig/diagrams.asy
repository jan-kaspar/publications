

real xl = -10, xm = 0, xr = +10, xi = 4;
real ye = 10, ym = 3, yi = 7;

pair IntPoint(pair st, pair de)
{
	pair d = de - st;

	real A = d.x^2 / xi^2 + d.y^2 / yi^2;
	real B = 2*d.x*st.x / xi^2 + 2*d.y*st.y / yi^2;
	real C = st.x^2 / xi^2 + st.y^2 / yi^2 - 1.;

	real D = B*B - 4*A*C;
	real t1 = (-B + sqrt(D)) / (2*A);
	real t2 = (-B - sqrt(D)) / (2*A);
	
	real t = (abs(t1) < abs(t2)) ? t1 : t2;

	return st + t*d;
}

pair s;
pen col = black;

void NewDiagram()
{
	currentpicture = new picture;
	unitsize(1mm);

	s = (xl, ye); draw(s--IntPoint(s, (xm, ym)), col, MidArrow);
	s = (xl, -ye); draw(s--IntPoint(s, (xm, -ym)), col, MidArrow);
	draw(scale(xi, yi)*unitcircle, col);
}

//----------------------------------------------------------------------------------------------------

NewDiagram();
s = (xr, ye); draw(reverse(s--IntPoint(s, (xm, ym))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);
shipout("diagram_es");

NewDiagram();
s = (xr, ye); draw(reverse(s--IntPoint(s, (xm, ym))), col, MidArrow);
s = (xr, ye*0.67); draw(reverse(s--IntPoint(s, (xm, ym*0.67))), col, MidArrow);
s = (xr, ye*0.33); draw(reverse(s--IntPoint(s, (xm, ym*0.33))), col, MidArrow);
s = (xr, ye*0.00); draw(reverse(s--IntPoint(s, (xm, ym*0.00))), col, MidArrow);
s = (xr, -ye*0.33); draw(reverse(s--IntPoint(s, (xm, -ym*0.33))), col, MidArrow);
s = (xr, -ye*0.67); draw(reverse(s--IntPoint(s, (xm, -ym*0.67))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);
label(rotate(90)*Label("anything"), (xr, 0), E, col);
shipout("diagram_tot");

NewDiagram();
s = (xr, ye); draw(reverse(s--IntPoint(s, (xm, ym))), col, MidArrow);
s = (xr, ye*0.10); draw(reverse(s--IntPoint(s, (xm, ym*0.10))), col, MidArrow);
s = (xr, ye*0.00); draw(reverse(s--IntPoint(s, (xm, ym*0.00))), col, MidArrow);
s = (xr, -ye*0.10); draw(reverse(s--IntPoint(s, (xm, -ym*0.10))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);
shipout("diagram_dpe");

NewDiagram();
s = (xr, ye*1.10); draw(reverse(s--IntPoint(s, (xm, ym*1.10))), col, MidArrow);
s = (xr, ye*1.00); draw(reverse(s--IntPoint(s, (xm, ym*1.00))), col, MidArrow);
s = (xr, ye*0.90); draw(reverse(s--IntPoint(s, (xm, ym*0.90))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);
shipout("diagram_sd");

NewDiagram();
s = (xr, ye*1.10); draw(reverse(s--IntPoint(s, (xm, ym*1.10))), col, MidArrow);
s = (xr, ye*1.00); draw(reverse(s--IntPoint(s, (xm, ym*1.00))), col, MidArrow);
s = (xr, ye*0.90); draw(reverse(s--IntPoint(s, (xm, ym*0.90))), col, MidArrow);
s = (xr, -ye*1.10); draw(reverse(s--IntPoint(s, (xm, -ym*1.10))), col, MidArrow);
s = (xr, -ye*1.00); draw(reverse(s--IntPoint(s, (xm, -ym*1.00))), col, MidArrow);
s = (xr, -ye*0.90); draw(reverse(s--IntPoint(s, (xm, -ym*0.90))), col, MidArrow);
shipout("diagram_dd");

NewDiagram();
s = (xr, ye); draw(reverse(s--IntPoint(s, (xm, ym))), col, MidArrow);
s = (xr, ye*0.10); draw(reverse(s--IntPoint(s, (xm, ym*0.10))), col, MidArrow);
s = (xr, ye*0.00); draw(reverse(s--IntPoint(s, (xm, ym*0.00))), col, MidArrow);
s = (xr, -ye*0.10); draw(reverse(s--IntPoint(s, (xm, -ym*0.10))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);

label("p", (xl, ye), W, col);
label("p", (xl, -ye), W, col);
label("p $\rightarrow$ RP", (xr, ye), E, col);
label("p $\rightarrow$ RP", (xr, -ye), E, col);
label("X $\rightarrow$ (CMS)", (xr, 0), E, col);

shipout("diagram_dpe_lab");

NewDiagram();
s = (xr, ye*1.10); draw(reverse(s--IntPoint(s, (xm, ym*1.10))), col, MidArrow);
s = (xr, ye*1.00); draw(reverse(s--IntPoint(s, (xm, ym*1.00))), col, MidArrow);
s = (xr, ye*0.90); draw(reverse(s--IntPoint(s, (xm, ym*0.90))), col, MidArrow);
s = (xr, -ye); draw(reverse(s--IntPoint(s, (xm, -ym))), col, MidArrow);

label("p", (xl, ye), W, col);
label("p", (xl, -ye), W, col);
label("X $\rightarrow$ T1/T2", (xr, ye), E, col);
label("p $\rightarrow$ RP", (xr, -ye), E, col);

shipout("diagram_sd_lab");

NewDiagram();
s = (xr, ye*1.10); draw(reverse(s--IntPoint(s, (xm, ym*1.10))), col, MidArrow);
s = (xr, ye*1.00); draw(reverse(s--IntPoint(s, (xm, ym*1.00))), col, MidArrow);
s = (xr, ye*0.90); draw(reverse(s--IntPoint(s, (xm, ym*0.90))), col, MidArrow);
s = (xr, -ye*1.10); draw(reverse(s--IntPoint(s, (xm, -ym*1.10))), col, MidArrow);
s = (xr, -ye*1.00); draw(reverse(s--IntPoint(s, (xm, -ym*1.00))), col, MidArrow);
s = (xr, -ye*0.90); draw(reverse(s--IntPoint(s, (xm, -ym*0.90))), col, MidArrow);

label("p", (xl, ye), W, col);
label("p", (xl, -ye), W, col);
label("X $\rightarrow$ T1/T2", (xr, ye), E, col);
label("X $\rightarrow$ T1/T2", (xr, -ye), E, col);

shipout("diagram_dd_lab");

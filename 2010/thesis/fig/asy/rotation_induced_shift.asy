unitsize(1cm);

StdFonts();

real aMin = -1, aMax = 3;
pair c = (2, 2);

real rho_i = 150, rho_r = 170;
real dLen = 1.5;
real pLen = 2;


draw((aMin, 0)--(aMax, 0), EndArrow);
draw((0, aMin)--(0, aMax), EndArrow);

//draw("$\vec c$", (0, 0)--c, EndArrow);

dotfactor = 10;
dot(c);

draw(c--(c+rotate(rho_i)*(dLen, 0)), blue, EndArrow);
draw(c--(c+rotate(rho_r)*(dLen, 0)), red, EndArrow);

draw((rotate(rho_i)*(-pLen, 0))--(rotate(rho_i)*(pLen, 0)), blue);
draw((rotate(rho_r)*(-pLen, 0))--(rotate(rho_r)*(pLen, 0)), red);

real DrawProjection(real rho, pen p)
{
	real l = c.x * Cos(rho) + c.y * Sin(rho);
	draw(l*(Cos(rho), Sin(rho))--c, p+dashed);
	return l;
}

real p_i = DrawProjection(rho_i, blue);
real p_r = DrawProjection(rho_r, red);

draw(arc((0, 0), p_r, rho_r, rho_i), dashed);

pair sh = 0.2*(-Sin(rho_i), Cos(rho_i));

draw(rotate(rho_i-180)*Label("$\De s$"), (p_i*(Cos(rho_i), Sin(rho_i))+sh)--(p_r*(Cos(rho_i), Sin(rho_i))+sh), Arrows(5));

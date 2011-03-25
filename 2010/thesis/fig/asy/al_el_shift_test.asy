unitsize(1cm);

StdFonts();

real mean = 0, sigma = 0.7, amp = 5;

void DrawGauss(real x_min = -4sigma, real x_max = +4sigma, pen p=black)
{
	guide g;
	for (real x = x_min; x <= x_max; x += sigma/20) {
		real y = amp * exp(- ((x - mean)/sigma)^2 / 2);
		g = g--(x, y);
	}
	draw(g, p);
}


DrawGauss(dotted);

real f_B = -2sigma, f_T = sigma;

DrawGauss(x_min=f_T, red);
DrawGauss(x_max=f_B, blue);
DrawGauss(x_min=-f_B, heavygreen+1pt);

draw(Label("center", 1), (0, 0)--(0, 1.1amp), dashed);
draw(Label("$f_B$", 0), (f_B, 0)--(f_B, 0.2amp), blue+dashed);
draw(Label("$f_T$", 0), (f_T, 0)--(f_T, 0.8amp), red+dashed);

draw((-f_B, 0.1amp)--(-f_B, 0.8amp), heavygreen+dashed);

draw("$s$", (f_T, 0.7amp)--(-f_B, 0.7amp), EndArrow);

draw(Label("$y$", 1), (-4sigma, 0)--(4sigma, 0), EndArrow);

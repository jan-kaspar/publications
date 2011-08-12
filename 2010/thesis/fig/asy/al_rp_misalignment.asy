//import pad_layout;

//NewPad(false, false);
unitsize(1mm);

StdFonts();

real l = 10, d = 17;
int n = 4;
pair c0 = (0, 0);
pair c = (-5, 20);
real al = -10;

real dot_r = 1;

draw((c0+(-1*d, 0))--(c0+(d*n)), dotted);
draw(rotate(al)*((c+(-1*d, 0))--(c+(d*n))), dotted);

draw(Label("$\De\rh_x^{\rm DP}$", 0.5, E), arc(rotate(al)*c, 3.5*d, 0, al), dotted);

draw((rotate(al)*c+(-d, 0))--(rotate(al)*c+(n*d, 0)), dotted);

for (int i = 0; i < n; ++i) {
	Label lab = "";
	if (i == 0)
		lab = Label("$\De\vec c_i$", 0.5, SW);
	draw(lab, (c0 + (i*d, 0))--(rotate(al)*(c+(i*d, 0))), blue, EndArrow(10));

	filldraw(shift(c0 + (i*d, 0))*scale(dot_r)*unitcircle, white, black);
	filldraw(shift(rotate(al)*(c+(i*d, 0)))*scale(dot_r)*unitcircle, black, black);

	draw(rotate(al) * ((c + (i*d, -l))--(c + (i*d, +l))), black);
}

draw(Label("$\vec s^{\rm DP}$", 0.5, SW, UnFill), (c0 + ((n-1)/2*d, 0))--(rotate(al)*(c+((n-1)/2*d, 0))), heavygreen, EndArrow(10));

real x_min = -d-5, x_max = 4*d+5, y_min = -5, y_max = 25;
draw(Label("z", 1), (x_min, y_min)--(x_max, y_min), EndArrow);
draw(Label("y", 1), (x_min, y_min)--(x_min, y_max), EndArrow);

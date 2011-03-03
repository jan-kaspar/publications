//import pad_layout;

//NewPad(false, false);
unitsize(1mm);

StdFonts();

real l = 10, d = 10;
int n = 4;
pair c0 = (0, 0);
pair c = (-5, 20);
real al = -10;

dotfactor = 12;

draw((c0+(-1*d, 0))--(c0+(d*n)), dotted);
draw(rotate(al)*((c+(-1*d, 0))--(c+(d*n))), dotted);

draw(Label("$\De\rh^{\rm RP}$", 0.5, E), arc(rotate(al)*c, 4*d, 0, al), dotted);

draw((rotate(al)*c+(-d, 0))--(rotate(al)*c+(n*d, 0)), dotted);

for (int i = 0; i < n; ++i) {
	Label lab = "";
	if (i == 0)
		lab = Label("$\De\vec c_i$", 0.5, SW);
	draw(lab, (c0 + (i*d, 0))--(rotate(al)*(c+(i*d, 0))), blue, EndArrow(10));

	dot(c0 + (i*d, 0), gray);
	dot(rotate(al)*(c+(i*d, 0)), black);

	draw(rotate(al) * ((c + (i*d, -l))--(c + (i*d, +l))), black);
}

draw(Label("$\vec s^{\rm RP}$", 0.5, SW, UnFill), (c0 + ((n-1)/2*d, 0))--(rotate(al)*(c+((n-1)/2*d, 0))), heavygreen, EndArrow(10));

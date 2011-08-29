unitsize(0.7cm);

StdFonts();


//--- left -------------------------------------------------------------------------------------------

real wd = 4, ht = 1.3, dp = 1;
draw((-wd, 0)--(+wd, 0), EndArrow);	label("$L_x$", (wd, 0), E);
draw((0, -dp)--(0, ht), EndArrow); label("$x$", (0, ht), N);

real th = 0.2;
draw((-wd, -wd*th)--(wd, wd*th), dashed);

real r = 2.5;
draw(Label("$\th$"), arc((0, 0), (r, 0), (r/sqrt(1+th*th), r*th/sqrt(1+th*th))));

filldraw(shift(3.0, 3.0*th)*scale(0.1)*unitcircle, blue, drawpen=blue);
filldraw(shift(3.5, 3.5*th)*scale(0.1)*unitcircle, blue, drawpen=blue);

filldraw(shift(-3.0, -3.0*th)*scale(0.1)*unitcircle, blue, drawpen=blue);
filldraw(shift(-3.5, -3.5*th)*scale(0.1)*unitcircle, blue, drawpen=blue);

filldraw(shift(3.0, -1.0*th)*scale(0.1)*unitcircle, red, drawpen=red);
filldraw(shift(-3.5, 7*th)*scale(0.1)*unitcircle, red, drawpen=red);


//--- right ------------------------------------------------------------------------------------------

real shx = 10, shy = -1;
ht = 1;
draw((shx-wd, shy)--(shx+wd, shy), EndArrow);	label("$x\over L_x$", (shx+wd, shy), E);
draw((shx, shy)--(shx, shy+2*ht), EndArrow); label("weight", (shx, shy+2ht), N);

real b = 0.5, x, y;

x = 2; y = 1.2; draw((shx+x-b/2, shy)--(shx+x-b/2, shy+y)--(shx+x+b/2, shy+y)--(shx+x+b/2, shy), blue);
draw(((shx+x-b/2, shy+y)--(shx, shy+y)), dotted + blue); label("$4$", (shx, shy+y), W);
x = -3; y = 1.2/4; draw((shx+x-b/2, shy)--(shx+x-b/2, shy+y)--(shx+x+b/2, shy+y)--(shx+x+b/2, shy), red);
draw(((shx+x+b/2, shy+y)--(shx, shy+y)), dotted + red); label("$1$", (shx, shy+y), E);
x = -1; y = 1.2/4; draw((shx+x-b/2, shy)--(shx+x-b/2, shy+y)--(shx+x+b/2, shy+y)--(shx+x+b/2, shy), red);

label("background", (shx-2, shy+0.3), N, red);
label("track", (shx+2, shy+1.2), N, blue);
label("$\th$", (shx+2, shy), S);

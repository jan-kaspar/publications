import three;

unitsize(0.8cm);
StdFonts();
currentprojection = perspective(3*(-10, 5, 10), up=Y, autoadjust=false, center=false);

real xal = 3, yal = 2.5, zal = 7, tl = 1, zl = 7, pl = 6;
real th = 15, ph = 210;

// axes
draw(Label("$x$", 1), (0, 0, 0)--(xal, 0, 0), EndArrow3);
draw(Label("$y$", 1), (0, 0, 0)--(0, yal, 0), EndArrow3);
draw(Label("$z$", 1), (0, 0, 0)--(0, 0, zal), EndArrow3);

draw((-tl, 0, 0)--(+tl, 0, 0), dotted);
draw((0, -tl, 0)--(0, +tl, 0), dotted);
draw((0, 0, -zl)--(0, 0, +zl), dotted);

// incident protons
draw(Label("$2$", 0.5), (0, 0, pl)--(0, 0, 0), blue+1pt, EndArrow3(8));
draw(Label("$1$", 0.5), (0, 0, -pl)--(0, 0, 0), blue+1pt, EndArrow3(8));

// scattered protons
real x = pl * Sin(th) * Cos(ph);
real y = pl * Sin(th) * Sin(ph);
real z = pl * Cos(th);
real r = pl * Sin(th);

draw(Label("$1'$", 0.5), (0, 0, 0)--(x, y, z), red+1pt, EndArrow3(8));
draw(Label("$2'$", 0.5, N), (0, 0, 0)--(-x, -y, -z), red+1pt, EndArrow3(8));

draw((-tl, 0, z)--(+xal, 0, z), dotted);
draw((0, -tl, z)--(0, +yal, z), dotted);
real f = 0.7;
draw(Label("$\th$", 1.5, NW+W), arc((0, 0, 0), (0, 0, z*f), (x*f, y*f, z*f)), EndArrow3);
f = 0.7;
draw(Label("$\ph$", 2.33, W), arc((0, 0, z), (r*f, 0, z), (x*f, y*f, z), (0, 0, 1)), EndArrow3);
draw((0, 0, z)--(x, y, z), dotted);

// interaction
dot((0, 0, 0), black+6pt);


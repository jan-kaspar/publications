import pad_layout;

StdFonts();

dotfactor=10;

real H = 3, W = 3;
real h = 1.5, w = 1.5;
real l = 1.5;
real lp = 1.8;

real rho = 60;

//--------------------------------------------------

picture base;
currentpicture = base;

draw((-W, 0)--(+W, 0), EndArrow);
label("$x$", (+W, 0), E);
draw((0, -H)--(+0, +H), EndArrow);
label("$y$", (0, +H), N);

dot((0, +h));
dot((0, -h));

draw((0, +h)--((0, +h)+rotate(45)*(l, 0)), EndArrow);
draw((0, +h)--((0, +h)+rotate(135)*(l, 0)), EndArrow);

draw((0, +h)--((0, +h)+rotate(45+rho)*(l, 0)), red, EndArrow);
draw((0, +h)--((0, +h)+rotate(135+rho)*(l, 0)), red, EndArrow);

draw((0, -h)--((0, -h)+rotate(-45)*(l, 0)), EndArrow);
draw((0, -h)--((0, -h)+rotate(-135)*(l, 0)), EndArrow);

draw((0, -h)--((0, -h)+rotate(-45+rho)*(l, 0)), red, EndArrow);
draw((0, -h)--((0, -h)+rotate(-135+rho)*(l, 0)), red, EndArrow);

//--------------------------------------------------

picture base2;
currentpicture = base2;


dot((0, +h), red);
dot((0, -h), red);

draw((0, +h)--((0, +h)+rotate(45+rho)*(l, 0)), red, EndArrow);
//label(rotate(-45+rho)*Label("$u'$"), (0, +h)+rotate(45+rho)*(lp, 0), red);
draw((0, +h)--((0, +h)+rotate(135+rho)*(l, 0)), red, EndArrow);
//label(rotate(45+rho)*Label("$v'$"), (0, +h)+rotate(135+rho)*(lp, 0), red);

draw((0, -h)--((0, -h)+rotate(-45+rho)*(l, 0)), red, EndArrow);
draw((0, -h)--((0, -h)+rotate(-135+rho)*(l, 0)), red, EndArrow);

//--------------------------------------------------

NewPad(false, autoSize=false);
unitsize(1cm);
add(base);


NewPad(false, autoSize=false);
unitsize(1cm);
add(rotate(-rho)*base);

draw((-W, 0)--(+W, 0), red, EndArrow);
label("$x'$", (+W, 0), E, red);
draw((0, -H)--(+0, +H), red, EndArrow);
label("$y'$", (0, +H), N, red);


NewPad(false, autoSize=false);
unitsize(1cm);
add(rotate(-rho)*base2);

dot((0, +h), black);
dot((0, -h), black);

draw("$\De s$", (0, +h)--(rotate(-rho)*(0, +h)), blue, EndArrow(5));
draw("$\De s$", (0, -h)--(rotate(-rho)*(0, -h)), blue, EndArrow(5));

draw((-W, 0)--(+W, 0), red, EndArrow);
label("$x'$", (+W, 0), E, red);
draw((0, -H)--(+0, +H), red, EndArrow);
label("$y'$", (0, +H), N, red);

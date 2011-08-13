unitsize(0.7cm);

StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det0;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

clip(Det0, Det0Shape);
draw(Det0, Det0Shape, black + 1);


//----------------------------------------------------------------------------------------------------

add(rotate(45) * shift(-edge/2, -edge/2) * Det0);

real pr = 0.1;

pair fm1 = (-edge/2, 0);
pair fm2 = (+edge/2, 0);


pair rp = (4, 3);


draw(Label("$y$", 1), rp--(rp.x, -1), EndArrow);
draw(Label("$x$", 1), rp--(-4, rp.y), EndArrow);

draw(Label("$31.631\,\rm mm$", 1, E), fm1--(rp.x, fm1.y), dotted);
draw(Label("$75.068\,\rm mm$", 1, N), fm1--(fm1.x, rp.y), dotted);
draw(Label("$25.932\,\rm mm$", 1, N), fm2--(fm2.x, rp.y), dotted);

filldraw(circle(fm1, pr), blue, blue); label("1", (-edge/2, 0), SE);
filldraw(circle(fm2, pr), blue, blue); label("2", (+edge/2, 0), SW);
//filldraw(circle((0, +edge/2), pr)); label("3", (0, +edge/2), S*1mm);

filldraw(circle(rp, pr), red, red); label("\vbox{\hsize2.8cm\noindent reference point}", rp, NE);

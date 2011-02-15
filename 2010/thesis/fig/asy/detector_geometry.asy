unitsize(1cm);

StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 75;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

// strips
real delta = (edge - margin_v_b - margin_v_e) / (strips - 1);
for (int i = 0; i < strips; ++i) {
	draw(Det, (margin_u, margin_v_b + i*delta)--(edge-margin_u, margin_v_b + i*delta), black+0.1pt);
}

// clip shape and draw boundary
clip(Det, Det0Shape);
draw(Det, Det0Shape, black + 2);

//----------------------------------------------------------------------------------------------------

pair c = (4, 2);
add(shift(c) * rotate(60) * reflect((0, 0), (1, 1)) * shift(-edge/2, -edge/2) * Det);
pair dep = shift(c) * rotate(60) * (3, 0);
draw(c--dep, EndArrow);
label("$\vec d$", dep, NW);

draw(c--(c+(1, 0)), dashed);
draw(Label("$\rh$"), arc(c, 0.6, 0, 60), EndArrow);

pair h = (3.5, 3.5);
dotfactor = 10;
dot(h, blue);
pair dr = dep - c;
pair hr = h - c;
pair x = c + dr * dot(dr, hr) / dot(dr, dr);
draw(h--x, blue+dashed);
draw(c--x, blue+2pt);

dot(c);
draw((c.x, 0)--c, dashed);
draw((0, c.y)--c, dashed);
label("$c_x$", (c.x, 0), S);
label("$c_y$", (0, c.y), W);

real xal = 7;
real yal = 5;
draw((0, 0)--(xal, 0), EndArrow);
draw((0, 0)--(0, yal), EndArrow);
label("$x$", (xal, 0), E);
label("$y$", (0, yal), N);
dot((0, 0));
label("$z$", (0, 0), SW);

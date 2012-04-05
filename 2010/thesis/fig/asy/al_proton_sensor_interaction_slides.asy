StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 11;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

// strips
real delta = (edge - margin_v_b - margin_v_e) / (strips - 1);
for (int i = 0; i < strips; ++i) {
	pen col = black;
	draw(Det, (margin_u, margin_v_b + i*delta)--(edge-margin_u, margin_v_b + i*delta), col+0.2pt);
}

// clip shape and draw boundary
clip(Det, Det0Shape);
draw(Det, Det0Shape, black + 2);

//----------------------------------------------------------------------------------------------------

picture pFV;
currentpicture = pFV;
unitsize(1cm);

pair c = (0, 2);
real rho = 45;
add(shift(c) * rotate(rho) * shift(-edge/2, -edge/2) * Det);
pair vd = shift(c) * rotate(rho+90) * (3, 0); draw(c--vd, EndArrow); label("$\vec d$", vd, NW);

// center
dot(c);
label("$\vec c$", c, 1.2*SE, UnFill);
//draw(Label("$\rh_z$", UnFill), arc(c, 1, 0, 45), EndArrow);

// measurement
pair h = (-0.6, 3.5);
dotfactor = 10;
dot(h, blue);
label(Label("hit", UnFill), h, 2*E+0.5N, blue);
pair dr = vd - c;
pair hr = h - c;
pair x = c + dr * dot(dr, hr) / dot(dr, dr);
draw(h--x, blue+dashed);
draw(Label("$m$", 0.5, SW, UnFill), c--x, blue+2pt);


//----------------------------------------------------------------------------------------------------

picture pSV;
currentpicture = pSV;
unitsize(1cm);

real cx = 2.5, cy = 2, rh_x = 0, l = 1.5, la = 1.2;
real a = 0.2, b =  2.5;

real dcx = -0.2, dcy = -0.4;

real lx = 4, ly = 4;

// axes
draw(Label("$z$", 1), (0, 0)--(lx, 0), EndArrow);
draw(Label("$y$", 1), (0, 0)--(0, ly), EndArrow);

// detector with axes
draw((cx, cy)+rotate(rh_x)*(0, l) -- (cx, cy)+rotate(rh_x)*(0, -l), black+2pt);

// center
filldraw(shift(cx, cy)*scale(0.09)*unitcircle, black, black);


// track
draw(Label("$b_y$", 0, W), (0, b)--(lx, lx*a+b), blue);
draw((0, b)--(1.7, b), blue+dashed);
draw(Label("$a_y$"), arc((0, b), 1.6, 0, aTan(a)), blue);

// hit
real eta = (Cos(rh_x)*cx - Sin(rh_x)*(b - cy)) / (-Sin(rh_x)*a - Cos(rh_x));
dot((0, b)-eta*(1, a), blue);
label("hit", (0, b)-eta*(1, a), 1.1*N+E, blue);

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label("front view", (8, +5));
attach(pFV.fit(), (8, 0));

label("side view", (2, +5));
attach(pSV.fit(), (0, 0));

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
	pen col = (i == strips-1) ? heavygreen : black;
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
pair ud = shift(c) * rotate(rho) * (3, 0); draw(c--ud, EndArrow); label("$\vec u$", ud, NE);
pair vd = shift(c) * rotate(rho+90) * (3, 0); draw(c--vd, EndArrow); label("$\vec v \equiv\vec d$", vd, NW);
pair dp = shift(c) * rotate(rho+180) * (3, 0); draw(c--dp, EndArrow); label("$\vec d_\perp \equiv - \vec u$", dp, SW);

// center
dot(c);
draw((c+(-3, 0))--(c+(3, 0)), dashed);
label("$\vec c$", c, SE, UnFill);
draw(Label("$\rh_z$", UnFill), arc(c, 1, 0, 45), EndArrow);

// pitch correction
pair hs = rotate(45)*(0, margin_v_b+(strips-1)*delta-edge/2);
draw(c--(c+hs), red+2pt);

// measurement
pair h = (-0.6, 3.5);
dotfactor = 10;
dot(h, blue);
pair dr = vd - c;
pair hr = h - c;
pair x = c + dr * dot(dr, hr) / dot(dr, dr);
draw(h--x, blue+dotted);
draw(c--x, blue+2pt);


//----------------------------------------------------------------------------------------------------

picture pSV;
currentpicture = pSV;
unitsize(1cm);

real cx = 3, cy = 2, rh_x = -20, l = 1.5, la = 1.2;
real a = 0.2, b =  2.5;

real lx = 6, ly = 4;

// axes
draw(Label("$z$", 1), (0, 0)--(lx, 0), EndArrow);
draw(Label("$y$", 1), (0, 0)--(0, ly), EndArrow);

// center
dot((cx, cy));
draw(Label("$c_z$", 0, S), (cx, 0) -- (cx, ly), dashed);
draw(Label("$c_y$", 0, W), (0, cy) -- (lx, cy), dashed);

// detector with axes
draw((cx, cy)+rotate(rh_x)*(0, l) -- (cx, cy)+rotate(rh_x)*(0, -l), black+2pt);
draw(Label("z'", 1), (cx, cy) -- (cx, cy)+rotate(rh_x-90)*(0, l), EndArrow);
draw(Label("$\rh_x$"), arc((cx, cy), la, rh_x, 0), black);

// track
draw(Label("$b_y$", 0, W), (0, b)--(lx, lx*a+b), blue);
draw((0, b)--(1.7, b), blue+dashed);
draw(Label("$a_y$"), arc((0, b), 1.6, 0, aTan(a)), blue);

// hit
real eta = (Cos(rh_x)*cx - Sin(rh_x)*(b - cy)) / (-Sin(rh_x)*a - Cos(rh_x));
dot((0, b)-eta*(1, a), blue);

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label("front view", (12, +5));
attach(pFV.fit(), (12, 0));

label("side view", (3, +5));
attach(pSV.fit(), (0, 0));

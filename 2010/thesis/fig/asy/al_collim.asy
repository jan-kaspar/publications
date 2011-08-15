unitsize(1mm);

StdFonts();

real zs = -20, z0 = 0, zm = 30, z1 = 60, ze = 80;
real hs = 6, h0 = 7, hm = 8, h1 = 13, he = 15;
real hobj = 10;
real ot = 5, ob = -7;

pen pObj = black+4pt;

draw((zs, 0)--(ze, 0), dashdotted+blue);

draw((zs, hs)..(z0, h0)..(zm, hm)..(z1, h1)..(ze, he), blue);
draw((zs, -hs)..(z0, -h0)..(zm, -hm)..(z1, -h1)..(ze, -he), blue);

draw((z0, h0)--(z0, h0+hobj), pObj);
draw((z1, h1)--(z1, h1+hobj), pObj);
draw((z0, -h0)--(z0, -h0-hobj), pObj);
draw((z1, -h1)--(z1, -h1-hobj), pObj);

label("top collimator", (z0, h0+hobj/2), 2W);
label("bottom collimator", (z0, -h0-hobj/2), 2W);

label("top RP", (z1, h1+hobj/2), 2E);
label("bottom RP", (z1, -h1-hobj/2), 2E);


draw(Label("$n\si_0$"), (z0, 0)--(z0, h0), W, EndArrow);
draw(Label("$n\si_0$"), (z0, 0)--(z0, -h0), W, EndArrow);

draw(Label("$n\si$"), (z1, 0)--(z1, h1), W, EndArrow);
draw(Label("$n\si$"), (z1, 0)--(z1, -h1), W, EndArrow);

real t = ze;

draw((z1, h1)--(ze, h1), dotted);
draw((z1, -h1)--(ze, -h1), dotted);

t = z1 + (ze - z1)/2;

dotfactor = 10;

dot((t, ot), red);
dot((t, ob), red);
draw("$o_t$", (t, 0)--(t, ot), E, EndArrow); 
draw("$t$", (t, ot)--(t, h1), E, EndArrow); 

draw("$o_b$", (t, 0)--(t, ob), E, EndArrow); 
draw("$b$", (t, ob)--(t, -h1), E, EndArrow); 

// axes
real al = 15, za = 30;
draw(Label("$y$", 1, NW), (za, 0)--(za, al), EndArrow);
draw(Label("$z$", 1, SE), (za, 0)--(za+al, 0), EndArrow);

shipout(bbox(3mm, nullpen));

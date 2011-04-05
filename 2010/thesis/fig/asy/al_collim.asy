unitsize(1mm);

StdFonts();

real z0 = 0, z1 = 60;
real h0 = 10, h1 = 15;
real hobj = 10;
real f = 5;
real ot = 5, ob = -7;

pen pObj = black+4pt;

draw((z0-(z1-z0)/f, 0)--(z1+(z1-z0)/f, 0), dashdotted+blue);
draw((z0-(z1-z0)/f, h0-(h1-h0)/f)--(z1+(z1-z0)/f, h1+(h1-h0)/f), blue);
draw((z0-(z1-z0)/f, -h0+(h1-h0)/f)--(z1+(z1-z0)/f, -h1-(h1-h0)/f), blue);

draw((z0, h0)--(z0, h0+hobj), pObj);
draw((z1, h1)--(z1, h1+hobj), pObj);
draw((z0, -h0)--(z0, -h0-hobj), pObj);
draw((z1, -h1)--(z1, -h1-hobj), pObj);

label("top collimator", (z0, h0+hobj), N);
label("bottom collimator", (z0, -h0-hobj), S);

label("top RP", (z1, h1+hobj), N);
label("bottom RP", (z1, -h1-hobj), S);


draw(Label("$n\si_0$"), (z0, 0)--(z0, h0), W, EndArrow);
draw(Label("$n\si_0$"), (z0, 0)--(z0, -h0), W, EndArrow);

draw(Label("$n\si$"), (z1, 0)--(z1, h1), W, EndArrow);
draw(Label("$n\si$"), (z1, 0)--(z1, -h1), W, EndArrow);

real t = (z1-z0)/f;

draw((z1, h1)--(z1+t, h1), dotted);
draw((z1, -h1)--(z1+t, -h1), dotted);

t = z1 + t/2;

dot((t, ot), red);
dot((t, ob), red);
draw("$o_t$", (t, 0)--(t, ot), E, EndArrow); 
draw("$t$", (t, ot)--(t, h1), E, EndArrow); 

draw("$o_b$", (t, 0)--(t, ob), E, EndArrow); 
draw("$b$", (t, ob)--(t, -h1), E, EndArrow); 

shipout(bbox(3mm, nullpen));
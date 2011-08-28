unitsize(1cm);

StdFonts();

real w = 5, h = 2.5, lp = 4, al = 20;
real wp = 1.5, hp = 1.5;
real bw = 0.75, bh = 0.25, bp = 3, ba = 2.5;


draw(Label("$z$", 1), (-w, 0)--(+w, 0), EndArrow);
draw(Label("$x$", 1), (0, 0)--(0, h), EndArrow);
draw((0, 0)--(lp*Cos(al), lp*Sin(al)), dotted);
draw((0, 0)--(-lp*Cos(al), lp*Sin(al)), dotted);

draw("$\al$", arc((0, 0), 1.3, 0, al));
draw("$\al$", arc((0, 0), 1.3, 180-al, 180));

picture b1;
draw(b1, Label("$v$", 0.5, N), (bw, 0)--(+ba, 0), blue, EndArrow);
filldraw(b1, scale(bw, bh)*unitcircle, lightblue, nullpen);
label(b1, "bunch 1", 0.5*S, blue);

picture b2;
draw(b2, Label("$\tilde z$", 1), (-wp, 0)--(+wp, 0), EndArrow);
draw(b2, Label("$\tilde x$", 1), (0, 0)--(0, hp), EndArrow);
draw(b2, Label("$v$", 0.5, N), (-bw, 0)--(-ba, 0), red, EndArrow);
filldraw(b2, scale(bw, bh)*unitcircle, lightred, nullpen);
label(b2, "bunch 2", 0.5*S, red);

add(rotate(-al)*shift(-bp, 0)*b1);
add(rotate(+al)*shift(+bp, 0)*b2);



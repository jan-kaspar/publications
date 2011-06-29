unitsize(1cm);

StdFonts();

real l = 3;
real th = 0.3;

draw((-l, 0)--(0, 0), black, MidArrow);
draw((0, 0)--(l*cos(th), l*sin(th)), black, MidArrow);

draw((l, 0)--(0, 0), black, MidArrow);
draw((0, 0)--(-l*cos(th), -l*sin(th)), black, MidArrow);

filldraw(scale(0.1)*unitcircle, white, black);

draw(Label("$\th$"), arc((0, 0), 2, 0, th*180/3.141593), dotted);

label("$(E|0, 0, p)$", (-l, 0), W);
label("$(E|p\sin\th, 0, p\cos\th)$", (l*cos(th), l*sin(th)), E);
label("$(E|0, 0, -p)$", (l, 0), E);
label("$(E|-p\sin\th, 0, -p\cos\th)$", (-l*cos(th), -l*sin(th)), W);

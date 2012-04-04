unitsize(1cm);

real x1 = -1, x2 = 0, x3 = 2, x4 = 4;
real y1= -1, y2 = 0, y3 = +1;

real al = 20;

draw(Label("$z$", 1), (x1, y2)--(x4, y2), EndArrow);
draw(Label("$y$", 1), (x2, y1)--(x2, y3), EndArrow);

draw((x1, y2 + Tan(al)*(x1-x3))--(x4, y2 + Tan(al)*(x4-x3)), blue, Arrows);

draw(Label("$\si(z^*)$", 0.5, N), (x2, y2)--(x3, y2), red+1pt);
draw(Label("$\De y^*$", 0.5, W), (x2, y2)--(x2, y2 + Tan(al)*(x2-x3)), heavygreen+1pt);

filldraw(shift(x3, y2)*scale(0.1)*unitcircle, blue, blue);
filldraw(shift(x2, y2 + Tan(al)*(x2-x3))*scale(0.1)*unitcircle, white, blue);

label("actual vertex", (x3, y2), SE, blue);
label("``effective'' vertex", (x2, y2 + Tan(al)*(x2-x3)), SE, blue);

draw(Label("$\th_y^*$"), arc((x3, y2), 1.3, 0, al));

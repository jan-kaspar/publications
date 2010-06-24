unitsize(1cm);

draw((0, 0)--(8, 0), EndArrow);
label("$\eta$", (8, 0), S);

filldraw((1, 0)--(1, 1)--(1.1, 1)--(1.1, 0)--cycle, lightgray, black);
draw((4, 0)--(4, 1), dashed);
filldraw((4, 0){1, 0}..(5, 0.5)..(5.5, 0.4)..(6, 0.6)..{1, 0}(6.5, 0)--cycle, lightgray, black);
label("p", (1, 0.7), NW);
label("M", (5.2, 0.7), N);
draw((1.1, 0.8)--(4, 0.8), Arrows);
label("$\De\eta$", (2.5, 0.8), S);

shipout(bbox(2mm, nullpen));

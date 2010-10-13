import three; import math;
unitsize(1cm);
currentprojection = orthographic((-0.5, 0.5, 1), (0, 1, 0));
currentprojection = perspective(3*(-7, 4.5, 9), up=Y);

// some def
triple O = (0, 0, 0);
real s2 = sqrt(2) / 2;
real fa = 0.8;

// axes
draw((-5, 0, 0)--(5, 0, 0), EndArrow3);
draw((0, -1, 0)--(0, 3, 0), EndArrow3);
draw((0, 0, -10)--(0, 0, 10), EndArrow3);

label("$x$", (5.5, 0, 0));
label("$y$", (0, 3.5, 0));
label("$z$", (0, 0, 10.5));

label(project(Label("outside ring"), X, Y, (2.5, 0.3, 0)));
label(project(Label("beam line"), Z, Y, (0.5, 0, +2.)));

// momentum 2
triple P1 = (-0.5, -1.0, -7);
draw(O--P1, linewidth(2bp), EndArrow3(10bp));
label("$p_2$", P1/2, S);
label("$\vartheta_2$", P1/2 + (-0.1, 0, -0.6), N);
fa = 0.7;
draw(arc(O, fa*P1, (0, 0, -fa * length(P1))), BeginArrow3);
draw((-1.5, 0., P1.z)--(1.5, 0., P1.z), dotted);
draw((0, -0.8, P1.z)--(0, 1, P1.z), dotted);
draw((0, 0, P1.z)--P1, dotted);
fa = 0.5;
triple temp1 = (fa * P1.x, fa * P1.y, P1.z);
draw(arc((0, 0, P1.z), temp1, (-length(temp1), 0, P1.z)), BeginArrow3);
label("$\varphi_2$", temp1 - (0.2, 0, 0), W);

// momentum 1
triple P2 = (-1, -1, 7);
draw(O--P2, linewidth(2bp), EndArrow3(10bp));
label("$p_1$", P2/2, SW);
label("$\vartheta_1$", P2/2, NE);
fa = 0.6;
draw(arc(O, fa*P2, (0, 0, fa * length(P2))), BeginArrow3);
draw((-1.5, 0., P2.z)--(1.5, 0., P2.z), dotted);
draw((0, -1., P2.z)--(0, 1, P2.z), dotted);
draw((0, 0, P2.z)--P2, dotted);
fa = 0.4;
triple temp2 = (fa * P2.x, fa * P2.y, P2.z);
draw(arc((0, 0, P2.z), temp2, (length(temp2), 0, P2.z), direction=CW), BeginArrow3);
label("$\varphi_1$", temp2 + (-0.1, +0.2, 0.), SW);

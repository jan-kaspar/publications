unitsize(1cm);

StdFonts();

real w = 4, h = 1.7, l = 3, lp = 4, al = 20, c1 = 5, c2 = 10, xi1 = -0.1, xi2 = 0.2;


draw(Label("$z$", 1), (-w, 0)--(+w, 0), EndArrow);
draw(Label("$x$", 1), (0, 0)--(0, h), EndArrow);
draw((0, 0)--(lp*Cos(al), lp*Sin(al)), dashed);
draw((0, 0)--(-lp*Cos(al), lp*Sin(al)), dashed);

draw(rotate(-al-c1)*Label("$\vec p_1$", 0.5, N), (-l*(1+xi1)*Cos(al+c1), l*(1+xi1)*Sin(al+c1))--(0, 0), blue, MidArrow);
draw(rotate(al+c2)*Label("$|\vec p_2| = p_{\rm nom} (1+\xi_2)$"), (l*(1+xi2)*Cos(al+c2), l*(1+xi2)*Sin(al+c2))--(0, 0), red, MidArrow);

draw("$\al$", arc((0, 0), 3, 0, al));
draw("$C_2$", arc((0, 0), 3.2, al, al+c2), red);

import three;
import math;
import solids;
unitsize(1cm);
currentprojection = orthographic((-0.5, 2, -0.5), (1, 0, 0));

// main axes
void Axes(real x1, real y1, real z1, real x2, real y2, real z2, real xsh = 0.3, real ysh = 0.3, real zsh = 0.3)
{
	draw((x1, 0, 0)--(x2, 0, 0), EndArrow3); label("$x$", (x2 + xsh, 0, 0));
	draw((0, -y1, 0)--(0, -y2, 0), EndArrow3); label("$y$", (0, -y2 - ysh, 0));
	draw((0, 0, z1)--(0, 0, z2), EndArrow3); label("$z$", (0, 0, z2 + zsh));
}

Axes(-0.5, -2, -5, 5, 5, 5, 0.3, 1, 0.3);

// bunch direcions
real al = 30, r = 5.5;
triple O = (0, 0, 0);
triple A = (r*Sin(al), 0, -r*Cos(al)), B = (r*Sin(al), 0, r*Cos(al));
draw(A--O--B, dotted);

// tilded axes
draw(B/r*4--(B/r*4 + 2*(Cos(al), 0, -Sin(al))), EndArrow3);
draw(B/r*4--B/r*6, EndArrow3);
//draw(B/r*4--(B/r*4 + (0, 5, 0)), EndArrow3);
label("$\tilde x$", B/r*4 + 2.3*(Cos(al), 0, -Sin(al)));
//label("$\tilde y$", B/r*4 + (0, 5.3, 0));
label("$\tilde z$", B/r*6.3);

// bunch shape
revolution bunch = zscale3(4) * sphere(O, 0.3);
real l = 3;
triple ay = (0, 1, 0);

pen BunCol(triple r)
{
	return gray;
}

// bunch 1
// TODO
//(rotate(-al, ay) * shift(0, 0, -4) * bunch).fill(BunCol);
draw(A/5*1--A/r*2.8, BeginArrow3);
draw(arc(O, A/5*2, (0, 0, -3)));
label("$\alpha$", (0.2, 0, -1.5), N);
label("$v$", A/r*1.5, N);
label(rotate(-al / 0.9) * Label("bunch 1"), rotate(-al, ay) * (-0.7, 0, -4));

// bunch 2
// TODO
//(rotate(al, ay) * shift(0, 0, 4) * bunch).fill(BunCol);
draw(B/5*1--B/r*2.8, BeginArrow3);
draw(arc(O, B/5*2, (0, 0, 3)));
label("$\alpha$", (0.2, 0, 1.5), N);
label("$v$", B/r*1.5, N);
label(rotate(al * 0.9) * Label("bunch 2"), rotate(al, ay) * (-0.7, 0, 4));

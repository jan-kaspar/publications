unitsize(1cm);

//----------------------------------------------------------------------------------------------------

picture Det0;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

draw(Det0, (0, edge)--(edge, 0), gray + dotted);
draw(Det0, (0, 0)--(edge, edge), gray + dotted);

clip(Det0, Det0Shape);
draw(Det0, Det0Shape, black + 1);


//----------------------------------------------------------------------------------------------------

void ShowLength(pair p1, pair p2, pair dir, string lab, real offset)
{
	dir = unit(dir);
	real pr1 = dot(p1, dir);
	real pr2 = dot(p2, dir);
	
	real al = 1.2;
	real be = 0.4;

	real ang;
	pair labPos;

	if (pr1 > pr2) {
		draw(p1--(p1 + al*offset*dir), dotted);
		draw(p2--(p2 + (al*offset + pr1 - pr2)*dir), dotted);
		draw((p1 + offset*dir)--(p2 + (offset + pr1 - pr2)*dir), Arrows);
		ang = degrees(p2-p1 + (pr1-pr2)*dir);
		labPos = (p1+p2)/2. + (offset + (pr1 - pr2)/2. + be)*dir;
	} else {
		draw(p1--(p1 + (al*offset + pr2 - pr1)*dir), dotted);
		draw(p2--(p2 + al*offset*dir), dotted);
		draw((p1 + (offset + pr2 - pr1)*dir)--(p2 + offset*dir), Arrows);
		ang = degrees(p2-p1 + (pr1-pr2)*dir);
		labPos = (p1+p2)/2. + (offset + (pr2 - pr1)/2. + be)*dir;
	}
	
	if (90 < ang && ang < 180)	ang = ang + 180;
	if (180 <= ang && ang < 270)	ang = ang - 180;
	
	frame f;
	label(f, Label(lab), Fill(5, 5, white));
	add(rotate(ang) * f, labPos);
}

//----------------------------------------------------------------------------------------------------

real c = 3;

add(shift(0, c) * rotate(45) * shift(-edge/2, -edge/2) * Det0);
add(shift(c, 0) * rotate(-45) * shift(-edge/2, -edge/2) * Det0);

filldraw(scale(0.05)*unitcircle, black);

draw((0, 0)--(0, -1.5), gray+dotted);
draw((0, -0.8)--(3-eD, -0.8), Arrows);
label("$d_y$", ((3-eD)/2, -0.8), N);
//draw((0, -1.8)--(3, -1.8), Arrows);
//label("15.19", (3/2, -1.8), S);

draw((0, 0)--(-1.5, 0), gray+dotted);
draw((-0.8, 0)--(-0.8, 3-eD), Arrows);
label("$d_x$", (-0.8, (3-eD)/2), E);
//draw((-1.8, 0)--(-1.8, 3), Arrows);
//label("15.74", (-1.8, 3/2), W);

real s2 = sqrt(2);
ShowLength((edge/s2, c), (0, edge/s2 + c), (1, 1), "36.101", 0.5);
ShowLength((c - eD, -edge/s2 + eD), (c, -edge/s2), (0, -1), "14.391", 0.5);
ShowLength((-edge/s2, c), (-edge/s2+eD, c-eD), (-1, -1), "20.352", 0.5);
ShowLength((edge/s2-eD, c-eD), (-edge/s2+eD, c-eD), (0, 1), "22.2121", 0.5);

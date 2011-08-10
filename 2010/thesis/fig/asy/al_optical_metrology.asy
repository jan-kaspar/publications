unitsize(0.7cm);

StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det0;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

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

add(rotate(45) * shift(-edge/2, -edge/2) * Det0);

filldraw(circle((-edge/2, 0), 0.1)); label("1", (-edge/2, 0), E*1mm);
filldraw(circle((+edge/2, 0), 0.1)); label("2", (+edge/2, 0), W*1mm);
//filldraw(circle((0, +edge/2), 0.1)); label("3", (0, +edge/2), S*1mm);

filldraw(circle((5, 3), 0.1)); label("\vbox{\hsize2.8cm\noindent reference point (fixed on RP)}", (5, 3), NE*1mm);

ShowLength((+edge/2, 0), (5, 3), (1, 0), "$y_{\rm ref}$", 0);
ShowLength((+edge/2, 0), (5, 3), (0, 1), "$x_{\rm ref}$", 0);

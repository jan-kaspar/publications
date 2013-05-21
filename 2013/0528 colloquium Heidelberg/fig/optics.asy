unitsize(1mm);


label("$
\eqnarray{
	x({\rm RP}) =	&\hskip3.7mm (\cRe\hbox{effective length } L_x\cFg)	& \cdot (\cBl\hbox{scattering angle }\th_x^*\cFg)\cr
					&+ (\cRe\hbox{magnification } v_x\cFg)		& \cdot (\cBl\hbox{vertex } x^*\cFg)\cr
					&+ (\cRe\hbox{dispersion } D_x\cFg)		& \cdot (\cBl\hbox{rel. momentum loss } \xi \equiv {\De p\over p}\cFg)\cr
}
$");

real h = 6, y = 11, x;
x = -42; draw(Label("\cFg hit position at RP\cFg", 0.001*N), (x, y+h)--(x, y), EndArrow);
x = -11; draw(Label("\cRe optical functions\cFg", 0.001*N), (x, y+h)--(x, y), EndArrow);
x = +25; draw(Label("\cBl proton kinematics at IP\cFg", 0.001*N), (x, y+h)--(x, y), EndArrow);

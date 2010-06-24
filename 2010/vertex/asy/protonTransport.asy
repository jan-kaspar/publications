import root;

unitsize(1cm);

real edge = 36.101;
real cutEdge = 22.2721 / sqrt(2);

path Det0 = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
path Det = shift(0, -cutEdge/sqrt(2)) * rotate(45) * Det0;

void DrawDets(real o)
{
	draw(shift(0, o)*Det, black+1pt);
	draw(shift(0, -o)*rotate(180)*Det, black+1pt);
	limits((-50, -50), (50, 50), Crop);
}


string file = "hitDistributions_90.root";
pen hitPen = blue + 0.5pt;
draw(rGetObj(file, "unit_123|det_124"), "p", hitPen);
draw(rGetObj(file, "unit_123|det_125"), "p", hitPen);

real edgeShift = 6.4;

DrawDets(edgeShift);
filldraw(ellipse((0, 0), 3.99, 5.9), lightred, nullpen);

picture tView = currentpicture;

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

real factor = 15;

real z_IP = 0, z_det = 9, z_beg = 2, z_end = 7;
real l_axis = 1, h_axis = 1.5, h_box = 1;
real h_det_beg = edgeShift/factor, h_det_end = h_det_beg + (2*edge - cutEdge)/sqrt(2)/factor;

draw((z_IP - l_axis, 0)--(z_det + l_axis, 0), red+1pt, EndArrow(7));
filldraw((z_beg, h_box)--(z_beg, -h_box)--(z_end, -h_box)--(z_end, h_box)--cycle, lightgray, black);

label("interaction", (z_IP, 0.5), N, UnFill);
label("point", (z_IP, 0), N, UnFill);
label("LHC magnet lattice", ((z_beg + z_end)/2, -h_box), S);
label("beam", (z_det + l_axis, 0), E, red);

real x_st = 0., th_x = -0.2;
real x_beg = x_st + (z_beg - z_IP) * th_x;
real x_end = 0.2, th_xp = 0.3;
real x_det = x_end + (z_det - z_end) * th_xp;
real de = (z_end - z_beg) / 4;

draw((z_det, h_det_beg)--(z_det, h_det_end), black+3pt);
draw((z_det, -h_det_beg)--(z_det, -h_det_end), black+3pt);

draw((z_IP, x_st)--(z_beg, x_beg), blue+1pt, MidArrow(7));
draw((z_beg, x_beg){1, th_x}..(z_beg+de, -0.0)..(z_beg+2de, +0.5)..(z_beg+3de, -0.2)..{1, th_xp}(z_end, x_end), blue+dotted+1pt);
draw((z_end, x_end)--(z_det, x_det), blue+1pt, MidArrow(7));
dot((z_IP, x_st), black+7pt);
dot((z_det, x_det), blue+7pt);
label("\vbox{\hsize3cm\SmallerFonts\noindent hit at\hfil\break detector}", (z_det, x_det), E*2, blue);
label(rotate(-12) * Label("\vbox{\hsize15mm\SmallerFonts\noindent scattered\hfil\break proton}"), ((z_IP, x_st)+(z_beg, x_beg)) / 2, S*2, blue);

real xShift = 14;
add(scale(1cm/factor)*tView, (xShift, 0));

draw((z_det, h_det_end)--(xShift, h_det_end), dotted);
draw((z_det, -h_det_end)--(xShift, -h_det_end), dotted);

label("\vbox{\hsize15mm\noindent\SmallerFonts $10\si$ beam envelope}", (xShift, 0), W*3, lightred);

label("top pot", (xShift + 1, +2.5), E);
label("bottom pot", (xShift + 1, -2.5), E);

draw((xShift + 1, 0)--(xShift + 0.5, 0.35), EndArrow(3));
draw((xShift + 1, 0)--(xShift + 0.5, -0.35), EndArrow(3));
label("critical edges", (xShift + 1, 0), E);

texpreamble("\font\TitleFont = cs-qplb-sc at 15pt");
label("\TitleFont Side view", (4, 4));
label("\TitleFont View along beam", (xShift, 4));
label("\SmallerFonts (with elastic scattering hits)", (xShift, 4), S*2.3);

shipout(bbox(1mm, Fill(white)));

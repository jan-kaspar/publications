import graph;

StdFonts();

//----------------------------------------------------------------------------------------------------

path pomeron(path p, real amp = 0.1, real width=0.1)
{
  real pathlen = arclength(p);
  int ncurls = floor(pathlen/width);
  real firstlen = (pathlen - width*ncurls)/2;
  real firstt = arctime(p, firstlen+width);
  guide g =   point(p, 0){unit(point(p, firstt)-point(p, 0))};

  real t;
  pair v;
  pathlen -= firstlen;
  for(real len = firstlen+width; len < pathlen; len += width) {
    t = arctime(p, len);
    v = dir(p, t);

    g=g--(point(p, t)+amp*unit(rotate(90)*v));
    amp = -amp;
  }
  g = g--point(p, size(p));
  return g;
}

void drawPomeron(path p)
{
	draw(pomeron(p));
}

//----------------------------------------------------------------------------------------------------

real w = 3, h = 3, h2 = 2;

pair vu = (0, h2/2);
pair vd = (0, -h2/2);

pair pul = (-w/2, +h/2);
pair pdl = (-w/2, -h/2);
pair pur = (+w/2, +h/2);
pair pdr = (+w/2, -h/2);

pair ep = (0, h/24);

//----------------------------------------------------------------------------------------------------


picture g1 = new picture;
currentpicture = g1;
unitsize(1cm);
draw(pul--vu, MidArrow);
draw(vu--pur, MidArrow);
draw(pdl--vd, MidArrow);
draw(vd--pdr, MidArrow);
dot(vu);
dot(vd);
drawPomeron(vu--vd);

picture g2 = new picture;
currentpicture = g2;
unitsize(1cm);
draw(pul--vu, MidArrow);
draw(vu--pur, MidArrow);
draw(pdl--vd, MidArrow);
draw(vd--pdr, MidArrow);
draw(vd--(pdr+ep), MidArrow);
draw(vd--pdr, MidArrow);
draw(vd--(pdr-ep), MidArrow);
dot(vu);
dot(vd);
drawPomeron(vu--vd);

picture g3 = new picture;
currentpicture = g3;
unitsize(1cm);
draw(pul--vu, MidArrow);
draw(vu--(pur-ep), MidArrow);
draw(vu--pur, MidArrow);
draw(vu--(pur+ep), MidArrow);
draw(pdl--vd, MidArrow);
draw(vd--(pdr+ep), MidArrow);
draw(vd--pdr, MidArrow);
draw(vd--(pdr-ep), MidArrow);
dot(vu);
dot(vd);
drawPomeron(vu--vd);

picture g4 = new picture;
currentpicture = g4;
unitsize(1cm);
dot(vu);
dot(vd);
dot((vu+vd)/2);
drawPomeron(vu--(vu+vd)/2);
drawPomeron((vu+vd)/2--vd);
draw(pul--vu, MidArrow);
draw(vu--pur, MidArrow);
draw(pdl--vd, MidArrow);
draw(vd--pdr, MidArrow);
draw((vu+vd)/2--((vu+vd)/2 + (w/2, 0) + ep), MidArrow);
draw((vu+vd)/2--((vu+vd)/2 + (w/2, 0)), MidArrow);
draw((vu+vd)/2--((vu+vd)/2 + (w/2, 0) - ep), MidArrow);

picture g5 = new picture;
currentpicture = g5;
unitsize(1cm);
draw(pul--vu, MidArrow);
draw(vu--pur, MidArrow);
draw(pdl--vd, MidArrow);
draw(vd--pdr, MidArrow);
draw((0, +h2/2*0.6)--(w/2, +h/2*0.6), MidArrow);
draw((0, +h2/2*0.3)--(w/2, +h/2*0.3), MidArrow);
draw((0, +h2/2*0.0)--(w/2, +h/2*0.0), MidArrow);
draw((0, -h2/2*0.3)--(w/2, -h/2*0.3), MidArrow);
draw((0, -h2/2*0.6)--(w/2, -h/2*0.6), MidArrow);
dot(vu);
dot(vd);
filldraw(ellipse((0, 0), w/6, h/2), white, black);

//----------------------------------------------------------------------------------------------------

picture InitBox()
{
	currentpicture = new picture;
	size(2*w*1cm, h*1cm, IgnoreAspect);
	xlimits(-10, 10);
	ylimits(-3.14, 3.14);
	xaxis(Label("$\eta$", 1), BottomTop, NoTicks);
	yaxis(Label("$\ph$", 1), LeftRight, NoTicks);
	return currentpicture;
}

picture b1 = InitBox();
pair el_dot = (9, 2);
dot(el_dot);
dot(-el_dot);

picture b2 = InitBox();
dot(el_dot);
dot(-el_dot + (-0.3, 0));
dot(-el_dot + (0.2, 0.3));
dot(-el_dot + (0.2, -0.3));

picture b3 = InitBox();
dot(-el_dot + (-0.3, 0));
dot(-el_dot + (0.2, 0.3));
dot(-el_dot + (0.2, -0.3));

dot(el_dot + (0, -0.3));
dot(el_dot + (0.3, 0.2));
dot(el_dot + (-0.3, 0.2));

picture b4 = InitBox();
dot(el_dot);
dot(-el_dot);
dot((0.7, -0.8));
dot((0.6, 0.2));
dot((-0.5, -2.2));
dot((-1.5, 1.2));

picture b5 = InitBox();
dot((0.7, -0.8));
dot((0.6, 0.2));
dot((-0.5, -2.2));
dot((-1.5, 1.2));

dot((1.3, -0.4));
dot((-1, -0.6));
dot((-0.7, 0.3));
dot((-1.1, 0.5));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;

real hgap = 1cm;
real vgap = 2cm;
real v_pos = 0;

void AddPics(picture g, picture b, string s)
{
	picture lab;
	pen lp = font("pplr8z", 20);
	label(lab, s, lp);

	frame f1 = g.fit();
	frame f2 = b.fit();
	add(currentpicture, lab.fit(), position=(0, v_pos + 3mm), align=NE);
	add(currentpicture, f1, position=(0, v_pos), align=SW);
	add(currentpicture, f2, position=(hgap, v_pos), align=SE);
	v_pos -= h*cm + vgap;
}

AddPics(g1, b1, "Elastic scattering");
AddPics(g2, b2, "Single diffraction");
AddPics(g3, b3, "Double diffraction");
AddPics(g4, b4, "Central diffration");
AddPics(g5, b5, "Non-diffractive event");

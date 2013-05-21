real max_z = 5;
real st_z = 3;
real pot_d = 0.3, pot_y = 0.2, pot_s = 0.3;
pen pot_p = black+5pt;

real cms_z = -0.3, cms_w = 0.6, cms_h = 0.3, cms_y = 0.7;
real t1_z = 0.35, t1_w = 0.5, t1_y = 0.4, t1_hn = 0.15, t1_hf = 0.25;
real t2_z = 0.9, t2_w = 0.5, t2_h = 0.15, t2_y = 0.35;

void Template(real lab_y = 0.4)
{
	draw((-max_z, 0)--(max_z, 0));
	
	// RPs
	draw((-st_z - 0*pot_d, pot_y)--(-st_z - 0*pot_d, pot_y+pot_s), pot_p);
	draw((-st_z - 0*pot_d, -pot_y)--(-st_z - 0*pot_d, -pot_y-pot_s), pot_p);
	//draw((-st_z - 1*pot_d, -pot_s/2)--(-st_z - 1*pot_d, +pot_s/2), pot_p);
	//draw((-st_z - 3*pot_d, -pot_s/2)--(-st_z - 3*pot_d, +pot_s/2), pot_p);
	draw((-st_z - 4*pot_d, pot_y)--(-st_z - 4*pot_d, pot_y+pot_s), pot_p);
	draw((-st_z - 4*pot_d, -pot_y)--(-st_z - 4*pot_d, -pot_y-pot_s), pot_p);
	
	draw((st_z + 0*pot_d, pot_y)--(st_z + 0*pot_d, pot_y+pot_s), pot_p);
	draw((st_z + 0*pot_d, -pot_y)--(st_z + 0*pot_d, -pot_y-pot_s), pot_p);
	//draw((st_z + 1*pot_d, -pot_s/2)--(st_z + 1*pot_d, +pot_s/2), pot_p);
	//draw((st_z + 3*pot_d, -pot_s/2)--(st_z + 3*pot_d, +pot_s/2), pot_p);
	draw((st_z + 4*pot_d, pot_y)--(st_z + 4*pot_d, pot_y+pot_s), pot_p);
	draw((st_z + 4*pot_d, -pot_y)--(st_z + 4*pot_d, -pot_y-pot_s), pot_p);
	
	label("RP", (-st_z-2*pot_d, 3*lab_y));
	label("RP", (+st_z+2*pot_d, 3*lab_y));

	// CMS
	filldraw(shift(0, cms_y)*((cms_z, -cms_h/2)--(cms_z+cms_w, -cms_h/2)--(cms_z+cms_w, +cms_h/2)--(cms_z, +cms_h/2))--cycle, lightgray);
	filldraw(shift(0, -cms_y)*((cms_z, -cms_h/2)--(cms_z+cms_w, -cms_h/2)--(cms_z+cms_w, +cms_h/2)--(cms_z, +cms_h/2))--cycle, lightgray);
	label("CMS", (0, 3*lab_y), gray);

	// T1
	filldraw((t1_z, t1_y)--(t1_z+t1_w, t1_y)--(t1_z+t1_w, t1_y+t1_hf)--(t1_z, t1_y+t1_hn)--cycle, palegreen);
	filldraw((-t1_z, t1_y)--(-t1_z-t1_w, t1_y)--(-t1_z-t1_w, t1_y+t1_hf)--(-t1_z, t1_y+t1_hn)--cycle, palegreen);
	filldraw((t1_z, -t1_y)--(t1_z+t1_w, -t1_y)--(t1_z+t1_w, -t1_y-t1_hf)--(t1_z, -t1_y-t1_hn)--cycle, palegreen);
	filldraw((-t1_z, -t1_y)--(-t1_z-t1_w, -t1_y)--(-t1_z-t1_w, -t1_y-t1_hf)--(-t1_z, -t1_y-t1_hn)--cycle, palegreen);

	label("T1", (-t1_z-t1_w/2, 3*lab_y), heavygreen);
	label("T1", (+t1_z+t1_w/2, 3*lab_y), heavygreen);
	
	// T2
	filldraw(shift(0, t2_y)*((t2_z, -t2_h/2)--(t2_z+t2_w, -t2_h/2)--(t2_z+t2_w, +t2_h/2)--(t2_z, +t2_h/2))--cycle, paleblue);
	filldraw(shift(0, -t2_y)*((t2_z, -t2_h/2)--(t2_z+t2_w, -t2_h/2)--(t2_z+t2_w, +t2_h/2)--(t2_z, +t2_h/2))--cycle, paleblue);
	filldraw(shift(0, t2_y)*((-t2_z, -t2_h/2)--(-t2_z-t2_w, -t2_h/2)--(-t2_z-t2_w, +t2_h/2)--(-t2_z, +t2_h/2))--cycle, paleblue);
	filldraw(shift(0, -t2_y)*((-t2_z, -t2_h/2)--(-t2_z-t2_w, -t2_h/2)--(-t2_z-t2_w, +t2_h/2)--(-t2_z, +t2_h/2))--cycle, paleblue);
	
	label("T2", (-t2_z-t2_w/2, 3*lab_y), blue);
	label("T2", (+t2_z+t2_w/2, 3*lab_y), blue);

	/*
	draw((t2_z, -t2_y)--(t2_z, +t2_y), dotted);
	draw((t2_z+t2_w, -t2_y)--(t2_z+t2_w, +t2_y), dotted);
	draw((-t2_z, -t2_y)--(-t2_z, +t2_y), dotted);
	draw((-t2_z-t2_w, -t2_y)--(-t2_z-t2_w, +t2_y), dotted);
	*/
	
	/*
	label("IP", (0, 5*lab_y));
	
	label("sector 45", (-(st_z+t2_z+2*pot_d+t2_w/2)/2, 5*lab_y));
	label("sector 56", (+(st_z+t2_z+2*pot_d+t2_w/2)/2, 5*lab_y));
	*/
	
	filldraw(scale(0.05)*unitcircle, black);
}

//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 15, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
draw((0, 0)--(max_z*(-Cos(angle), -Sin(angle))), red, EndArrow);
shipout("topology_es", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 162, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
shipout("topology_sd_T2_opp", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 135, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
shipout("topology_sd_T1_opp", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 135, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
draw((0, 0)--(max_z*(-Cos(angle), Sin(angle))), dashed+red, EndArrow);
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
shipout("topology_sd_T1_opp_bckg", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 35, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
shipout("topology_sd_T1_same", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template(0.48);
real angle = 185, dangle = 15, r = 1.2;
draw((0, 0)--(max_z*(Cos(angle), Sin(angle))), red, EndArrow);
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
shipout("topology_sd_T2_same", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template();
real angle = 185, dangle = 140, r = 1.5;
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
filldraw((0, 0)--arc((0, 0), r, 205, 160, false)--cycle, red+opacity(0.4), red);
shipout("topology_dd", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template();
real angle = 180, dangle = 157, r = 2;
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
label(rotate(180-dangle)*Label("$\et_{\rm min}$"), rotate(180-dangle)*(r, 0), N, red);

real angle = 0, dangle = 165;
filldraw((0, 0)--arc((0, 0), r, angle - dangle, angle + dangle, false)--cycle, red+opacity(0.4), red);
label(rotate(dangle+180)*Label("$\et_{\rm min}$"), rotate(dangle)*(r, 0), N, red);

shipout("topology_dd_lab", bbox(1mm, Fill(white)));


//--------------------
currentpicture = new picture;
unitsize(1.3cm);
Template();
real angle1 = 183, angle2 = 7, r = 1.;
draw((0, 0)--(max_z*(Cos(angle1), Sin(angle1))), red, EndArrow);
draw((0, 0)--(max_z*(Cos(angle2), Sin(angle2))), red, EndArrow);

filldraw((0, 0)--arc((0, 0), r, +100, 83, false)--cycle, red+opacity(0.4), red);
filldraw((0, 0)--arc((0, 0), r, 285, 265, false)--cycle, red+opacity(0.4), red);

shipout("topology_cd", bbox(1mm, Fill(white)));

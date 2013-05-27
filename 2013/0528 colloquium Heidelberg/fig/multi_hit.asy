
//----------------------------------------------------------------------------------------------------

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 11;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path det_shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
det_shape = scale(10) * rotate(45) * det_shape;

path hor_det_shape = shift(0, -cutEdge/sqrt(2)*10) * det_shape;

//----------------------------------------------------------------------------------------------------

pair d;
real r = 40;
dotfactor = 10;

pair hits[];
hits.push((-5, 40));
hits.push((+3, 15));

//----------------------------------------------------------------------------------------------------

picture p1 = new picture;
currentpicture = p1;
unitsize(1mm);

for (int hi : hits.keys) {
	pair h = hits[hi];
	dot(h, black);
}

clip(det_shape);
draw(det_shape);

//----------------------------------------------------------------------------------------------------

picture p2 = new picture;
currentpicture = p2;
unitsize(1mm);

for (int hi : hits.keys) {
	pair h = hits[hi];
	d = rotate(45)*(r, 0); draw((h-d)--(h+d), red);
	d = rotate(-45)*(r, 0); draw((h-d)--(h+d), blue);
	//dot(h, black);
}

clip(det_shape);
draw(det_shape);

//----------------------------------------------------------------------------------------------------

picture p3 = new picture;
currentpicture = p3;
unitsize(1mm);

for (int hi : hits.keys) {
	pair h = hits[hi];
	d = rotate(45)*(r, 0); draw((h-d)--(h+d), red);
	d = rotate(-45)*(r, 0); draw((h-d)--(h+d), blue);
	d = rotate(90)*(r, 0); draw((h-d)--(h+d), heavygreen);
	//dot(h, black);
}

clip(det_shape);
draw(det_shape);

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(0.5mm);

add(shift(0, 0) * p1);
add(shift(70, 0) * p2);
add(shift(140, 0) * p3);

shipout(bbox(1mm, nullpen, Fill(white)));

import pad_layout;
import root;

dotfactor = 10;

pen markupColor = paleyellow;

	ResetPads();
	
	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("V detectors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	
	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("U detectors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	NewRow();

	pad pShRV = NewPad("detector number", "shift in $v\quad(\rm\mu m)$");
	pad pShRU = NewPad("detector number", "shift in $u\quad(\rm\mu m)$");
	NewRow();
	pad pRotZV = NewPad("detector number", "rotation around $z\quad(\rm mrad)$");
	pad pRotZU = NewPad("detector number", "rotation around $z\quad(\rm mrad)$");

	string filename = "results_Jan.xml";
	write(filename);

	file f = input(filename);
	while (!eof(f)) {
		string line = f;
		string[] bits = split(line, "\"");
		//write(line);

		int id = -1;
		real sh_r = 0, sh_r_e = 0, rot_z = 0, rot_z_e = 0;

		for (int j = 0; j < bits.length; ++j) {
			//write("> ", bits[j]);
			if (find(bits[j], "id=") >= 0) id = (int) bits[++j];
			if (find(bits[j], "sh_r=") >= 0) sh_r = (real) bits[++j];
			if (find(bits[j], "sh_r_e=") >= 0) sh_r_e = (real) bits[++j];
			if (find(bits[j], "rot_z=") >= 0) rot_z = (real) bits[++j];
			if (find(bits[j], "rot_z_e=") >= 0) rot_z_e = (real) bits[++j];
		}
	
		if (id < 0)
			continue;
	
		int det = id % 10;

		SetPad((det % 2 == 0) ? pShRV : pShRU);
		dot((det, sh_r), blue);
		draw((det, sh_r)--(det, sh_r + sh_r_e), blue, EndBar);
		draw((det, sh_r)--(det, sh_r - sh_r_e), blue, EndBar);

		SetPad((det % 2 == 0) ? pRotZV : pRotZU);
		dot((det, rot_z), blue);
		draw((det, rot_z)--(det, rot_z + rot_z_e), blue, EndBar);
		draw((det, rot_z)--(det, rot_z - rot_z_e), blue, EndBar);
	}

	string filename = "results_Ideal.xml";
	write(filename);

	file f = input(filename);
	while (!eof(f)) {
		string line = f;
		string[] bits = split(line, "\"");
		//write(line);

		int id = -1;
		real sh_r = 0, sh_r_e = 0, rot_z = 0, rot_z_e = 0;

		for (int j = 0; j < bits.length; ++j) {
			//write("> ", bits[j]);
			if (find(bits[j], "id=") >= 0) id = (int) bits[++j];
			if (find(bits[j], "sh_r=") >= 0) sh_r = (real) bits[++j];
			if (find(bits[j], "sh_r_e=") >= 0) sh_r_e = (real) bits[++j];
			if (find(bits[j], "rot_z=") >= 0) rot_z = (real) bits[++j];
			if (find(bits[j], "rot_z_e=") >= 0) rot_z_e = (real) bits[++j];
		}
	
		if (id < 0)
			continue;
	
		int det = id % 10;

		sh_r = -sh_r;
		sh_r_e = 5.;

		rot_z_e = 0.5;

		SetPad((det % 2 == 0) ? pShRV : pShRU);
		dot((det, sh_r), red);
		draw((det, sh_r)--(det, sh_r + sh_r_e), red, EndBar);
		draw((det, sh_r)--(det, sh_r - sh_r_e), red, EndBar);

		SetPad((det % 2 == 0) ? pRotZV : pRotZU);
		dot((det, rot_z), red);
		draw((det, rot_z)--(det, rot_z + rot_z_e), red, EndBar);
		draw((det, rot_z)--(det, rot_z - rot_z_e), red, EndBar);
	}

	SetPad(pShRV);
	xlimits(-0.5, 9.5);
	ylimits(-20, +40);

	SetPad(pShRU);
	xlimits(-0.5, 9.5);
	ylimits(-20, +40);

	SetPad(pRotZV);
	xlimits(-0.5, 9.5);
	ylimits(-1, +2);

	SetPad(pRotZU);
	xlimits(-0.5, 9.5);
	ylimits(-1, +2);

//----------------------------------------------------------------------------------------------------

NewPad(false, autoSize = false, 2, 1);

unitsize(1cm);

real x = -5;
real y = 0, y_e = 0.5;

dot((x, y), red);
draw((x, y)--(x, y + y_e), red, EndBar);
draw((x, y)--(x, y - y_e), red, EndBar);
label("\vbox{\hsize6cm\noindent optical alignment performed\hfil\break during package assembly}", (x, y), E*5);

y = 2;
dot((x, y), blue);
draw((x, y)--(x, y + y_e), blue, EndBar);
draw((x, y)--(x, y - y_e), blue, EndBar);
label("\vbox{\hsize7cm\noindent track-based alignment applied on\hfil\break beam-test data}", (x, y), E*5);

//----------------------------------------------------------------------------------------------------

NewPad(false, 7.5cm, 2, 2);

import three;
import math;

currentprojection = orthographic((-1.0, -0.4, 4), (0, 1, 0));

// basic shape
real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);
real cE2 = 2.22721 / 2;

path3 DetShape = (cutEdge, 0, 0)--(edge, 0, 0)--(edge, edge, 0)--(0, edge, 0)--(0, cutEdge, 0)--cycle;

// add strips
int nStrips = 23;
real margin = 0.1;

// strips
real delta = (edge - 2 * margin) / (nStrips - 1);
path3 strips[];
for (int i = 0; i < nStrips; ++i) {
	real y = margin + i*delta;
	real x0 = margin;
	if (y < cutEdge) x0 = cutEdge - y;
	path3 strip = (x0, y, 0)--(edge-margin, y, 0);
	strips.push( strip );
}


void DrawDet(transform3 align, string L)
{
	draw(surface(align * DetShape), white, nolight);
	draw(align * DetShape, black+2);
	for (int i = 0; i < strips.length; ++i) {
		draw(align * strips[i], gray);
	}

	real aLen = 4;
	draw(align * ((edge/2, edge/2, 0)--(edge/2, edge/2+aLen, 0)), EndArrow3);
	label(L, align * (edge/2, edge/2+aLen * 1.08, 0));
}


real d = 3;

DrawDet(shift(0, 0, 3*d) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "$U$");
DrawDet(shift(0, 0, 2*d) * rotate(45, (0, 0, 1)), "$V$");
DrawDet(shift(0, 0, 1*d) * rotate(180, (0, 1, 0)) * rotate(45, (0, 0, 1)), "$U$");
DrawDet(shift(0, 0, 0*d) * rotate(45, (0, 0, 1)), "$V$");

//----------------------------------------------------------------------------------------------------

GShipout(W);

import flowchart;

StdFonts();

unitsize(1cm);

real m = 0.05;
real dy = -1.35, dx = 5.6; 

real y0 = 0;
real y1 = y0 + dy;
real y2 = y1 + dy;
real y3 = y2 + dy - 0.4;
real y4 = y3 + dy + 0.1;
real y5 = y4 + dy + 0.05;
real y6 = y5 + dy + 0.2;
real y7 = y6 + dy;
real y8 = y7 + dy - 0.16;
real y9 = y8 + dy - 0.1;

//----------------------------------------------------------------------------------------------------

void DrawBox(real x1, real x2, real y1, real y2, string s, pen pf, pen pb, pair labP=(0, 0))
{
	filldraw((x1*dx+m, y1-m)--(x1*dx+m, y2+m)--(x2*dx-m, y2+m)--(x2*dx-m, y1-m)--cycle, pf, pb);

	if (labP == (0, 0))
		labP = (x2*dx, y1);
	label(rotate(90)*Label(s), labP, 1.3*SW, pb);
}

DrawBox(-0.35, 0.35, y0+0.5, y4, "simulation", palegreen, darkgreen);
DrawBox(-0.35, 0.35, y4, y9-0.9, "reconstruction", paleblue, darkblue, (0.35dx, y6));
DrawBox(-1.35, -0.35, y4+0.9, y9-0.9, "alignment", palered, darkred, (-1.35dx+0.6, y6));
DrawBox(0.35, 1.05, y2+0.5, y4, "raw-data", paleyellow, olive);
DrawBox(0.35, 1.05, y4, y5-1, "trigger", palegray, black);

DrawBox(1.15, 1.25, y0+0.5, y9-0.9, "data quality monitor", white, black, (1.25dx, y3));

//----------------------------------------------------------------------------------------------------

block [] blocks;

void DataBlk(string label, pair p)
{
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b = bevel(/*string(blocks.length)+": "+*/ label, p, white);
	blocks.push(b);
}

void AlgBlk(string label, pair p)
{
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b = rectangle(/*string(blocks.length)+": "+*/ label, p, white);
	blocks.push(b);
}


AlgBlk("event generator", (0dx, y0));
AlgBlk("beam smearing", (0dx, y1));
AlgBlk("Geant4 + proton\cr transport", (0dx, y2));
AlgBlk("sensor response\cr and electronics\cr simulation", (0dx, y3));

DataBlk("DIGI", (0.35dx, y4));

DataBlk("raw data", (0.7dx, y2));
AlgBlk("raw-data\cr validation", (0.7dx, y3));

AlgBlk("clusterization", (0dx, y5));
DataBlk("RECO", (0dx, y6));
AlgBlk("pattern\cr recognition", (0dx, y7));
AlgBlk("one-RP track\cr fit", (0dx, y8));
AlgBlk("physics\cr reconstruction", (0dx, y9));

AlgBlk("trigger\cr analyses", (0.7dx, y5));

AlgBlk("fast\cr simulation", (-0.6dx, y4));
AlgBlk("fast station\cr simulation", (-1.1dx, y4));
//DataBlk("true track", (-1.5dx, y6));
AlgBlk("station track\cr fit", (-0.85dx, y8));
AlgBlk("track-based\cr alignment", (-1.1dx, y9));
AlgBlk("profile\cr alignment", (-0.6dx, y9));



for (int i = 0; i < blocks.length; ++i) {
	draw(blocks[i]);
}

//----------------------------------------------------------------------------------------------------

void DrawPath(picture pic, transform t, int i1, int i2)
{
	for (int i = i1; i < i2; ++i) {
		draw(pic, blocks[i].bottom(t)--blocks[i+1].top(t), Arrow);
	}
}


add(new 
	void(picture pic, transform t) {
		DrawPath(pic, t, 0, 3);
		DrawPath(pic, t, 5, 6);
		DrawPath(pic, t, 7, 11);
		DrawPath(pic, t, 15, 16);
		
		draw(pic, blocks[3].bottomright(t)--blocks[4].topleft(t), Arrow);
		draw(pic, blocks[6].bottomleft(t)--blocks[4].topright(t), Arrow);
		draw(pic, blocks[4].bottomleft(t)--blocks[7].top(t), Arrow);
		draw(pic, blocks[4].bottomright(t)--blocks[12].top(t), Arrow);

		draw(pic, blocks[15].bottom(t)--blocks[17].top(t), Arrow);
		
		draw(pic, blocks[1].left(t)..{0, -1}blocks[13].top(t), Arrow);
		
		draw(pic, blocks[13].bottom(t)..{1, -0.1}blocks[8].topleft(t), Arrow);
		draw(pic, blocks[14].bottom(t)..{1, 0}blocks[8].left(t), Arrow);
		
		draw(pic, blocks[9].left(t){-1, 0}..{0, -1}blocks[15].top(t), Arrow);
	}
);


shipout(bbox(1mm, Fill(white)));

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
real y8 = y7 + dy - 0.17;
real y9 = y8 + dy - 0.1;

//----------------------------------------------------------------------------------------------------

void DrawBox(real x1, real x2, real y1, real y2, string s, pen pf, pen pb, pair labP=(0, 0))
{
	filldraw((x1*dx+m, y1-m)--(x1*dx+m, y2+m)--(x2*dx-m, y2+m)--(x2*dx-m, y1-m)--cycle, pf, pb);

	if (labP == (0, 0))
		labP = (x2*dx, y1);
	label(rotate(90)*Label(s), labP, 1.3*SW, pb);
}

DrawBox(-0.5, 0.5, y0+0.5, y4, "simulation", palegreen, darkgreen);
DrawBox(-0.5, 0.5, y4, y9-0.9, "reconstruction", paleblue, darkblue, (0.5dx, y6));
DrawBox(-1.5, -0.5, y4+0.9, y9-0.9, "alignment", palered, darkred, (-1.5dx+0.6, y6));
DrawBox(0.5, 1.3, y2+0.5, y4, "raw-data", paleyellow, olive);
DrawBox(0.5, 1.3, y4, y5-1, "trigger", palegray, black);

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
AlgBlk("smearing", (0dx, y1));
AlgBlk("Geant4 + proton\cr transport", (0dx, y2));
AlgBlk("detector response\cr and electronics\cr simulation", (0dx, y3));

DataBlk("DIGI", (0.5dx, y4));

DataBlk("raw data", (0.9dx, y2));
AlgBlk("raw-data\cr validation", (0.9dx, y3));

AlgBlk("clusterization", (0dx, y5));
DataBlk("RECO", (0dx, y6));
AlgBlk("pattern\cr recognition", (0dx, y7));
AlgBlk("one-RP track\cr fit", (0dx, y8));
AlgBlk("general\cr physics\cr reconstruction", (-0.25dx, y9));
AlgBlk("elastic\cr reconstruction", (0.25dx, y9));

AlgBlk("coincidence-chip\cr and trigger\cr analyses", (0.9dx, y5));


AlgBlk("fast\cr simulation", (-0.75dx, y4));
AlgBlk("fast station\cr simulation", (-1.25dx, y4));
//DataBlk("true track", (-1.5dx, y6));
AlgBlk("station track\cr fit", (-1dx, y8));
AlgBlk("track-based\cr alignment", (-1.25dx, y9));
AlgBlk("profile\cr alignment", (-0.75dx, y9));



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
		DrawPath(pic, t, 16, 17);
		
		draw(pic, blocks[3].bottomright(t)--blocks[4].topleft(t), Arrow);
		draw(pic, blocks[6].bottomleft(t)--blocks[4].topright(t), Arrow);
		draw(pic, blocks[4].bottomleft(t)--blocks[7].top(t), Arrow);
		draw(pic, blocks[4].bottomright(t)--blocks[13].top(t), Arrow);

		draw(pic, blocks[10].bottom(t)--blocks[12].top(t), Arrow);
		draw(pic, blocks[16].bottom(t)--blocks[18].top(t), Arrow);
		
		draw(pic, blocks[1].left(t)..{0, -1}blocks[14].top(t), Arrow);
		
		draw(pic, blocks[14].bottom(t)..{1, -0.1}blocks[8].topleft(t), Arrow);
		draw(pic, blocks[15].bottom(t)..{1, 0}blocks[8].left(t), Arrow);
		
		draw(pic, blocks[9].left(t){-1, 0}..{0, -1}blocks[16].top(t), Arrow);

/*
		draw(pic, blocks[0].top(t)--blocks[1].bottom(t), Arrow);
		draw(pic, blocks[1].right(t)--blocks[2].left(t), Arrow);
		draw(pic, blocks[2].right(t)--blocks[3].left(t), Arrow);
		//draw(pic, path(new pair[]{blocks[2].bottom(t), ((blocks[2].bottom(t) + blocks[3].top(t))/2)}, Vertical));
		//draw(pic, path(new pair[]{((blocks[2].bottom(t) + blocks[3].top(t))/2), blocks[3].top(t)}, Horizontal), Arrow);
		draw(pic, blocks[3].bottom(t)--blocks[4].top(t), Arrow);
		draw(pic, blocks[4].bottom(t)--blocks[5].topleft(t), Arrow);

		draw(pic, blocks[6].right(t)--blocks[8].topleft(t), Arrow);
		draw(pic, blocks[7].right(t)--blocks[8].bottomleft(t), Arrow);
		draw(pic, blocks[8].right(t)--blocks[5].bottomleft(t), Arrow);

		draw(pic, blocks[5].topright(t)--blocks[9].bottomleft(t), Arrow);
		draw(pic, blocks[9].top(t)--blocks[10].bottom(t), Arrow);
		draw(pic, blocks[10].right(t)--blocks[11].left(t), Arrow);
		draw(pic, blocks[11].bottom(t)--blocks[12].top(t), Arrow);

		draw(pic, blocks[5].bottomright(t)--blocks[13].top(t), Arrow);
		draw(pic, blocks[13].right(t)--blocks[14].left(t), Arrow);

		draw(pic, blocks[17].right(t)--blocks[18].left(t), Arrow);
		draw(pic, blocks[18].right(t)--blocks[19].left(t), Arrow);

		draw(pic, blocks[20].right(t)--blocks[21].topleft(t), Arrow);
		draw(pic, blocks[21].bottomleft(t)--blocks[22].right(t), Arrow);

		draw(pic, blocks[22].bottom(t)--blocks[10].topright(t), Arrow);
		draw(pic, blocks[22].bottom(t)--blocks[11].top(t), Arrow);
		draw(pic, blocks[22].bottom(t)--blocks[3].topright(t), Arrow);

		draw(pic, blocks[11].topright(t)..t*(17, 7)..blocks[21].right(t), Arrow);
		draw(pic, blocks[12].topright(t)..t*(17.3, 7)..blocks[21].right(t), Arrow);

		draw(pic, blocks[19].right(t){1, 1}..tension 1 ..t*(15, 10)..tension 1 ..t*(18, 5)..tension 1 ..blocks[12].right(t), Arrow);
		draw(pic, blocks[19].bottom(t)--blocks[2].top(t), Arrow);
		draw(pic, blocks[20].bottomleft(t)--blocks[2].top(t), Arrow);

		draw(pic, t*(0, -5){0, -1}..{1, 0}t*(1, -6), MidArrow);
		draw(pic, t*(4, -5){0, -1}..{1, 0}t*(5, -6), MidArrow);
		draw(pic, t*(8, -5){0, -1}..{1, 0}t*(9, -6), MidArrow);
		draw(pic, t*(12, -5){0, -1}..{1, 0}t*(13, -6), MidArrow);
		draw(pic, t*(16, -5){0, -1}..{1, 0}t*(17, -6), MidArrow);
		draw(pic, t*(1, -6)--t*(17, -6));
		draw(pic, t*(17, -6)--blocks[15].left(t), Arrow);
		draw(pic, t*(17, -6)--blocks[16].left(t), Arrow);
*/
	}
);


shipout(bbox(1mm, Fill(white)));

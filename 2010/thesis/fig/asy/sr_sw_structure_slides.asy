import flowchart;

StdFonts();


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
	filldraw((x1*dx+m, y1-m)--(x1*dx+m, y2+m)--(x2*dx-m, y2+m)--(x2*dx-m, y1-m)--cycle, pf, black);

	if (labP == (0, 0))
		labP = (x2*dx, y1);
	label(rotate(90)*Label(s), labP, 1.3*SW, pb);
}

//----------------------------------------------------------------------------------------------------

block [] blocks;

void DataBlk(string label, pair p, int idx=-1)
{
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b = bevel(/*string(blocks.length)+": "+*/ label, p, white);

	if (idx < 0)
		blocks.push(b);
	else
		blocks[idx] = b;
}

int fOther = 0, fMine = 1, fHighlight = 2;

void AlgBlk(string label, pair p, int idx=-1, int flag = fOther)
{
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b;
	if (flag == fOther)
		b = rectangle(/*string(blocks.length)+": "+*/ Label(label, black), p, white);
	if (flag == fMine)
		b = rectangle(/*string(blocks.length)+": "+*/ Label(label, white), p, heavyred);
	if (flag == fHighlight)
		b = rectangle(/*string(blocks.length)+": "+*/ Label(label, white), p, blue);
	
	if (idx < 0)
		blocks.push(b);
	else
		blocks[idx] = b;
}

//----------------------------------------------------------------------------------------------------

void DrawBoxes()
{
	DrawBox(-0.35, 0.35, y0+0.5, y4, "simulation", paleyellow, black);
	DrawBox(-0.35, 0.35, y4, y9-0.9, "reconstruction", paleyellow, black, (0.35dx, y6));
	DrawBox(-1.35, -0.35, y4+0.9, y9-0.9, "alignment", palered, black, (-1.35dx+0.6, y6));
	DrawBox(0.35, 1.05, y2+0.5, y4, "raw-data", paleyellow, black);
	DrawBox(0.35, 1.05, y4, y5-1, "trigger", paleyellow, black);
	DrawBox(1.15, 1.25, y0+0.5, y9-0.9, "data quality monitor", heavyred, white, (1.25dx, y3));
}

//----------------------------------------------------------------------------------------------------

void DrawBaseBlocks() {
	AlgBlk("Geant4 + proton\cr transport", (0dx, y2), 2);
	AlgBlk("sensor response\cr and electronics\cr simulation", (0dx, y3), 3);
	DataBlk("DIGI", (0.35dx, y4), 4);
	DataBlk("raw data", (0.7dx, y2), 5);
	AlgBlk("clusterization", (0dx, y5), 7);
	DataBlk("RECO", (0dx, y6), 8);
	AlgBlk("one-RP track\cr fit", (0dx, y8), 10);
	AlgBlk("physics\cr reconstruction", (0dx, y9), 11);
	AlgBlk("trigger\cr analysis", (0.7dx, y5), 12);
	//DataBlk("true track", (-1.5dx, y6));
	AlgBlk("station track\cr fit", (-0.85dx, y8), 15, fMine);
	AlgBlk("track-based\cr alignment", (-1.1dx, y9), 16, fMine);
	AlgBlk("profile\cr alignment", (-0.6dx, y9), 17, fMine);
}


//----------------------------------------------------------------------------------------------------

real as = 6;

void DrawPath(picture pic, transform t, int i1, int i2)
{
	for (int i = i1; i < i2; ++i) {
		draw(pic, blocks[i].bottom(t)--blocks[i+1].top(t), Arrow(as));
	}
}

void DrawArrows() {
	add(new 
		void(picture pic, transform t) {
			DrawPath(pic, t, 0, 3);
			DrawPath(pic, t, 5, 6);
			DrawPath(pic, t, 7, 11);
			DrawPath(pic, t, 15, 16);
			
			draw(pic, blocks[3].bottom(t)--blocks[4].topleft(t), Arrow(as));
			draw(pic, blocks[6].bottom(t)--blocks[4].topright(t), Arrow(as));
			draw(pic, blocks[4].bottomleft(t)--blocks[7].top(t), Arrow(as));
			draw(pic, blocks[4].bottomright(t)--blocks[12].top(t), Arrow(as));
	
			draw(pic, blocks[15].bottom(t)--blocks[17].top(t), Arrow(as));
			
			draw(pic, blocks[1].left(t)..{0, -1}blocks[13].top(t), Arrow(as));
			
			draw(pic, blocks[13].bottom(t)..{1, -0.1}blocks[8].topleft(t), Arrow(as));
			draw(pic, blocks[14].bottom(t)..{1, 0}blocks[8].left(t), Arrow(as));
			
			draw(pic, blocks[9].left(t){-1, 0}..{0, -1}blocks[15].top(t), Arrow(as));
		}
	);
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

blocks.delete();

DrawBoxes();
DrawBaseBlocks();

AlgBlk("event generator", (0dx, y0), 0, fMine);
AlgBlk("beam smearing", (0dx, y1), 1, fMine);
AlgBlk("raw-data\cr validation", (0.7dx, y3), 6, fMine);
AlgBlk("pattern\cr recognition", (0dx, y7), 9, fMine);
AlgBlk("fast\cr simulation", (-0.6dx, y4), 13, fMine);
AlgBlk("fast station\cr simulation", (-1.1dx, y4), 14, fMine);

for (int bi : blocks.keys)
	draw(blocks[bi]);

DrawArrows();

shipout("sr_sw_structure_slides", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

blocks.delete();

DrawBoxes();
DrawBaseBlocks();

AlgBlk("event generator", (0dx, y0), 0, fHighlight);
AlgBlk("beam smearing", (0dx, y1), 1, fMine);
AlgBlk("raw-data\cr validation", (0.7dx, y3), 6, fMine);
AlgBlk("pattern\cr recognition", (0dx, y7), 9, fMine);
AlgBlk("fast\cr simulation", (-0.6dx, y4), 13, fMine);
AlgBlk("fast station\cr simulation", (-1.1dx, y4), 14, fMine);

for (int bi : blocks.keys)
	draw(blocks[bi]);

DrawArrows();

shipout("sr_sw_structure_slides_eg", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

blocks.delete();

DrawBoxes();
DrawBaseBlocks();

AlgBlk("event generator", (0dx, y0), 0, fMine);
AlgBlk("beam smearing", (0dx, y1), 1, fHighlight);
AlgBlk("raw-data\cr validation", (0.7dx, y3), 6, fMine);
AlgBlk("pattern\cr recognition", (0dx, y7), 9, fMine);
AlgBlk("fast\cr simulation", (-0.6dx, y4), 13, fMine);
AlgBlk("fast station\cr simulation", (-1.1dx, y4), 14, fMine);

for (int bi : blocks.keys)
	draw(blocks[bi]);

DrawArrows();

shipout("sr_sw_structure_slides_bs", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

blocks.delete();

DrawBoxes();
DrawBaseBlocks();

AlgBlk("event generator", (0dx, y0), 0, fMine);
AlgBlk("beam smearing", (0dx, y1), 1, fMine);
AlgBlk("raw-data\cr validation", (0.7dx, y3), 6, fMine);
AlgBlk("pattern\cr recognition", (0dx, y7), 9, fMine);
AlgBlk("fast\cr simulation", (-0.6dx, y4), 13, fHighlight);
AlgBlk("fast station\cr simulation", (-1.1dx, y4), 14, fHighlight);

for (int bi : blocks.keys)
	draw(blocks[bi]);

DrawArrows();

shipout("sr_sw_structure_slides_fs", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

blocks.delete();

DrawBoxes();
DrawBaseBlocks();

AlgBlk("event generator", (0dx, y0), 0, fMine);
AlgBlk("beam smearing", (0dx, y1), 1, fMine);
AlgBlk("raw-data\cr validation", (0.7dx, y3), 6, fMine);
AlgBlk("pattern\cr recognition", (0dx, y7), 9, fHighlight);
AlgBlk("fast\cr simulation", (-0.6dx, y4), 13, fMine);
AlgBlk("fast station\cr simulation", (-1.1dx, y4), 14, fMine);

for (int bi : blocks.keys)
	draw(blocks[bi]);

DrawArrows();

shipout("sr_sw_structure_slides_pr", bbox(1mm, Fill(white)));

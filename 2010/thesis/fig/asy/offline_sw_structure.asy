import flowchart;

StdFonts();

// both work
unitsize(1cm);
//size(15cm);

real l = 1.5;


block [] blocks;


void DataBlk(string label, pair p)
{
	//label = "\llap{" + string(blocks.length) + ": }\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b = bevel(label, p, white);
	blocks.push(b);
}

void AlgBlk(string label, pair p)
{
	label = "\vtop{\halign{\hfil#\hfil\cr " + label + "\crcr}}";
	block b = rectangle(label, p, white);
	blocks.push(b);
}

//----------------------------------------------------------------------------------------------------

filldraw((-1, 0.2)--(8.8, 0.2)--(8.8, 6)--(-1, 6)--cycle, palegreen, darkgreen);
filldraw((-1, -0.2)--(8.8, -0.2)--(8.8, -4)--(-1, -4)--cycle, paleblue, darkblue);
filldraw((9.2, 0.2)--(17, 0.2)--(17, 6)--(9.2, 6)--cycle, palered, darkred);
filldraw((9.2, -0.2)--(17, -0.2)--(17, -4)--(9.2, -4)--cycle, paleyellow, olive);

label("simulation chain", (-1, 0.2), NE, darkgreen);
label("real data chain", (8.8, -4), NW, darkblue);
label("trigger chain", (17, -4), NW, olive);
label("reconstruction chain", (17, 0.2), NW, darkred);

//----------------------------------------------------------------------------------------------------


AlgBlk("Monte Carlo\cr generator", (1, 2));
AlgBlk("Smearing", (1, 5));
AlgBlk("Geant4", (4, 5));
AlgBlk("Detector\cr response\cr simulation", (7, 5));
AlgBlk("VFAT simulation", (7, 2));

DataBlk("DIGI", (9, 0));

DataBlk("Experimental\cr data", (1, -1));
DataBlk("Testbeam\cr data", (1, -3));
AlgBlk("Totem Data Reader", (6, -2));

DataBlk("Clusters", (11, 2));
AlgBlk("Pattern\cr recognition", (11, 5));
AlgBlk("Track\cr reconstruction", (15, 5));
AlgBlk("Physics\cr reconstruction\cr and\cr analysis", (15, 2));

AlgBlk("Coincidence\cr chip\cr simulation", (11, -2));
AlgBlk("Trigger\cr simulation", (15, -2));

AlgBlk("Validation\cr suite", (20, -5));
AlgBlk("Data Quality\cr Monitor", (20, -7));

real bx, by;

bx = 0; by = 9;
AlgBlk("MADX", (bx, by));
DataBlk("LHC optics\cr model", (bx+3, by));
DataBlk("Proton\cr transport\cr parameterization", (bx+7, by));

bx = 6; by = 7;
DataBlk("ideal\cr geometry", (bx+6, by+2));
AlgBlk("Alignment", (bx+9, by+1));
DataBlk("real\cr geometry", (bx+6, by));


for (int i = 0; i < blocks.length; ++i) {
	draw(blocks[i]);
}


add(new 
	void(picture pic, transform t) {
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
	}
);


shipout(bbox(5mm, Fill(white)));

StdFonts();

void DrawBox(real x1, real y1, real x2, real y2, pen fg = heavygreen, pen bg = white)
{
	draw((x1, y1)--(x1, y2)--(x2, y2)--(x2, y1)--cycle, bg+2pt);
	draw((x1, y1)--(x1, y2)--(x2, y2)--(x2, y1)--cycle, fg+1pt);
}

void DrawGrid(real x1 = -4, real y1 = -3, real x2 = +4, real y2 = +3, pen fg = red)
{
	for (real x = x1; x <= x2; x += 1) {
		draw((x, y1)--(x, y2), fg);
		label(format("%.0f", x), (x, y1));
	}
	
	for (real y = y1; y <= y2; y += 1) {
		draw((x1, y)--(x2, y), fg);
		label(format("%.0f", y), (x1, y));
	}
}

void Arrow(path p, pen fg=red, pen bg=white)
{
	draw(p, bg+2pt, EndArrow(5));
	draw(p, fg+1pt, EndArrow(5));
}

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_station.jpg}\pdfrefximage\pdflastximage"));

layer();

DrawBox(-0.3, -1.3, -3, 0.5);
DrawBox(0.1, -1.3, 2.6, 0.5);

shipout("rp_station");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_unit.jpg}\pdfrefximage\pdflastximage"));
layer();

//DrawGrid();

Arrow((-2, 1)--(-1.7, 0));
label("horizontal RP", (-1.2, 1), W, red, FillDraw(white+opacity(1)));

Arrow((2.2, 0.9)--(2.1, 0.1));
label("BPM", (2.5, 0.9), red, FillDraw(white+opacity(1)));

Arrow((-0.3, 2.2)--(0.7, 1));
label("top RP", (0, 2.2), W, red, FillDraw(white+opacity(1)));

Arrow((-0.3, -2)--(0.7, -0.8));
label("bottom RP", (0, -2), W, red, FillDraw(white+opacity(1)));

shipout("rp_unit");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_pot.jpg}\pdfrefximage\pdflastximage"));
layer();

//DrawGrid();

Arrow((1.3, 2)--(-0.2, 1.5));
label("thin window", (2.2, 2), red, FillDraw(white+opacity(1)));

shipout("rp_pot");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_package.jpg}\pdfrefximage\pdflastximage"));
layer();

//DrawGrid();

//Arrow((1.3, 2)--(-0.2, 1.5));
//label("thin window", (2.2, 2), red, FillDraw(white+opacity(1)));

shipout("rp_package");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_hybrid.jpg}\pdfrefximage\pdflastximage"));
layer();

//DrawGrid();

Arrow((1, 2.2)--(0.5, 1.9));
Arrow((1.3, 2.2)--(1.1, 1.2));
Arrow((1.8, 2.2)--(1.8, 0.7));
Arrow((2.4, 2.2)--(2.4, 0.1));
label("VFAT chips", (1.9, 2.2), red, FillDraw(white));

shipout("rp_hybrid");

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label(Label("\pdfximage height5cm{../external/rp_blm_bpm.jpg}\pdfrefximage\pdflastximage"));
layer();

//DrawGrid();

Arrow((-1.2, -1.5)--(-0.2, -1.3));
label("BPM", (-1.2, -1.5), red, FillDraw(white+opacity(1)));

Arrow((1, 2)--(0.5, 1.3));
label("BLM", (1, 2), red, FillDraw(white));

shipout("rp_blm_bpm");

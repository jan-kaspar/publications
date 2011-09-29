unitsize(1cm);

//StdFonts();
fonts8();

void DrawGrid(real x1 = -4, real y1 = -3, real x2 = +4, real y2 = +3, pen fg = white+0.2pt)
{
	for (real x = x1; x <= x2; x += 0.5) {
		draw((x, y1)--(x, y2), fg);
		label(format("%.1f", x), (x, y1), orange);
	}
	
	for (real y = y1; y <= y2; y += 0.5) {
		draw((x1, y)--(x2, y), fg);
		label(format("%.1f", y), (x1, y), orange);
	}
}

label(Label("\pdfximage height6cm{../external/lhc.jpg}\pdfrefximage\pdflastximage"));

layer();
//DrawGrid();

label("IP1: ATLAS, LHCf", (2.2, -0.15), 0.5SW, red, Fill(white+opacity(0.8)));
label("IP2: ALICE", (2.85, -1), 0.5W, red, Fill(white+opacity(0.8)));
label("IP3: momentum cleaning", (2.1, -2.1), 0.5NW, red, Fill(white+opacity(0.8)));
label("IP4: RF", (-1.75, -2.3), 0.5SW, red, Fill(white+opacity(0.8)));
label("IP5: CMS, TOTEM", (-2.75, -1), 0.5E, red, Fill(white+opacity(0.8)));
label("IP6: dump", (-1.9, 0.0), 0.5SE, red, Fill(white+opacity(0.8)));
label("IP7: betatron cleaning", (-0.45, 0.5), 0.5NW, red, Fill(white+opacity(0.8)));
label("IP8: LHCb", (0.6, 0.5), 0.5NE, red, Fill(white+opacity(0.8)));

label(rotate(-50)*Label("\SmallerFonts sector 45"), (-2.75, -1.75), yellow);
label(rotate(50)*Label("\SmallerFonts sector 56"), (-2.9, -0.4), yellow);

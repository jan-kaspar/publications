import flowchart;

StdFonts();

unitsize(1cm);



block b_o = rectangle("\strut optics tuning", (5.5, 1.2), white); draw(b_o);

block b_rd = bevel("\strut raw data", (0, 0), white); draw(b_rd);
block b_al = rectangle("\strut alignment", (2.5, 0), white); draw(b_al);
block b_rec = rectangle("\strut reconstruction", (5.5, 0), white); draw(b_rec);
block b_esel = rectangle("\strut event selection", (8.8, 0), white); draw(b_esel);
block b_bs = rectangle("\strut background subtraction", (12.7, 0), white); draw(b_bs);

block b_fva = rectangle("\strut final vertical alignment", (7, -1.2), white); draw(b_fva);

block b_acc = rectangle("\strut acceptance correction", (12.7, -1.2), white); draw(b_acc);

block b_unsm = rectangle("\strut unsmearing", (12.7, -2.4), white); draw(b_unsm);
block b_norm = rectangle("\strut normalization", (9.5, -2.4), white); draw(b_norm);
block b_mrg = rectangle("\strut diaglonals merged", (6, -2.4), white); draw(b_mrg);
block b_dsdt = bevel("\strut $\d\si/\d t$", (3, -2.4), white); draw(b_dsdt);



add(new 
	void(picture pic, transform t) {
		
		draw(pic, b_rd.right(t)--b_al.left(t), Arrow);
		draw(pic, b_al.right(t)--b_rec.left(t), Arrow);
		draw(pic, b_rec.right(t)--b_esel.left(t), Arrow);
		draw(pic, b_esel.right(t)--b_bs.left(t), Arrow);

		draw(pic, b_bs.bottom(t)--b_acc.top(t), Arrow);
		draw(pic, b_acc.bottom(t)--b_unsm.top(t), Arrow);
		draw(pic, b_unsm.left(t)--b_norm.right(t), Arrow);
		draw(pic, b_norm.left(t)--b_mrg.right(t), Arrow);
		draw(pic, b_mrg.left(t)--b_dsdt.right(t), Arrow);
		
		draw(pic, b_o.bottom(t)--b_rec.top(t), Arrow);
		
		draw(pic, b_esel.bottomright(t){0, -1}..{-1, 0}b_fva.right(t), Arrow);
		draw(pic, b_fva.left(t){-1, 0}..{0, 1}b_rec.bottomleft(t), Arrow);
	}
);


shipout(bbox(1mm, Fill(white)));

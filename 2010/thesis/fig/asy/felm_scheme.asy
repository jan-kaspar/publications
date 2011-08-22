import flowchart;

StdFonts();

unitsize(1cm);



block b_o = rectangle("optics tuning", (5.5, 1.2), white); draw(b_o);

block b_rd = rectangle("raw data", (0, 0), white); draw(b_rd);
block b_al = rectangle("alignment", (2.5, 0), white); draw(b_al);
block b_rec = rectangle("reconstruction", (5.5, 0), white); draw(b_rec);
block b_esel = rectangle("event selection", (8.9, 0), white); draw(b_esel);
block b_bs = rectangle("background subtraction", (12.8, 0), white); draw(b_bs);

block b_fva = rectangle("final vertical alignment", (7, -1.2), white); draw(b_fva);

block b_acc = rectangle("acceptance correction", (12.8, -1.2), white); draw(b_acc);

block b_unsm = rectangle("unsmearing", (12.8, -2.4), white); draw(b_unsm);

block b_norm = rectangle("normalization", (9.5, -2.4), white); draw(b_norm);



add(new 
	void(picture pic, transform t) {
		
		draw(pic, b_rd.right(t)--b_al.left(t), Arrow);
		draw(pic, b_al.right(t)--b_rec.left(t), Arrow);
		draw(pic, b_rec.right(t)--b_esel.left(t), Arrow);
		draw(pic, b_esel.right(t)--b_bs.left(t), Arrow);
		draw(pic, b_bs.bottom(t)--b_acc.top(t), Arrow);
		draw(pic, b_acc.bottom(t)--b_unsm.top(t), Arrow);
		draw(pic, b_unsm.left(t)--b_norm.right(t), Arrow);
		
		draw(pic, b_o.bottom(t)--b_rec.top(t), Arrow);
		
		draw(pic, b_esel.bottomright(t){0, -1}..{-1, 0}b_fva.right(t), Arrow);
		draw(pic, b_fva.left(t){-1, 0}..{0, 1}b_rec.bottomleft(t), Arrow);
	}
);


shipout(bbox(1mm, Fill(white)));

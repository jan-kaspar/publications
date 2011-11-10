import root;
import pad_layout;

StdFonts();

string ffs[] = { "Hofstadter", "Borkowski", "Kelly", "Arrington", "Puckett" };

string file = "../elastic/ff_draw.root";

NewPad("$|t|\un{GeV^2}$", "form factor / $F_{\rm d}(t)$", 10cm);
scale(Log, Linear);
for (int fi : ffs.keys) {
	draw(rGetObj(file, ffs[fi]+"/FF_eff_r"), std_pens[fi], ffs[fi]);
	draw(rGetObj(file, ffs[fi]+"/FF_e_r"), std_pens[fi]+dashed);
}

limits((1e-3, -1), (1e2, 5), Crop);
xaxis(YEquals(1, false), black+dotted);

AttachLegend(NW, NW);

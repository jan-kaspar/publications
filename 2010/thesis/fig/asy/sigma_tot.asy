import pad_layout;
import settings;

//StdFonts();
fonts8();

void AddPoint(real E, real si, real err)
{
	draw((log10(E), si), black+1.3pt);
	draw((log10(E), si-err)--(log10(E), si+err), black+0.3pt);
}

picture incp;
label(incp, scale(1, 1.283)*Label("\pdfximage width6cm{../external/cudell,sigma_tot.pdf}\pdfrefximage\pdflastximage"));
pair p = incp.calculateTransform() * truepoint(incp, SW);
frame incF = shift(-p) * incp.fit();

NewPad("$\sqrt s\un{GeV}$", "$\si_{\rm tot}\un{mb}$");
real f[] = {10, 100, 1000, 10000};
real g[] = {1, 1.5, 2, 3, 4, 5, 6, 7, 8, 9};

for (int fi : f.keys)
	for (int gi : g.keys) {
		real x = g[gi] * f[fi];
		draw((log10(x), 30)--(log10(x), 130), (gi == 0) ? blue+0.2pt : blue+0.05pt);
	}

for (int y = 30; y <= 130; y += 2) {
	draw((0, y)--(log10(2e4), y), (y % 10 == 0) ? blue+0.2pt : blue+0.05pt);
}

add(incF, (0.97, 28.9));



/*
// ISR
AddPoint(23.5, 39.1, 0.4);
AddPoint(30.6, 40.5, 0.5);
AddPoint(44.9, 42.5, 0.5);
AddPoint(52.8, 43.2, 0.6);
label(rotate(90)*Label("ISR"), (log10(46), 45), N);

// UA4
AddPoint(546, 61.9, 1.5);
label(rotate(90)*Label("UA4"), (log10(546), 64), N);

// UA5
AddPoint(900, 65.3, 2);
label(rotate(90)*Label("UA5"), (log10(900), 62), S);

// E710
AddPoint(1800, 72.8, 3.1);
label(rotate(90)*Label("E710"), (log10(1800), 69), S);

// CDF
AddPoint(546, 61.26, 0.93);
label(rotate(90)*Label("CDF"), (log10(546), 58), S);
AddPoint(1800, 80.03, 2.24);
label(rotate(90)*Label("CDF"), (log10(1800), 83), N);

// TOTEM error
real e = 1, y = 50, x = log10(14e3);
draw((x, y+e)--(x, y-e));
label(rotate(90)*Label("TOTEM error"), (x, y), W);
*/

limits((1, 30), (4+log10(2), 130), true);
scale(Log, Linear);

//AddToLegend("best fit with statistical error band", solid);
//AddToLegend("total error band from all models considered", dashed);
//AttachLegend(NW, NW);

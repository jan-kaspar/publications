import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = 6cm;

//---------------------------------------------------------------------------------------------------------------------

string thetas[] = {
	"0.001E-3", "0.004E-3", "0.01E-3", "0.04E-3", "0.1E-3", "0.4E-3",
	"1E-3", "4E-3", "10E-3", "40E-3",
	"100E-3"
};

//---------------------------------------------------------------------------------------------------------------------

scale(Log, Log);

guide graphs[];
for (int ti : thetas.keys) {
	write("* ", thetas[ti]);
	Alignment a;
	if (ParseXML("../alignment/shz_errors/theta/ext_fit=f/"+thetas[ti]+"/results_Jan.xml", a) != 0) {
		write("    ERROR");
		continue;
	}

	real th = (real)(thetas[ti]);

	for (int di : a.shz_e.keys) {
		if (di < 1202 || di == 1248 || di == 1249)
			continue;
		if (!graphs.initialized(di))
			graphs[di] = nullpath;

		// transition from 1E3 to 1E5 events (resolution improves by sqrt(100))
		graphs[di] = graphs[di] -- Scale((th, a.shz_e[di]/10));
	}
}

//---------------------------------------------------------------------------------------------------------------------

void Draw(int idx, pen c, string l="")
{
	draw(graphs[idx], c, l, mCi+c);
}

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_a\un{rad}$", "$z$ shift uncertainty $(\rm mm)$");
scale(Log, Log);

Draw(1202, black, "near-top");
Draw(1212, red, "near-bot");
Draw(1223, blue, "near-hor");
Draw(1233, heavygreen, "far-hor");
Draw(1242, magenta, "far-top");
Draw(1252, cyan, "far-bot");

/*
Draw(1206, black+dashed);
Draw(1216, red+dashed);
Draw(1227, blue+dashed);
Draw(1237, heavygreen+dashed);
Draw(1246, magenta+dashed);
Draw(1256, cyan+dashed);
*/

ylimits(1e1, 1e6);
yaxis(XEquals(1e-4, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_a\un{rad}$", "");
scale(Log, Log);

Draw(1203, black);
Draw(1213, red);
Draw(1222, blue);
Draw(1232, heavygreen);
Draw(1243, magenta);
Draw(1253, cyan);

/*
Draw(1207, black+dashed);
Draw(1217, red+dashed);
Draw(1226, blue+dashed);
Draw(1236, heavygreen+dashed);
Draw(1247, magenta+dashed);
Draw(1257, cyan+dashed);
*/

ylimits(1e1, 1e6);
yaxis(XEquals(1e-4, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
label("$V$ detectors");

NewPad(false, 1, -1);
label("$U$ detectors");

GShipout(hSkip=5mm, vSkip=1mm);

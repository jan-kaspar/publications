import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = ySizeDef = 5.5cm;

//---------------------------------------------------------------------------------------------------------------------

string thetas[] = { "0.001E-3", "0.004E-3", "0.01E-3", "0.04E-3", "0.1E-3", "0.4E-3",
	"1E-3", "4E-3", "10E-3", "40E-3", "100E-3" };

real si_a_typ = 1e-4; // rad
real de_rh_typ = 1; // mrad

scale(Log, Log);
//---------------------------------------------------------------------------------------------------------------------

guide graphs[];
for (int ti : thetas.keys) {
	write("* ", thetas[ti]);
	Alignment a;
	if (ParseXML("../alignment/rotation_errors/nf_theta/station/ext_fit=f/"+thetas[ti]+"/results_Jan.xml", a) != 0) {
		write("    ERROR");
		continue;
	}

	real th = (real)(thetas[ti]);

	for (int di : a.rotz_e.keys) {
		if (di < 1202)
			continue;
		if (!graphs.initialized(di))
			graphs[di] = nullpath;

		graphs[di] = graphs[di] -- Scale((th, a.rotz_e[di]));
	}
}

//---------------------------------------------------------------------------------------------------------------------

void Draw(int idx, pen c, string l="")
{
	draw(graphs[idx], c, l, mCi+c);
}

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_a \ung{rad}$", "rotation uncertainty $\ung{mrad}$");
scale(Log, Log);

Draw(1202, heavygreen, "near-top");
Draw(1212, red, "near-bot");
Draw(1223, blue, "near-hor");
Draw(1233, blue+dashed, "far-hor");
Draw(1242, heavygreen+dashed, "far-top");
Draw(1252, red+dashed, "far-bot");

/*
Draw(1206, black+dashed);
Draw(1216, red+dashed);
Draw(1227, blue+dashed);
Draw(1237, heavygreen+dashed);
Draw(1246, magenta+dashed);
Draw(1256, cyan+dashed);
*/

label(rotate(-40)*Label("near"), (log10(3e-5), log10(0.1)));
label(rotate(-40)*Label("far"), (log10(2e-3), log10(0.2)));

ylimits(1e-2, 1e2);
yaxis(XEquals(si_a_typ, false), dotted);
xaxis(YEquals(de_rh_typ, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_a\ung{rad}$", "");
scale(Log, Log);
Draw(1203, heavygreen);
Draw(1213, red);
Draw(1222, blue);
Draw(1232, blue+dashed);
Draw(1243, heavygreen+dashed);
Draw(1253, red+dashed);

/*
Draw(1207, black+dashed);
Draw(1217, red+dashed);
Draw(1226, blue+dashed);
Draw(1236, heavygreen+dashed);
Draw(1247, magenta+dashed);
Draw(1257, cyan+dashed);
*/

label(rotate(-40)*Label("near"), (log10(3e-5), log10(0.1)));
label(rotate(-40)*Label("far"), (log10(2e-3), log10(0.2)));

ylimits(1e-2, 1e2);
yaxis(XEquals(si_a_typ, false), dotted);
xaxis(YEquals(de_rh_typ, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
label("$V$ sensors");

NewPad(false, 1, -1);
label("$U$ sensors");

GShipout(hSkip=10mm, vSkip=1mm);

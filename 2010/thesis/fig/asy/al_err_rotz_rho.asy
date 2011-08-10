import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = 6cm;

//---------------------------------------------------------------------------------------------------------------------

string rhos[] = { "0.2E-3", "0.4E-3", "0.6E-3", "0.8E-3", "1E-3", "2E-3", "3E-3", "4E-3", "5E-3", 
	"10E-3", "20E-3", "30E-3", "40E-3", "50E-3", "500E-3", "1000" };

real de_rh_typ = 2; // mrad

//---------------------------------------------------------------------------------------------------------------------

scale(Log, Log);

guide graphs[];
for (int ti : rhos.keys) {
	Alignment a;
	ParseXML("../alignment/rotation_errors/uv_rho/"+rhos[ti]+"/results_Jan.xml", a);
	real th = (real)(rhos[ti]);

	for (int di : a.rotz_e.keys) {
		if (di < 1202)
			continue;
		if (!graphs.initialized(di))
			graphs[di] = nullpath;
		
		// mrad vs. mrad, transition from 1E3 to 1E5 events (resolution improves by sqrt(100))
		graphs[di] = graphs[di] -- Scale((th*1e3, a.rotz_e[di]/10));
	}
}

//---------------------------------------------------------------------------------------------------------------------

void Draw(int idx, pen c, string l="")
{
	draw(graphs[idx], c, l, mCi+c+1pt);
}

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_\rh \un{mrad}$", "rotation uncertainty $(\rm mrad)$");
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

label("$\downarrow$ near", (log10(200), log10(0.09)), N);
label("$\uparrow$ far", (log10(200), log10(0.7)), S);

ylimits(1e-2, 1e2);
yaxis(XEquals(de_rh_typ, false), dotted);
xaxis(YEquals(de_rh_typ, false), dotted);

AttachLegend(2);

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si_\rh \un{mrad}$", "");
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

label("$\downarrow$ near", (log10(200), log10(0.09)), N);
label("$\uparrow$ far", (log10(200), log10(0.7)), S);

ylimits(1e-2, 1e2);
yaxis(XEquals(de_rh_typ, false), dotted);
xaxis(YEquals(de_rh_typ, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
label("$V$ sensors");

NewPad(false, 1, -1);
label("$U$ sensors");

GShipout(hSkip=5mm, vSkip=1mm);

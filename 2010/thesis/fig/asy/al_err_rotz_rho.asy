import pad_layout;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = 6cm;

//---------------------------------------------------------------------------------------------------------------------

string rhos[] = { "0.2E-3", "0.4E-3", "0.6E-3", "0.8E-3", "1E-3", "2E-3", "3E-3", "4E-3", "5E-3", 
	"10E-3", "20E-3", "30E-3", "40E-3", "50E-3", "500E-3", "1000" }; 

NewPad("$\si(\de\rh)\un{rad}$", "rotation uncertainty $(\rm mrad)$");
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
		graphs[di] = graphs[di] -- Scale((th, a.rotz_e[di]));
	}
}

//---------------------------------------------------------------------------------------------------------------------

void Draw(int idx, pen c, string l="")
{
	draw(graphs[idx], c, l, mCi+c+1pt);
}


Draw(1202, black, "near-top");
Draw(1212, red, "near-bot");
Draw(1223, blue, "near-hor");
Draw(1233, heavygreen);
Draw(1242, magenta);
Draw(1252, cyan);

Draw(1206, black+dashed);
Draw(1216, red+dashed);
Draw(1227, blue+dashed);
Draw(1237, heavygreen+dashed);
Draw(1246, magenta+dashed);
Draw(1256, cyan+dashed);

ylimits(1e-1, 1e3);
yaxis(XEquals(5e-3, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad("$\si(\de\rh)\un{rad}$", "rotation uncertainty $(\rm mrad)$");
scale(Log, Log);
Draw(1203, black);
Draw(1213, red);
Draw(1222, blue);
Draw(1232, heavygreen, "far-hor");
Draw(1243, magenta, "far-top");
Draw(1253, cyan, "far-bot");

Draw(1207, black+dashed);
Draw(1217, red+dashed);
Draw(1226, blue+dashed);
Draw(1236, heavygreen+dashed);
Draw(1247, magenta+dashed);
Draw(1257, cyan+dashed);

ylimits(1e-1, 1e3);
yaxis(XEquals(5e-3, false), dotted);

AttachLegend();

//---------------------------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
label("V detectors");

NewPad(false, 1, -1);
label("U detectors");

GShipout(hSkip=3mm, vSkip=1mm);

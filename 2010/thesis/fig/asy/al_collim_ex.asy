import root;
import pad_layout;

int timestamp0 = 1259506800;

real tMin = 2700, tMax = 3000;

StdFonts();

//----------------------------------------------------------------------------------------------------

string SecToTime(real x)
{
	int ts = (int)x;
	int h = (int)(ts / 3600);
	int m = (int)((ts % 3600) / 60);
	int s = ts % 60;
	
	return format("%02i", m) + ":" + format("%02i", s);
}

//----------------------------------------------------------------------------------------------------

file f2 = input("/home/jkaspar/software/dip/data/2009_11_29/file2.txt", comment="%");
guide gT, gB;
while (true) {
	real[] x;

	for (int i = 0; i < 53; ++i)
		x[i] = f2;
		
	if (eof(f2))
		break;

	real time = x[0] * 1e-3 - timestamp0;
	
	gT = gT--(time, x[1]);
	gB = gB--(time, x[3]);
}

NewPad("time", "LVDT readings $\rm(mm)$");
draw(gT, red, "top RP");
draw(gB, blue, "bottom RP");
currentpad.xSize = 12cm;
currentpad.ySize = 4cm;
currentpad.xTicks = LeftTicks(SecToTime);

limits((tMin, -10), (tMax, 10), Crop);

yaxis(XEquals(2737, false), -10, 0, dotted);
yaxis(XEquals(2787, false), 0, +10, dotted);
yaxis(XEquals(2851, false), -10, 0, dotted);
yaxis(XEquals(2902, false), 0, +10, dotted);
yaxis(XEquals(2925, false), 0, +10, dotted);

label("5.5", (2743, 5.5), N);
label("5.25", (2844, 5.25), N);
label("5.0", (2913, 5.0), N);
label("4.5", (2963, 4.5), N);

label("-5.0", (2725, -5), S);
label("-4.75", (2790, -4.75), S);
label("-4.5", (2913, -4.5), S);


//add(legend(E), point(E, true), Fill(white));
AttachLegend(E, E);

//HShipout("panelPlot_rpPos");

//----------------------------------------------------------------------------------------------------

NewRow();

string[] blms = { /*"BLMEI.04R5.B1E10_XRP", "BLMEI.04R5.B1E20_XRP",*/ "BLMEI.06R5.B1E10_XRP", 
"BLMQI.06R5.B1E10_MQML_XRP", "BLMQI.06R5.B1E20_MQML" };

string[] labels = { /*"+153 m", "+162 m",*/ "+221 m", "+227 m", "+229 m" };
string[] quantities = { /*"rs1_40us", "rs8_655ms",*/ "rs9_1310ms" };
string[] axisLabels = { /*"rs1_40us", "rs8_655ms",*/ "1310$\,(\rm ms)$" };

pen[] colors = { heavygreen, red, blue };

string file = "/home/jkaspar/software/dip/data/2009_11_29/blm.root";

NewPad("time", "beam losses$\ \rm(G/s)$");
currentpad.xSize = 12cm;
currentpad.ySize = 4cm;
currentpad.xTicks = LeftTicks(SecToTime);
scale(Linear, Log);

//AddLegend("RPs at +215 m");

for (int q = 0; q < quantities.length; ++q) {
	for (int b = 0; b < blms.length; ++b) {
		draw(rGetObj(file, "blm/" + blms[b] + "/" + quantities[q]), colors[b], "BLM at " + labels[b]);
	}

	limits((tMin, 2e-7), (tMax, 5e-4), Crop);
}

//add(legend(NW), point(NW, true), Fill(white));
AttachLegend(2, NW, NW);

yaxis(XEquals(2737, false), dotted);
yaxis(XEquals(2787, false), dotted);
yaxis(XEquals(2851, false), dotted);
yaxis(XEquals(2902, false), dotted);
yaxis(XEquals(2925, false), dotted);

GShipout(vSkip=1mm);

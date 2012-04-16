import root;
import pad_layout;

StdFonts();

xSizeDef = 8cm;
ySizeDef = 4cm;

string SecToTime(real x)
{
	int ts = (int)x;
	int h = (int)(ts / 3600);
	int m = (int)((ts % 3600) / 60);
	int s = ts % 60;
	
	return format("%i", h) + ":" + format("%02i", m);// + ":" + format("%02i", s);
}

xTicksDef = LeftTicks(SecToTime, Step=1200, step=300);
//xSizeDef = 18cm;

string bpmFile_dip = "/afs/cern.ch/exp/totem/scratch/data/RP/2010_06_25/conditions/bpm_dip_log_2010_6_25_17_41_56.root";

real xmin = 66000, xmax = 72200;
real ymin = -500, ymax = 1500;

TGraph_reducePoints = 10;

NewPad("time", "BPM reading$\ung{\mu m}$");
draw(rGetObj(bpmFile_dip, "bpm/BPMWT.A6R5.B1/horizontalPos"), black+1pt);
draw(rGetObj(bpmFile_dip, "bpm/BPMWT.A6R5.B1/verticalPos"), red+1pt);
draw(rGetObj(bpmFile_dip, "bpm/BPMWT.B6R5.B1/horizontalPos"), blue+1pt);
draw(rGetObj(bpmFile_dip, "bpm/BPMWT.B6R5.B1/verticalPos"), heavygreen+1pt);
xlimits(xmin, xmax, Crop);
ylimits(ymin, ymax);

AddToLegend("near-hor", black+1pt);
AddToLegend("near-vert", red+1pt);
AddToLegend("far-hor", blue+1pt);
AddToLegend("far-vert", heavygreen+1pt);
AttachLegend(2, NW, NW);

GShipout();

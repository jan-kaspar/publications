import root;
import pad_layout;

StdFonts();
xSizeDef = 5cm;
ySizeDef = 4cm;

//string file = "../alignment/lhc/2010_10_29-30/profiles/3719,3720/after_tb/profiles.root";
string file = "../alignment/lhc/2010_10_29-30/profiles/3719,3720/improved fits/refit.root";

NewPad("$x\un{mm}$");
//draw(rGetObj(file, "station fits/RP 120/RP120: horizontal"));
//draw(rGetObj(file, "station fits/RP 120/RP120: horizontal#0"), red+1pt);
draw(rGetObj(file, "full"));
draw(rGetObj(file, "full#0"), orange+1pt);
limits((-10, 0), (15, 1.5e5), Crop);
AttachLegend("all $y$ values");


NewPad("$x\un{mm}$");
//draw(rGetObj(file, "station fits/RP 120/horizontal slices/RP120: horizontal, 6.00 <= y < 6.50"));
//draw(rGetObj(file, "station fits/RP 120/horizontal slices/RP120: horizontal, 6.00 <= y < 6.50#0"), red+1pt);
draw(rGetObj(file, "slice"));
draw(rGetObj(file, "slice#0"), orange+1pt);
limits((-10, 0), (15, 3000), Crop);
AttachLegend("$6 < y/{\rm mm} < 6.5$");

//GShipout(hSkip=5mm);

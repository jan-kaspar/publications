import root;
import pad_layout;

string base_dir = "../alignment/lhc_old/2010_09_21_vsym2/profiles";

StdFonts();

//xSizeDef = 3.7cm;
//ySizeDef = 3.7cm;


NewPad("$x\un{mm}$", "$y\un{mm}$");
AttachLegend("simulation");

GShipout(hSkip=1mm);

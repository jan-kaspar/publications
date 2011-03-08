import root;
import pad_layout;

StdFonts();

xSizeDef = 3.7cm;
ySizeDef = 3.7cm;

string base_dir = "../alignment/lhc_old/2010_09_21_vsym2/profiles";

NewPad("$x\un{mm}$", "$y\un{mm}$");
draw(rGetObj(base_dir+"/120_121.root", "56_1#2"), "p");
draw(rGetObj(base_dir+"/120_121.root", "56_1#3"), "p", red);
draw(rGetObj(base_dir+"/120_121.root", "56_1#2#0"), "l", blue);
limits((0, -10), (1, 10));

NewPad("$x\un{mm}$", "$y\un{mm}$");
draw(rGetObj(base_dir+"/122.root", "56_3#2"), "p");
draw(rGetObj(base_dir+"/122.root", "56_3#2#0"), "l", blue);
limits((2, 0.5), (8, 2));

NewPad("$x\un{mm}$", "$y\un{mm}$");
draw(rGetObj(base_dir+"/120_121.root", "56_1#2"), "p");
draw(rGetObj(base_dir+"/120_121.root", "56_1#3"), "p", red);
draw(rGetObj(base_dir+"/120_121.root", "56_1#2#0"), "l", blue);

draw(rGetObj(base_dir+"/122.root", "56_3#2"), "p");
draw(rGetObj(base_dir+"/122.root", "56_3#2#0"), "l", blue);

limits((-2, -10), (8, 10));

GShipout(hSkip=1mm);

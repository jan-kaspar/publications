import root;
import pad_layout;

StdFonts();

string dir = "/afs/cern.ch/exp/totem/scratch/Release/validation/rel3.3/validation/";
string file_el = dir+"valRPelasticBeta2.5Energy3.5TeV/valRPelasticBeta2.5Energy3.5TeV_RPHitDists.root";
string file_sd = dir+"valRPT1T2pythiaSDbeta2.5energy3.5TeV/valRPT1T2pythiaSDbeta2.5energy3.5TeV_RPHitDists.root";
string file_dpe = dir+"valRPT1T2phojetDPEbeta2.5energy3.5TeV/valRPT1T2phojetDPEbeta2.5energy3.5TeV_RPHitDists.root";

NewPad("$x\un{mm}$", "$y\un{mm}$");



// ES
TGraph_reducePoints = 5;
draw(rGetObj(file_el, "unit_120|det_120"), "p", heavygreen);
draw(rGetObj(file_el, "unit_120|det_121"), "p", heavygreen);

// SD
TGraph_reducePoints = 1;
draw(rGetObj(file_sd, "unit_120|det_122"), "p", blue);

// DPE
TGraph_reducePoints = 5;
draw(rGetObj(file_dpe, "unit_120|det_122"), "p", red);
TGraph_reducePoints = 1;
draw(rGetObj(file_dpe, "unit_120|det_120"), "p", red);
draw(rGetObj(file_dpe, "unit_120|det_121"), "p", red);

draw((-10.8185, 4.38748)--(11.5425, 4.38748)--(25.8638, 18.7088));
draw((-10.8185, -4.38748)--(11.5425, -4.38748)--(25.8638, -18.7088));
draw((16.1039, 25.1398)--(1.78257, 10.8185)--(1.78257, -11.5425)--(16.1039, -25.8638));

draw((0, 0), mCi+2pt);

draw((-10, 0)--(10, 0), dotted);
draw((0, -10)--(0, 10), dotted);

limits((-10, -10), (10, 10), Crop);
AttachLegend("simulation");

GShipout(hSkip=1mm);

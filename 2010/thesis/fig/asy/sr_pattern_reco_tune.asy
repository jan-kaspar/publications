import root;
import pad_layout;

StdFonts();

ySizeDef = 4cm;

NewPad("$\hbox{cluster size } a / a_0$");
currentpad.yTicks = RightTicks(Step=0.1, step=0.05);
draw(rGetObj("../root/ClusterSizeSimulation.root", "da_h"), "n,vl,ec", blue+1pt, "simulation");
draw(rGetObj("../root/FastLineRecognition_tune.root", "cas"), "n,vl,ec", red+1pt, "real data");
limits((-0.5, 0), (9.5, 0.7), Crop);
AttachLegend();

NewPad("$\hbox{cluster size } b / P$");
currentpad.yTicks = RightTicks(Step=0.1, step=0.05);
draw(rGetObj("../root/ClusterSizeSimulation.root", "db_h"), "n,vl,ec", blue+1pt);
draw(rGetObj("../root/FastLineRecognition_tune.root", "cbs"), "n,vl,ec", red+1pt);
limits((-0.5, 0), (9.5, 0.7), Crop);

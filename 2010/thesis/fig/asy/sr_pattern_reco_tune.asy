import root;
import pad_layout;

NewPad("$\hbox{cluster size } a / a_0$");
draw(rGetObj("../root/ClusterSizeSimulation.root", "da_h"), "n", blue+1pt, "simulation");
draw(rGetObj("../root/FastLineRecognition_tune.root", "cas"), "n", red+1pt, "real data");
limits((-0.5, 0), (9.5, 0.7), Crop);
AttachLegend();

NewPad("$\hbox{cluster size } b / P$");
draw(rGetObj("../root/ClusterSizeSimulation.root", "db_h"), "n", blue+1pt);
draw(rGetObj("../root/FastLineRecognition_tune.root", "cbs"), "n", red+1pt);
limits((-0.5, 0), (9.5, 0.7), Crop);

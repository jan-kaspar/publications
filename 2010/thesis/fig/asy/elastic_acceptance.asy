import root;
import pad_layout;

StdFonts();

string dir = "../root";

NewPad("$|t|\un{GeV^2}$", "acceptance");
draw(rGetObj(dir+"/elRecoVal_1535_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), red+1pt);
draw(rGetObj(dir+"/elRecoVal_90_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), blue+1pt);
draw(rGetObj(dir+"/elRecoVal_2_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), heavygreen+1pt);

label(rotate(88)*Label("$\be^*=1535$ m"), (-2.5, 0.2), red);
label(rotate(88)*Label("$\be^*=90$ m"), (-1.2, 0.2), blue);
label(rotate(65)*Label("$\be^*=2$ m"), (0.55, 0.61), heavygreen);

limits((-3, 0), (log10(20), 1), Crop);

xaxis(YEquals(0.5, false), dashed);
scale(Log, Linear);

import root;
import pad_layout;

StdFonts();

string dir = "../root";

NewPad("$|t|\un{GeV^2}$", "acceptance$\un{\%}$");
draw(yscale(100), rGetObj(dir+"/elRecoVal_1535_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), red+1pt);
draw(yscale(100), rGetObj(dir+"/elRecoVal_90_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), blue+1pt);
draw(yscale(100), rGetObj(dir+"/elRecoVal_2_1E5_flatLogT.root", "acceptance/acc_t_o_acc"), heavygreen+1pt);

label(rotate(65)*Label("$\be^*=1535$ m"), (-2.2, 50), red);
label(rotate(70)*Label("$\be^*=90$ m"), (-0.9, 50), blue);
label(rotate(65)*Label("$\be^*=2$ m"), (0.55, 62), heavygreen);

limits((-3, 0), (log10(20), 100), Crop);

xaxis(YEquals(30, false), dashed);
scale(Log, Linear);

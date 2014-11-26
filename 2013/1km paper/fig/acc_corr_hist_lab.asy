import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string topDir = "../analysis/";

string f = topDir+"DS2b/distributions_45t_56b.root";

NewPad("$|t|\ung{GeV^2}$", "acceptance correction $\cal A$", 6cm, 5cm);//, xTicks=LeftTicks(0.05, 0.01));
//scale(Log, Linear);
scale(Linear, Log);
//TH1_lowLimit = 1e-3;
draw(rGetObj(f, "acceptance correction/ob-5-4/p_t_full_corr"), "d0,eb", red+1pt, "acceptance");

draw(Label("cut: $|\th_y^*| > 6\un{\mu rad}$", 0), (0.03, 0.7)--(0.005, 1.2), EndArrow);
draw(Label("cut: $\th_x^* > -50\un{\mu rad}$", 0, S), (0.06, 0.15)--(0.045, 0.3), EndArrow);
draw(Label("cut: $\th_x^* < 80\un{\mu rad}$", 0, S), (0.16, 0.25)--(0.11, 0.43), EndArrow);
draw(Label("cut: $|\th_y^*| < 100\un{\mu rad}$", 0, N), (0.11, 0.9)--(0.155, 0.65), EndArrow);

limits((0, 1), (0.2, 20), Crop);

GShipout(margin=0pt);

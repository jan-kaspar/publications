import root;
import pad_layout;

//----------------------------------------------------------------------------------------------------

pen err_pen = red;
real w_err_bar = 0.002;

void DrawErr(real t, real atd, real an, real ln, real y_sug = -1)
{
	real a = 500.9, b = -19.46, c = -2.853;
	real y = (y_sug < 0) ? a * exp(b*t + c*t*t) : y_sug;
	real den = 100.;

	real tot = sqrt(atd^2 + an^2 + ln^2);

	//draw(Scale((t-1.5*xs, y*(1-atd/den)))--Scale((t-1.5*xs, y*(1+atd/den))), heavygreen+1.5pt);
	//draw(Scale((t-0.5*xs, y*(1- an/den)))--Scale((t-0.5*xs, y*(1+ an/den))), orange+1.5pt);
	//draw(Scale((t+0.5*xs, y*(1- ln/den)))--Scale((t+0.5*xs, y*(1+ ln/den))), blue+1.5pt);
	//draw(Scale((t+1.5*xs, y*(1-tot/den)))--Scale((t+1.5*xs, y*(1+tot/den))), red+1.5pt);

	real w = w_err_bar;
	filldraw(Scale((t-w, y*(1-tot/den)))--Scale((t+w, y*(1-tot/den)))--Scale((t+w, y*(1+tot/den)))--Scale((t-w, y*(1+tot/den)))--cycle, err_pen, black+0.05pt);
	//draw(Scale((t, y*(1-tot/den)))--Scale((t, y*(1+tot/den))), err_pen);
	//draw(Scale((t-w, y*(1-tot/den)))--Scale((t+w, y*(1-tot/den))), err_pen);
	//draw(Scale((t-w, y*(1+tot/den)))--Scale((t+w, y*(1+tot/den))), err_pen);
}

//----------------------------------------------------------------------------------------------------

void DrawTotalErr(real t, real y, real ep, real em)
{
	real den = 100.;

	//draw(Scale((t-1.5*xs, y*(1-atd/den)))--Scale((t-1.5*xs, y*(1+atd/den))), heavygreen+1.5pt);
	//draw(Scale((t-0.5*xs, y*(1- an/den)))--Scale((t-0.5*xs, y*(1+ an/den))), orange+1.5pt);
	//draw(Scale((t+0.5*xs, y*(1- ln/den)))--Scale((t+0.5*xs, y*(1+ ln/den))), blue+1.5pt);
	//draw(Scale((t+1.5*xs, y*(1-tot/den)))--Scale((t+1.5*xs, y*(1+tot/den))), red+1.5pt);

	real w = w_err_bar;
	filldraw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den)))--Scale((t+w, y*(1+ep/den)))--Scale((t-w, y*(1+ep/den)))--cycle, err_pen, black+0.05pt);
	//draw(Scale((t, y*(1+em/den)))--Scale((t, y*(1+ep/den))), err_pen);
	//draw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den))), err_pen);
	//draw(Scale((t-w, y*(1+ep/den)))--Scale((t+w, y*(1+ep/den))), err_pen);
}

//----------------------------------------------------------------------------------------------------

void DrawSimpleErr(real t, real e)
{
	real den = 1.;
	real w = w_err_bar;
	real y = 520 * exp(-18.9 * t - 5.1 * t*t);
	real em = -e, ep = e;
	filldraw(Scale((t-w, y*(1+em/den)))--Scale((t+w, y*(1+em/den)))--Scale((t+w, y*(1+ep/den)))--Scale((t-w, y*(1+ep/den)))--cycle, err_pen, black+0.05pt);
}

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$");
scale(Linear, Log);

TF1_lowLimit = 0;
//draw(rGetObj("7_normalize_merged.root", "cross section/fit1|ff1"), heavygreen+2pt);

TH1_lowLimit = 0.37; draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl,eb", blue, "with $\be^*=3.5\un{m}$");
err_pen = blue;
w_err_bar = 0.005;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);


TH1_lowLimit = -inf; TH1_highLimit = 0.38;
draw(rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,eb", red, "with $\be^*=90\un{m}$");
err_pen = red;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
//DrawErr(0.40, 12.3, 1.3, 4., 0.109);


//label("\vbox{\hbox{fit/extrapolation: $\displaystyle \e^{-B|t|}$}\hbox{$\displaystyle B = (19.9 \pm 0.3)\un{GeV^2}$}}", (0.32, 0.5), E, heavygreen);

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical error", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic error", (shift(0, -1)*psy).fit());

limits((0, 1e-5), (2.5, 1e3), Crop);
AttachLegend();

GShipout("es_results_7");
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$");
scale(Linear, Log);

string[] tags = { "bh", "bsw", "islam_cgc", "ppp3", "ppp2" };
for (int t : tags.keys) {
	rObject o = rGetObj("/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/src/IOMC/Elegent/data/3500GeV_0_20_4E3.root", "differential cross section/PH/" + tags[t]);
	if (o.valid)
		draw(o, heavygreen);
}

AddToLegend("models", heavygreen);

TF1_lowLimit = 0;
//draw(rGetObj("7_normalize_merged.root", "cross section/fit1|ff1"), heavygreen+2pt);

TH1_lowLimit = 0.37; TH1_highLimit = +inf;
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl,eb", blue+1pt, "with $\be^*=3.5\un{m}$");
err_pen = blue;
w_err_bar = 0.005;

DrawTotalErr(0.4, 0.13, +25, -37);
DrawTotalErr(0.5, 0.02, +28, -39);
DrawTotalErr(1.5, 0.0011, +27, -30);


TH1_lowLimit = -inf; TH1_highLimit = 0.38;
draw(rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,eb", red+1pt, "with $\be^*=90\un{m}$");
err_pen = red;
DrawErr(0.01, 1.0, 1.3, 4.);
DrawErr(0.06, 0.3, 1.3, 4.);
DrawErr(0.10, 0.9, 1.3, 4.);
DrawErr(0.12, 1.2, 1.3, 4.);
DrawErr(0.16, 3.0, 1.3, 4.);
DrawErr(0.20, 4.5, 1.3, 4., 9.31);
DrawErr(0.30, 8.3, 1.3, 4., 1.257);
//DrawErr(0.40, 12.3, 1.3, 4., 0.109);


//label("\vbox{\hbox{fit/extrapolation: $\displaystyle \e^{-B|t|}$}\hbox{$\displaystyle B = (19.9 \pm 0.3)\un{GeV^2}$}}", (0.32, 0.5), E, heavygreen);

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical error", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic error", (shift(0, -1)*psy).fit());

limits((0, 1e-5), (2.5, 1e3), Crop);
AttachLegend();

GShipout("es_results_7_mod");

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", axesAbove=true);
scale(Linear, Log);

TF1_lowLimit = 0;
//draw(rGetObj("8_fit.root", "combined/exp1/fit|exp1"), heavygreen+2pt);

TH1_lowLimit = -inf; TH1_highLimit = +inf;
draw(rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/merged/merged.root", "eb/combined/dsdt"), "vl,eb", red, "with $\be^*=90\un{m}$");
w_err_bar = 0.005;
err_pen = red;
DrawSimpleErr(0.020, 4.666e-02);
//DrawSimpleErr(0.040, 4.623e-02);
DrawSimpleErr(0.060, 4.586e-02);
//DrawSimpleErr(0.080, 4.590e-02);
DrawSimpleErr(0.100, 4.650e-02);
//DrawSimpleErr(0.120, 4.705e-02);
DrawSimpleErr(0.140, 4.877e-02);
//DrawSimpleErr(0.160, 5.074e-02);
DrawSimpleErr(0.180, 5.450e-02);
//DrawSimpleErr(0.200, 6.367e-02);
DrawSimpleErr(0.220, 6.821e-02);
//DrawSimpleErr(0.240, 7.968e-02);
DrawSimpleErr(0.260, 8.467e-02);
//DrawSimpleErr(0.280, 9.735e-02);
DrawSimpleErr(0.300, 1.052e-01);
//DrawSimpleErr(0.320, 1.133e-01);
//DrawSimpleErr(0.340, 1.298e-01);
//DrawSimpleErr(0.360, 1.378e-01);
//DrawSimpleErr(0.380, 1.535e-01);

TH1_lowLimit = -inf; TH1_highLimit = 0.2;
draw(rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/merged/merged.root", "eb/combined/dsdt"), "vl,eb", heavygreen, "with $\be^*=1000\un{m}$");

fill((0, -2)--(1, -2)--(1, 0)--(0, -0)--cycle, white+opacity(0.7));
label(rotate(-20)*Label("p\ \ r\ \ e\ \ l\ \ i\ \ m\ \ i\ \ n\ \ a\ \ r\ \ y"), (0.6, -1.2), gray);

//label("\vbox{\hbox{fit/extrapolation: $\displaystyle \e^{-B|t|}$}\hbox{$\displaystyle B = (19.9 \pm 0.3)\un{GeV^2}$}}", (0.32, -0.5), E, heavygreen);

// uncertainties legend
picture pse;
unitsize(pse, 1mm);
draw(pse, (-3, 0)--(3, 0));
draw(pse, (0, -1)--(0, 1));
AddToLegend("statistical error", pse.fit());

picture psy;
unitsize(psy, 1mm);
currentpicture = psy;
w_err_bar = 0.5;
err_pen = lightgray;
DrawTotalErr(0, 1., +200, -200);
currentpicture = currentpad.pic;
AddToLegend("systematic error", (shift(0, -1)*psy).fit());

limits((0, 1e-2), (1, 1e3), Crop);
AttachLegend();

GShipout("es_results_8");

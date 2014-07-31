import root;
import pad_layout;
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/plots/t_distributions/common_code.asy";

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000";

string f = topDir + "/tabulation/tabulate.root";

TGraph_errorBar = None;
TH1_errorContourOpacity = 0.6;

xSizeDef = 10cm;
ySizeDef = 8cm;

//----------------------------------------------------------------------------------------------------

void DrawBand(rObject bc, rObject unc, pen p)
{
	int N = bc.iExec("GetN");

	guide g;
	guide g_u, g_b;

	for (int i = 0; i < N; ++i)
	{
		real ta[] = {0.};
		real sa[] = {0.};
		real ua[] = {0.};

		bc.vExec("GetPoint", i, ta, sa);
		unc.vExec("GetPoint", i, ta, ua);

		g_u = g_u -- Scale((ta[0], sa[0] + ua[0]));
		g_b = g_b -- Scale((ta[0], sa[0] - ua[0]));
	}

	g_b = reverse(g_b);
	filldraw(g_u--g_b--cycle, p, nullpen);
}

//----------------------------------------------------------------------------------------------------

void DrawRelBand(rObject bc, rObject unc, pen p)
{
	int N = bc.iExec("GetN");

	guide g;
	guide g_u, g_b;

	for (int i = 0; i < N; ++i)
	{
		real ta[] = {0.};
		real sa[] = {0.};
		real ua[] = {0.};

		bc.vExec("GetPoint", i, ta, sa);
		unc.vExec("GetPoint", i, ta, ua);

		real y_ref = A_ref * exp(- B_ref * ta[0]);

		real c_rel = sa[0] / y_ref - 1.;
		real u_rel = ua[0] / y_ref;

		g_u = g_u -- Scale((ta[0], c_rel + u_rel));
		g_b = g_b -- Scale((ta[0], c_rel - u_rel));
	}

	g_b = reverse(g_b);
	filldraw(g_u--g_b--cycle, p, nullpen);
}

//----------------------------------------------------------------------------------------------------

/*
NewPad(false);
AddToLegend("statistical uncertainty", nullpen, mPl+4pt);
AddToLegend("analysis uncertainty", nullpen, scale(1.2, 1)*mSq+(red+opacity(TH1_errorContourOpacity))+5pt);
AddToLegend("analysis + normalisation uncertainty", nullpen, scale(1.2, 1)*mSq+(heavygreen+opacity(TH1_errorContourOpacity))+5pt);
AttachLegend(E, E + 0.5N);

NewRow();
*/

//----------------------------------------------------------------------------------------------------

/*
NewPad("$|t|\ung{GeV^2}$", "$\d\si / \d t \ung{mb/GeV^2}$", xTicks=LeftTicks(0.05, 0.01));
scale(Linear, Log);

DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_all"), paleblue+opacity(0.4));
DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_anal_all"), yellow);
draw(rGetObj(f, "g_data"), "p", black, mCi+1pt);

limits((0, 1e1), (0.2, 2e3), Crop);
//AttachLegend("$\sqrt s = 8\un{TeV}$, full $|t|$-range");

for (real x = 0; x <= 0.2; x += 0.05)
	yaxis(XEquals(x, false), dotted);

for (real y = 1; y <= 3; y += 1)
	xaxis(YEquals(10^y, false), dotted);
*/


//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si / \d t \ung{mb/GeV^2}$", xTicks=LeftTicks(0.005, 0.001));
//scale(Linear, Log);
currentpad.yTicks = RightTicks(100., 20.);

DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_all"), paleblue+opacity(0.4));
DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_anal_all"), yellow);
draw(rGetObj(f, "g_data"), "p", black, mCi+1pt);

AddToLegend("data", mCi+1pt);
AddToLegend("statistical unc.", (scale(0.0001, 1.)*mPl)+5pt);

AddToLegend("systematic unc. band: analysis+norm.", mSq+6pt+(paleblue+opacity(0.4)));
AddToLegend("systematic unc. band: analysis only", mSq+6pt+yellow);

limits((0, 3e2), (0.015, 1.2e3), Crop);
AttachLegend();

/*
yaxis(XEquals(6e-4, false), dashed+black);
label(rotate(90)*Label("\vbox{\kern1mm\hbox{$|t|_{\rm min}$ at $\be^* = 1\un{km}$}\kern1mm\hbox{$6\cdot 10^{-4}\un{GeV^2}$}}"), (6e-4, 2.05), NE, black);

yaxis(XEquals(0.01, false), dashed+black);
label(rotate(90)*Label("\vbox{\kern1mm\hbox{$|t|_{\rm min}$ at $\be^* = 90\un{m}$}\kern1mm\hbox{$1\cdot 10^{-2}\un{GeV^2}$}}"), (1e-2, 2.05), NE, black);

AttachLegend("$\sqrt s = 8\un{TeV}$, low-$|t|$ detail");
*/

for (real x = 0; x <= 0.015; x += 0.005)
	yaxis(XEquals(x, false), dotted);

for (real y = 300; y <= 1200; y += 100)
	xaxis(YEquals(y, false), dotted);

//----------------------------------------------------------------------------------------------------

A_ref = 519.5;
B_ref = 19.38;

NewPad("$|t|\ung{GeV^2}$", "\vbox{\hbox{$(\d\si/\d t - \hbox{ref}) / \hbox{ref}$}\hbox{ref = $"+ref_str+"$}}");
currentpad.xTicks = LeftTicks(0.05, 0.01);
currentpad.yTicks = RightTicks(0.02, 0.01);

DrawRelBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_all"), paleblue+opacity(0.4));
DrawRelBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_anal_all"), yellow);
draw(rGetObj(f, "g_data"), "p", black, mCi+1pt);
DrawRelDiff(rGetObj(f, "g_data"), black);

limits((0, -0.1), (0.2, 0.1), Crop);

for (real x = 0; x <= 0.2; x += 0.05)
	yaxis(XEquals(x, false), dotted);

for (real y = -0.1; y <= 0.1; y += 0.02)
	xaxis(YEquals(y, false), dotted);
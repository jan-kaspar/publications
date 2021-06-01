import root;
import pad_layout;

//----------------------------------------------------------------------------------------------------

real A_ref = 0., B_ref = 0.;

string MakeRefStr(string label="")
{
	string s = format("$%.3E\,$ ", A_ref) + format("$\e^{-%.2f\,|t|}$", B_ref);
	if (label != "")
		s += "\hbox{ ("+label+")}";
	return s;
}

string ref_str = MakeRefStr("");

//----------------------------------------------------------------------------------------------------

void DrawRelDiff(transform t = identity(), RootObject o, pen p, marker m = mCi+2pt+black, string label="")
{
	if (o.InheritsFrom("TH1"))
	{
		int N = o.iExec("GetNbinsX");
		for (int i = 1; i <= N; ++i)
		{
			real xc = o.rExec("GetBinCenter", i);
			real xw = o.rExec("GetBinWidth", i);

			if (xc < TH1_x_min || xc > TH1_x_max)
				continue;
	
			real y = o.rExec("GetBinContent", i);
			real y_unc = o.rExec("GetBinError", i);
	
			real y_ref = A_ref * exp(-B_ref * xc);
	
			real y_rel = (y - y_ref) / y_ref;
			real y_rel_unc = y_unc / y_ref;
	
			draw(t * ((xc-xw/2, y_rel)--(xc+xw/2, y_rel)), p+0.1pt);	
			draw(t * ((xc, y_rel-y_rel_unc)--(xc, y_rel+y_rel_unc)), p+0.1pt);	
			draw(t * (xc, y_rel), mCi+0.001pt+p);
		}
	
		if (label != "")
			AddToLegend(label, mPl+4pt+p);
	}

	if (o.InheritsFrom("TGraph"))
	{
		guide g_u, g_b;
		
		int N = o.iExec("GetN");
		for (int i = 0; i <= N; ++i)
		{
			real xa[] = {0.};
			real ya[] = {0.};
			o.vExec("GetPoint", i, xa, ya);
			real x = xa[0];
			real y = ya[0];
	
			real y_unc = o.rExec("GetErrorY", i);
	
			real y_ref = A_ref * exp(-B_ref * x);
	
			real y_rel = (y - y_ref) / y_ref;
			real y_rel_unc = y_unc / y_ref;
	
			draw(t * ((x, y_rel-y_rel_unc)--(x, y_rel+y_rel_unc)), p);	
			draw(t * (x, y_rel), m);
			//g_u = g_u -- (x, y_rel+y_rel_unc);
			//g_b = g_b -- (x, y_rel-y_rel_unc);
		}

		//g_b = reverse(g_b);
		//filldraw(t*(g_u--g_b--cycle), p, nullpen);
		
		if (label != "")
			AddToLegend(label, mPl+5pt+p);
	}

	if (o.InheritsFrom("TF1"))
	{
		guide g;

		//real t_max = o.rExec("GetXmax");
		real t_max = 0.2;

		for (real t=0; t <= t_max; t += 0.001)
		{
			real y = o.rExec("Eval", t);
			real y_ref = A_ref * exp(-B_ref * t);
			real y_rel = (y - y_ref) / y_ref;
			g = g--(t, y_rel);
		}

		draw(g, p);
		
		if (label != "")
			AddToLegend(label, p);
	}
}

//----------------------------------------------------------------------------------------------------
// 7 TeV
//----------------------------------------------------------------------------------------------------

A_ref = 503;
B_ref = 19.9;
ref_str = MakeRefStr("");

NewPad("$|t|\ung{GeV^2}$", "${\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\ \ \hbox{ref} = $ "+ref_str+"");

// ----- 90m -----

RootObject obj = RootGetObject("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/tab_this_pub.root", "fits|h_avg");
TH1_x_min = 0.;
DrawRelDiff(obj, red+1pt, "$\be^* = 90\un{m}$");

// ----- common -----

limits((0, -0.10), (0.3, 0.05), Crop);
xaxis(YEquals(0, false), dashed);

AttachLegend(shift(10, 10)*BuildLegend("$\sqrt s = 7\un{TeV}$", SW), SW);




//----------------------------------------------------------------------------------------------------
// 8 TeV
//----------------------------------------------------------------------------------------------------

A_ref = 527;
B_ref = 19.38;
ref_str = MakeRefStr("");

NewPad("$|t|\ung{GeV^2}$", "${\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\ \ \hbox{ref} = $ "+ref_str+"");

// ----- 90m -----

RootObject obj = RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/main/DS-merged/merged.root",
	"ob/DS4/combined/h_dsdt");
TH1_x_min = 0.;
DrawRelDiff(obj, red+1pt, "$\be^* = 90\un{m}$");

// ----- common -----

limits((0, -0.10), (0.3, 0.05), Crop);
xaxis(YEquals(0, false), dashed);

AttachLegend(shift(10, 10)*BuildLegend("$\sqrt s = 8\un{TeV}$", SW), SW);



//----------------------------------------------------------------------------------------------------
// 13 TeV
//----------------------------------------------------------------------------------------------------

A_ref = 633.;
B_ref = 20.4;

ref_str = MakeRefStr("");

NewPad("$|t|\ung{GeV^2}$", "${\d\si/\d t - \hbox{ref} \over \hbox{ref}}\ ,\ \ \hbox{ref} = $ "+ref_str+"");

// ----- 2500m -----

TH1_x_min = 8e-4;
RootObject obj = RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/6500GeV/beta2500/2rp/DS-merged/merged.root",
	"ob-3-5-0.05/merged/45t_56b/h_dsdt");
DrawRelDiff(obj, blue+1pt, "$\be^* = 2500\un{m}$");

// ----- 90m -----

A_ref *= 0.514;
RootObject obj = RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/6500GeV/beta90/10sigma-smearing/DS-frici/unfolding_cf_ni.root",
	"binning-def/p3*exp4+p3*exp3/+0,+0/iteration 4/input_corr");

DrawRelDiff(obj, red+1pt, "$\be^* = 90\un{m}$");

// ----- common -----

limits((0, -0.10), (0.3, 0.05), Crop);
xaxis(YEquals(0, false), dashed);

AttachLegend(shift(10, 10)*BuildLegend("$\sqrt s = 13\un{TeV}$", SW), SW);

import root;
import pad_layout;

real scale_2 = 1e-1;
real scale_7 = 1e0;
real scale_8 = 1e1;


NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 12cm, 8cm);
scale(Linear, Log);

// ----------- 7 TeV ----------

TH1_x_min = -inf; TH1_x_max = +inf;
//draw(shift(0, log10(scale_7)), rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl", black, "");
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "p,iebx", blue);

//TH1_x_max = 0.4; TGraph_highLimit = 0.4;
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", red, "");
draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);


/*
TH1_x_min = 0.; TH1_x_max = 0.45;
draw(rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,d0", red, "this publication");
//TGraph_highLimit = 0.45;
//draw(rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/tab_this_pub.root", "g_stat_err"), "p,iebx", red);

// ----------- 8 TeV ----------

TH1_x_max = +inf;
draw(shift(0, log10(scale_8)), rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/merged/merged.root", "eb/combined/dsdt"), blue, "$8\un{TeV}, \be^*=90\un{m}$");

draw(shift(0, log10(scale_8)), rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/merged/merged.root", "eb/combined/dsdt"), heavygreen, "$8\un{TeV}, \be^*=1000\un{m}$");


limits((0, 1e-6), (3, 2e3), Crop);


//----------------------------------------------------------------------------------------------------
NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 12cm, 8cm);
scale(Linear, Log);

real scale_2 = 1e-1;
real scale_7 = 1e0;
real scale_8 = 2;

// ----------- 7 TeV ----------

TH1_x_min = -inf; TH1_x_max = +inf;
draw(shift(0, log10(scale_7)), rGetObj("/home/jkaspar/publications/2012/elastic scattering/h1.root", "h1"), "vl", black, "$\sqrt s = 7\un{TeV}, \be^*=3.5\un{m}$");
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "p,iebx", blue);

//TH1_x_max = 0.4; TGraph_highLimit = 0.4;
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/h2.root", "h2"), "vl", red, "");
//draw(rGetObj("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "p,iebx", heavygreen);


TH1_x_min = 0.; TH1_x_max = 0.45;
draw(shift(0, log10(scale_7)), rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,d0", red, "$\sqrt s = 7\un{TeV}, \be^*=90\un{m}$");
//TGraph_highLimit = 0.45;
//draw(rGetObj("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/tab_this_pub.root", "g_stat_err"), "p,iebx", red);

// ----------- 8 TeV ----------

TH1_x_max = +inf;
draw(shift(0, log10(scale_8)), rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90/merged/merged.root", "eb/combined/dsdt"), blue, "$\sqrt s = 8\un{TeV}, \be^*=90\un{m}$");

draw(shift(0, log10(scale_8)), rGetObj("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/merged/merged.root", "eb/combined/dsdt"), heavygreen, "$\sqrt s = 8\un{TeV}, \be^*=1000\un{m}$");


limits((0, 5e1), (0.1, 2e3), Crop);
AttachLegend();
*/

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

/*
NewRow();

NewPad("$|t|\ung{GeV^2}$", "$B(t)\ung{GeV^{-2}}$", xTicks=LeftTicks(Step=0.1, step=0.01), 12cm, 10cm);
TGraph_highLimit = +inf;

string[] tags = { "bh", "bsw", "islam_cgc", "jenkovszky", "ppp3" };
//string[] tags = { "islam_cgc" };
for (int t : tags.keys) {
	rObject o = rGetObj("/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/src/IOMC/Elegent/data/3500GeV_0_20_4E3.details.root", "B/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, black);
}

AddToLegend("several phenomenological models", black);
//AddToLegend("Islam et al.", black);

TGraph_errorBar = None;

//draw(rGetObj("calculate_B.root", "3500GeV,3.5m/gB_flat"), "p,l,eb", red);
//draw(rGetObj("calculate_B.root", "3500GeV,90m/gB_flat"), "p,l,eb", blue);

AddToLegend("(vertical error bars: statistical uncertainties only)");
AddToLegend("(horizontal error bars: fit regions)");

//limits((0., -10), (2.2, 30), Crop);
limits((0., +10), (0.5, 30), Crop);
AttachLegend("$\sqrt s = 7\un{TeV}$", SW, SW);
*/

//----------------------------------------------------------------------------------------------------

/*
NewPad("$|t|\ung{GeV^2}$", "$B(t)\ung{GeV^{-2}}$", xTicks=LeftTicks(Step=0.1, step=0.01), 12cm, 10cm);
TGraph_highLimit = +inf;

string[] tags = { "bh", "bsw", "islam_cgc", "jenkovszky", "ppp3" };
for (int t : tags.keys) {
	rObject o = rGetObj("/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/src/IOMC/Elegent/data/4000GeV_0_20_4E3.details.root", "B/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, black);
}

AddToLegend("several phenomenological models", black);
//AddToLegend("Islam et al.", black);

TGraph_errorBar = None;

draw(rGetObj("calculate_B.root", "4000GeV,90m/gB_flat"), "p,l,eb", black, "$\be^* = 90\un{m}$ (flat weights)");
draw(rGetObj("calculate_B.root", "4000GeV,90m/gB_gauss"), "p,l,eb", blue, "$\be^* = 90\un{m}$ (gaussian weights)");

draw(rGetObj("calculate_B.root", "4000GeV,1000m/gB_flat"), "p,l,eb", heavygreen, "$\be^* = 1000\un{m}$ (flat weights)");
draw(rGetObj("calculate_B.root", "4000GeV,1000m/gB_gauss"), "p,l,eb", red, "$\be^* = 1000\un{m}$ (gaussian weights)");

AddToLegend("(vertical error bars: statistical uncertainties only)");
//AddToLegend("(horizontal error bars: fit regions)");


//limits((0., -10), (2.2, 30), Crop);
limits((0., +10), (0.5, 30), Crop);
AttachLegend("$\sqrt s = 8\un{TeV}$", SW, SW);

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$B(t)\ung{GeV^{-2}}$", xTicks=LeftTicks(Step=0.05, step=0.01), 12cm, 10cm);
currentpad.yTicks = RightTicks(Step=1, step=0.2);

TGraph_highLimit = +inf;

string[] tags = { "bh", "bsw", "islam_cgc", "jenkovszky", "ppp3" };
for (int t : tags.keys) {
	rObject o = rGetObj("/afs/cern.ch/exp/totem/scratch/jkaspar/software/offline/424/src/IOMC/Elegent/data/4000GeV_0_20_4E3.details.root", "B/PH/" + tags[t], error=false);
	if (o.valid)
		draw(o, black);
}

AddToLegend("several phenomenological models", black);
//AddToLegend("Islam et al.", black);
*/

/*
TGraph_errorBar = None;

draw(rGetObj("calculate_B.root", "4000GeV,90m/gB_flat"), "p,l,eb", black, "$\be^* = 90\un{m}$ (flat weights)");
draw(rGetObj("calculate_B.root", "4000GeV,90m/gB_gauss"), "p,l,eb", blue, "$\be^* = 90\un{m}$ (gaussian weights)");

draw(rGetObj("calculate_B.root", "4000GeV,1000m/gB_flat"), "p,l,eb", heavygreen, "$\be^* = 1000\un{m}$ (flat weights)");
draw(rGetObj("calculate_B.root", "4000GeV,1000m/gB_gauss"), "p,l,eb", red, "$\be^* = 1000\un{m}$ (gaussian weights)");

AddToLegend("(vertical error bars: statistical uncertainties only)");
//AddToLegend("(horizontal error bars: fit regions)");


//limits((0., -10), (2.2, 30), Crop);
limits((0., +16), (0.3, 24), Crop);
//AttachLegend("$\sqrt s = 8\un{TeV}$", SW, SW);

for (real x = 0; x < 0.3; x += 0.01)
	yaxis(XEquals(x, false), dotted);

for (real y = 16; y < 24; y += 1)
	xaxis(YEquals(y, false), dotted);
*/

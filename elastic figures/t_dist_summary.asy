include root;
include pad_layout;

TGraph_errorBar = None;

dotfactor = 6;

//----------------------------------------------------------------------------------------------------

void PlotAll(string labels = "")
{
	// ----------- 2.76 TeV ----------
	AddToLegend("<$\sqrt s = 2.76\un{TeV}$ (scaled $0.01\times$):");
	
	real shy_2 = -2;
	
	TH1_x_max = 0.4;
	//draw(shift(0, shy_2), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/1380GeV/beta11/DS1/distributions_45b_56t.root",
	//	"normalization/eb/h_t_normalized"), "vl,d0", magenta+dashed+0.7pt, "$\be^*=11\un{m}$, PRELIMINARY!");

	AddToLegend("$\be^*=11\un{m}$ [CERN-EP-2018-341]", magenta);

	draw(shift(0, shy_2), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/D0_TOTEM/data/TOTEM_2.76TeV/data_4sigma.root",
		"g_dsdt"), "l,p", magenta);

	draw(shift(0, shy_2), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/D0_TOTEM/data/TOTEM_2.76TeV/data.root",
		"g_dsdt"), "l,p", magenta);
	
	
	// ----------- 7 TeV ----------
	AddToLegend("<$\sqrt s = 7\un{TeV}$:");
	
	AddToLegend("$\be^* = 3.5\un{m}$ [EPL 95 (2011) 41001]", blue);
	TH1_x_max = inf;
	draw(RootGetObject("/home/jkaspar/work/publications/2012/elastic scattering/g1.root", "g1"), "d,l,iebx", blue);
	
	//draw(RootGetObject("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "d,l,iebx", red);
	
	AddToLegend("$\be^* = 90\un{m}$ [EPL 101 (2013) 21002]", red);
	TH1_x_max = 0.45;
	draw(RootGetObject("/home/jkaspar/work/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,d0,eb", red+1pt);
	
	

	// ----------- 8 TeV ----------
	
	AddToLegend("<$\sqrt s = 8\un{TeV}$ (scaled $10\times$):");
	
	real shy_8 = 1;
	
	AddToLegend("$\be^* = 90\un{m}$ [PRELIMINARY]", red+dashed);
	TH1_x_max = +inf;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/elastic/4000GeV/beta90/high_t/DS-merged/merged.root",
		"ob-2-20-0.20/DS4/45t_56b/h_dsdt"), "cl,eb", red+dashed+0.7pt);
	
	AddToLegend("$\be^* = 90\un{m}$ [NPB 899 (2015) 527]", red);
	TH1_x_max = +0.2;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/elastic/4000GeV/beta90/main/DS-merged/merged.root",
		"ob/merged/combined/h_dsdt"), "vl,d0,eb", red+2pt);
	
	AddToLegend("$\be^* = 1000\un{m}$ [EPJ C (2016) 76:661]", heavygreen);
	TH1_x_max = 0.02;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/elastic/4000GeV/beta1000/main/DS-merged/merged.root",
		"ob-0-1/merged/combined/h_dsdt"), heavygreen+3pt);
	
	
	// ----------- 13 TeV ----------
	
	AddToLegend("<$\sqrt s = 13\un{TeV}$ (scaled $1000\times$):");
	
	real shy_13 = 3;
	
	AddToLegend("$\be^* = 90\un{m}$ [EPJ C (2019) 79:861]", red);
	TH1_x_min = 0.05;
	TH1_x_max = 4.0;
	//draw(shift(0, shy_13 -8.75), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/6500GeV/beta90/10sigma/DS-merged/merged.root",
	//	"ob-1-10-0.2/merged/combined/h_dsdt"), "vl,d0,eb", dashed+red+0.7pt, "$\be^*=90\un{m}$, PRELIMINARY!");
	//AddToLegend("(arbitrary normalisation)");

	draw(shift(0, shy_13), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/D0_TOTEM/data/TOTEM_13TeV/data.root",
		"g_dsdt"), "l,p", red+0.7pt);

	AddToLegend("$\be^* = 2500\un{m}$ [EPJ C (2019) 79:785]", heavygreen);
	TH1_x_min = 8e-4;
	TH1_x_max = 0.2;
	draw(shift(0, shy_13), RootGetObject("/afs/cern.ch/work/j/jkaspar/work/analyses/elastic/6500GeV/beta2500/2rp/DS-merged/merged.root",
		"ob-2-10-0.05/merged/combined/h_dsdt"), "vl,d0,eb", heavygreen+1.5pt);
	

	// -------------- labels -----------

	if (labels == "main")
	{
		label("$\sqrt s = 13\un{TeV}$", (0.75, 2.2), Fill(white));
		label("$\sqrt s = 8\un{TeV}$", (0.75, 0), Fill(white));
		label("$\sqrt s = 7\un{TeV}$", (0.75, -2.5), Fill(white));
		label("$\sqrt s = 2.76\un{TeV}$", (0.75, -4.5), Fill(white));

		//label(rotate(-68) * Label("{\bf PRELIMINARY}"), (0.25, -2.5), gray);
		label(rotate(-19) * Label("{\bf PRELIMINARY}"), (1.5, -1.4), gray);
		//label(rotate(-25) * Label("{\bf PRELIMINARY}"), (1.5, 0.3), gray);
		//label(rotate(-64) * Label("{\bf PRELIMINARY}"), (0.28, 4), gray);
	}

	if (labels == "dip")
	{
		label("$\sqrt s = 13\un{TeV}$", (0.75, 1.3), Fill(white));
		label("$\sqrt s = 8\un{TeV}$", (0.75, -0.2), Fill(white));
		label("$\sqrt s = 7\un{TeV}$", (0.75, -1.3), Fill(white));
		label("$\sqrt s = 2.76\un{TeV}$", (0.75, -3.5), Fill(white));

		//label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.4, 1.2), gray);
		label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.35, 0.4), gray);
		label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.26, -1.1), gray);
	}
}


//----------------------------------------------------------------------------------------------------

/*
NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 4cm, 8cm, xTicks=LeftTicks(0.005, 0.001));
scale(Linear, Log);

PlotAll();

limits((0, 1e-5), (0.01, 2e6), Crop);
*/


NewPad("$|t|\ung{GeV^2}$\hskip3mm\hbox{}", "$\d\si/\d t\ung{mb/GeV^2}$\hskip5mm\hbox{}", 12cm, 8cm, xTicks=LeftTicks(0.5, 0.1));
scale(Linear, Log);

PlotAll("main");

limits((0, 1e-5), (4.0, 2e6), Crop);

legendLabelPen = fontcommand("\SetFontSizesVI");

AttachLegend("{\bf elastic-scattering measurements by TOTEM}", NE, NE);

GShipout("t_dist_summary", hSkip=0mm, margin=2mm);

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 12cm, 8cm);
scale(Linear, Log);

PlotAll("dip");

limits((0.2, 1e-2), (0.8, 1e2), Crop);

GShipout("t_dist_summary_detail", margin=1mm);

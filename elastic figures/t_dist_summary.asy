include root;
include pad_layout;

TGraph_errorBar = None;

dotfactor = 6;

//----------------------------------------------------------------------------------------------------

void PlotAll(bool detail=false)
{
	// ----------- 2.76 TeV ----------
	AddToLegend("<$\sqrt s = 2.76\un{TeV}$ (arbitrary normalisation)");
	
	real shy_2 = -1;
	
	TH1_x_max = 0.4;
	draw(shift(0, shy_2), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/1380GeV/beta11/DS1/distributions_45b_56t.root",
		"normalization/eb/h_t_normalized"), "vl,d0", gray+opacity(0.5)+2.5pt, "$\be^*=11\un{m}$, VERY PRELIMINARY!");
	
	label("$\sqrt s = 2.76\un{TeV}$", (0.75, -3.5), Fill(white));
	
	
	// ----------- 7 TeV ----------
	AddToLegend("<$\sqrt s = 7\un{TeV}$");
	
	TH1_x_max = inf;
	draw(RootGetObject("/home/jkaspar/publications/2012/elastic scattering/g1.root", "g1"), "d,l,iebx", blue, "$\be^* = 3.5\un{m}$");
	
	//draw(RootGetObject("/home/jkaspar/publications/2012/elastic scattering/g2.root", "g2"), "d,l,iebx", red);
	
	TH1_x_max = 0.45;
	draw(RootGetObject("/home/jkaspar/publications/2012/7TeV three papers/elastic/tabulation/dataset_cmp.root", "h_avg"), "vl,d0,eb", red+1pt, "$\be^* = 90\un{m}$");
	
	label("$\sqrt s = 7\un{TeV}$", (0.75, (detail) ? -1.3 : -2.4), Fill(white));
	
	// ----------- 8 TeV ----------
	
	AddToLegend("<$\sqrt s = 8\un{TeV}$ (scaled $10\times$)");
	
	real shy_8 = 1;
	
	TH1_x_max = +inf;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/high_t/DS-merged/merged.root",
		"ob-2-20-0.20/DS4/45t_56b/h_dsdt"), "cl,eb", gray+opacity(0.5)+2.5pt, "$\be^*=90\un{m}$, PRELIMINARY!");
	
	TH1_x_max = +0.2;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta90/main/DS-merged/merged.root",
		"ob/merged/combined/h_dsdt"), "vl,d0,eb", red+2pt, "$\be^*=90\un{m}$");
	
	TH1_x_max = 0.02;
	draw(shift(0, shy_8), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV/beta1000/main/DS-merged/merged.root",
		"ob-0-1/merged/combined/h_dsdt"), heavygreen+3pt, "$\be^*=1000\un{m}$");
	
	label("$\sqrt s = 8\un{TeV}$", (0.75, 0), Fill(white));
	
	// ----------- 13 TeV ----------
	
	AddToLegend("<$\sqrt s = 13\un{TeV}$ (arbitrary normalisation)");
	
	real shy_13 = -6;
	
	TH1_x_min = 0.05;
	TH1_x_max = 3.4;
	draw(shift(0, shy_13), RootGetObject("/afs/cern.ch/work/j/jkaspar/analyses/elastic/6500GeV/beta90/10sigma/DS-merged/merged.root",
		"ob-1-10-0.2/merged/combined/h_dsdt"), "vl,d0,eb", gray+opacity(0.5)+2.5pt, "$\be^*=90\un{m}$, VERY PRELIMINARY!");
	
	label("$\sqrt s = 13\un{TeV}$", (0.75, 1.7), Fill(white));

	// -------------- labels -----------

	if (detail)
	{
		label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.4, 1.2), gray);
		label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.35, 0.4), gray);
		label(rotate(-45) * Label("{\bf PRELIMINARY}"), (0.26, -1.1), gray);
	} else {
		label(rotate(-25) * Label("{\bf PRELIMINARY}"), (1.5, 0.3), gray);
		label(rotate(-25) * Label("{\bf PRELIMINARY}"), (1.5, -1.2), gray);
		label(rotate(-68) * Label("{\bf PRELIMINARY}"), (0.25, -2.5), gray);
	}
}


//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 12cm, 8cm, xTicks=LeftTicks(0.5, 0.1));
scale(Linear, Log);

PlotAll();

limits((0, 1e-5), (3.5, 1e5), Crop);

AttachLegend(NW, NE);

GShipout("t_dist_summary");

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si/\d t\ung{mb/GeV^2}$", 12cm, 8cm);
scale(Linear, Log);

PlotAll(true);

limits((0.2, 1e-2), (0.8, 1e2), Crop);

GShipout("t_dist_summary_detail");

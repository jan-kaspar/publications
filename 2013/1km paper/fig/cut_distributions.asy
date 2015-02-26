import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string datasets[] = { "DS2b" };

//string diagonals[] = { "45b_56t" };
//string dgn_labels[] = { "45b -- 56t" };
string diagonals[] = { "45t_56b" };
string dgn_labels[] = { "45t -- 56b" };

string topDir = "../analysis/";

xSizeDef = 10cm;
ySizeDef = 6cm;

//----------------------------------------------------------------------------------------------------

void Check(rObject obj, real scale)
{
	real entries = obj.rExec("GetEntries");
	int nb = obj.iExec("GetNbinsX");
	real sum = 0;
	for (int bi = 0; bi <= nb+1; ++bi)	// count also under- and overflow bins
		sum += obj.rExec("GetBinContent", bi) * scale;

	write(format("entries = %.1f", entries) + format(", sum = %.1f", sum));
}

//----------------------------------------------------------------------------------------------------

string dataset;
string diagonal;

void MakeComparison(string quantity, real xscale, string unit, string obj, real xlimit, real sigma,
	real xStep, real xstep,
	string combinations[], string comb_labels[], pen comb_pens[])
{
	// diagonals
	NewPad(quantity+"$\ung{"+unit+"}$", "events per bin", xTicks=LeftTicks(xStep, xstep));
	scale(Linear, Log(true));
	for (int ci : combinations.keys)
	{
		string f = topDir+dataset+"/background_study/"+combinations[ci]+"/distributions_"+diagonal+".root";
		rObject o = rGetObj(f, "elastic cuts/"+obj);
		draw(scale(xscale, 1), o, "vl", comb_pens[ci], replace(comb_labels[ci], "_", "\_"));
		Check(o, 1);	
	}

	frame f_legend1 = BuildLegend("45 top -- 56 bottom", ymargin=0mm, vSkip=-1mm, lineLength=3.8mm, NW);
	currentpicture.legend.delete();

	// anti-diagonals
	string cut_str = combinations[combinations.length-1];
	string dir_anti = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000/DS2b/background_study/" + cut_str;

	AddToLegend("<" + comb_labels[comb_labels.length-1] + ":");

	pen astyle = linetype(new real[] {4, 4});

	rObject o = rGetObj(dir_anti + "/distributions_anti_45b_56b.root", "elastic cuts/"+obj);
	draw(xscale(1e6), o, "vl", red+astyle, "45 bottom -- 56 bottom");
	Check(o, 1);

	rObject o = rGetObj(dir_anti + "/distributions_anti_45t_56t.root", "elastic cuts/"+obj);
	draw(xscale(1e6), o, "vl", magenta+astyle, "45 top -- 56 top");
	Check(o, 1);

	frame f_legend2 = BuildLegend(ymargin=0mm, vSkip=-1mm, lineLength=3.8mm, NE);
	
	limits((-xlimit, 5e-1), (+xlimit, 1e5), Crop);

	yaxis(XEquals(-4*sigma, false), dashed);
	yaxis(XEquals(+4*sigma, false), dashed);

	for (real y = 0; y <= 4; y += 1)
		xaxis(YEquals(10^y, false), dotted);

	add(f_legend1, point(NW), Fill(white));
	add(f_legend2, point(NE), Fill(white));
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	for (int dgi : diagonals.keys)
	{
		NewRow();

		dataset = datasets[dsi];
		diagonal = diagonals[dgi];

		//NewPad(false);
		//label(replace("{\SetFontSizesXX\vbox{\hbox{"+dataset+"}\hbox{"+dgn_labels[dgi]+"}}}", "_", "\_"));

		string combinations[];
		string comb_labels[];
		pen comb_pens[];
		
		combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(black);
		combinations.push("cuts:2"); comb_labels.push("cuts 2"); comb_pens.push(heavygreen);
		combinations.push("cuts:2,7"); comb_labels.push("cuts 2, 3"); comb_pens.push(blue);
		
		MakeComparison("$\theta_x^{*\rm R} - \theta_x^{*\rm L}$", 1e6, "\mu rad", "cut 1/h_cq1", 100, 3.9, 50, 10, combinations, comb_labels, comb_pens);
		
		/*
		//--------------------
		//NewPage();
		
		string combinations[];
		pen comb_pens[];
		
		combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
		combinations.push("cuts:1"); comb_labels.push("cuts: 1"); comb_pens.push(heavygreen);
		combinations.push("cuts:1,7"); comb_labels.push("cuts: 1, 7"); comb_pens.push(magenta);
		
		MakeComparison("$\De\th_y^*$", 1e6, "\mu rad", "cut 2/h_cq2", 30, 1., 5, 1, combinations, comb_labels, comb_pens);
		
		//--------------------
		//NewPage();
		
		string combinations[];
		pen comb_pens[];
		
		combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
		combinations.push("cuts:1"); comb_labels.push("cuts: 1"); comb_pens.push(heavygreen);
		combinations.push("cuts:1,2"); comb_labels.push("cuts: 1, 2"); comb_pens.push(orange);
		
		MakeComparison("$\De x^*$", 1e3, "\mu m", "cut 7/h_cq7", 3000, 250, 1000, 500, combinations, comb_labels, comb_pens);
		*/
	}
}

GShipout(margin=0pt);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");

string dataset = "DS4";

string diagonal = "45t_56b";
string diagonal_lab = "45 top -- 56 bottom";

string topDir = "../analysis/";

//xSizeDef = 6.5cm;
//ySizeDef = 4.5cm;
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

void MakeComparison(string quantity, real xscale, string unit, string obj, real xlimit, real sigma,
	real xStep, real xstep,
	string combinations[], string comb_labels[], pen comb_pens[])
{
	NewPad(quantity+"$\ung{"+unit+"}$", "events per bin", xTicks=LeftTicks(xStep, xstep));
	scale(Linear, Log(true));

	AddToLegend("<" + diagonal_lab + ":");

	for (int ci : combinations.keys)
	{
		string f = topDir+"/background_studies/"+dataset+"/"+combinations[ci]+"/distributions_"+diagonal+".root";
		rObject o = rGetObj(f, "elastic cuts/"+obj);
		draw(scale(xscale, 1), o, "vl", comb_pens[ci], comb_labels[ci]);
		Check(o, 1);
	}

	yaxis(XEquals(-4*sigma, false), dashed);
	yaxis(XEquals(+4*sigma, false), dashed);

	frame f_legend1 = BuildLegend(ymargin=0mm, vSkip=6mm, lineLength=5mm, NW);

	//draw(scale(xscale, 1), rGetObj("background_fits.root", combinations[combinations.length - 1] + "|ff"), black+dotted);

	//--------------------
	
	currentpicture.legend.delete();

	string cut_str = combinations[combinations.length-1];
	string dir_anti = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta90,high_t/DS4/background_study/" + cut_str;

	AddToLegend("<" + comb_labels[comb_labels.length-1] + ":");

	rObject o = rGetObj(dir_anti + "/distributions_anti_45b_56b.root", "elastic cuts/"+obj);
	draw(xscale(1e6), o, "vl", blue+dotted, "45 bot -- 56 bot");
	Check(o, 1);

	rObject o = rGetObj(dir_anti + "/distributions_anti_45t_56t.root", "elastic cuts/"+obj);
	draw(xscale(1e6), o, "vl", heavygreen+dotted, "45 top -- 56 top");
	Check(o, 1);
	
	frame f_legend2 = BuildLegend(ymargin=0mm, vSkip=1mm, lineLength=5mm, NE);

	xlimits(-xlimit, +xlimit, Crop);
	add(f_legend1, point(NW), Fill(white));
	add(f_legend2, point(NE), Fill(white));
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string combinations[];
string comb_labels[];
pen comb_pens[];

combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(black);
combinations.push("cuts:2"); comb_labels.push("cuts 2"); comb_pens.push(red);
combinations.push("cuts:2,5"); comb_labels.push("cuts 2, 3"); comb_pens.push(blue);
combinations.push("cuts:2,5,6"); comb_labels.push("cuts 2, 3, 4"); comb_pens.push(heavygreen);
combinations.push("cuts:2,5,6,7"); comb_labels.push("cuts 2, 3, 4, 5"); comb_pens.push(magenta);

MakeComparison("$\theta_x^{*\rm R} - \theta_x^{*\rm L}$", 1e6, "\mu rad", "cut 1/h_cq1", 200, 9.4, 100, 20, combinations, comb_labels, comb_pens);

GShipout(margin=0mm);

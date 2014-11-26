import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string datasets[] = { "DS2b" };

string diagonals[] = { "45t_56b" };
string dgn_labels[] = { "45t -- 56b" };

string topDir = "../analysis/";

xSizeDef = 6.0cm;
ySizeDef = 4cm;

//----------------------------------------------------------------------------------------------------

string dataset;
string diagonal;

void MakeComparison(string quantity, real xscale, string unit, string obj, real xlimit, real sigma,
	real xStep, real xstep,
	string combinations[], string comb_labels[], pen comb_pens[])
{
	NewPad(quantity+"$\ung{"+unit+"}$", "", xTicks=LeftTicks(xStep, xstep));
	scale(Linear, Log(true));
	for (int ci : combinations.keys)
	{
		string f = topDir+dataset+"/background_study/"+combinations[ci]+"/distributions_"+diagonal+".root";
		draw(scale(xscale, 1), rGetObj(f, "elastic cuts/"+obj),
			comb_pens[ci], replace(comb_labels[ci], "_", "\_"));	
	}

	yaxis(XEquals(-4*sigma, false), dashed);
	yaxis(XEquals(+4*sigma, false), dashed);

	xlimits(-xlimit, +xlimit, Crop);
	AttachLegend(NE, NE);
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
		
		combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
		combinations.push("cuts:2"); comb_labels.push("cuts: 2"); comb_pens.push(red);
		combinations.push("cuts:2,7"); comb_labels.push("cuts: 2, 3"); comb_pens.push(blue);
		
		MakeComparison("$\theta_x^{*\rm R} - \theta_x^{*\rm L}$", 1e6, "\mu rad", "cut 1/h_cq1", 100, 3.9, 50, 10, combinations, comb_labels, comb_pens);
		
		/*
		//--------------------
		//NewPage();
		
		string combinations[];
		pen comb_pens[];
		
		combinations.push("no_cuts"); comb_pens.push(gray);
		combinations.push("cuts:1"); comb_pens.push(heavygreen);
		combinations.push("cuts:1,7"); comb_pens.push(magenta);
		
		MakeComparison("$\De\th_y^*$", 1e6, "\mu rad", "cut 2/h_cq2", 30, 1., 5, 1, combinations, comb_pens);
		
		//--------------------
		//NewPage();
		
		string combinations[];
		pen comb_pens[];
		
		combinations.push("no_cuts"); comb_pens.push(gray);
		combinations.push("cuts:1"); comb_pens.push(heavygreen);
		combinations.push("cuts:1,2"); comb_pens.push(orange);
		
		MakeComparison("$\De x^*$", 1e3, "\mu m", "cut 7/h_cq7", 3000, 250, 1000, 500, combinations, comb_pens);
		*/
	}
}

GShipout(margin=0pt);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string dataset = "DS4";

string diagonal = "45t_56b";

string topDir = "../analysis/";

xSizeDef = 6.5cm;
ySizeDef = 4.5cm;

//----------------------------------------------------------------------------------------------------

void MakeComparison(string quantity, real xscale, string unit, string obj, real xlimit, real sigma,
	real xStep, real xstep,
	string combinations[], string comb_labels[], pen comb_pens[])
{
	NewPad(quantity+"$\ung{"+unit+"}$", "", xTicks=LeftTicks(xStep, xstep));
	scale(Linear, Log(true));
	for (int ci : combinations.keys)
	{
		string f = topDir+"/background_studies/"+dataset+"/"+combinations[ci]+"/distributions_"+diagonal+".root";
		draw(scale(xscale, 1), rGetObj(f, "elastic cuts/"+obj),
			comb_pens[ci], comb_labels[ci]);	
	}

	yaxis(XEquals(-4*sigma, false), dashed);
	yaxis(XEquals(+4*sigma, false), dashed);

	draw(scale(xscale, 1), rGetObj("background_fits.root", combinations[combinations.length - 1] + "|ff"), black+dotted);

	xlimits(-xlimit, +xlimit, Crop);
	//AttachLegend(quantity, NW, NE);
	add(BuildLegend(vSkip=5mm, lineLength=4mm, NE), point(NE), Fill(white));
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

string combinations[];
string comb_labels[];
pen comb_pens[];

combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
combinations.push("cuts:2"); comb_labels.push("cuts: 2"); comb_pens.push(red);
combinations.push("cuts:2,5"); comb_labels.push("cuts: 2, 3"); comb_pens.push(blue);
combinations.push("cuts:2,5,6"); comb_labels.push("cuts: 2, 3, 4"); comb_pens.push(heavygreen);
combinations.push("cuts:2,5,6,7"); comb_labels.push("cuts: 2, 3, 4, 5"); comb_pens.push(magenta);

MakeComparison("$\theta_x^{*R} - \theta_x^{*L}$", 1e6, "\mu rad", "cut 1/h_cq1", 200, 9.4, 100, 20, combinations, comb_labels, comb_pens);

/*
//--------------------
//NewPage();

string combinations[];
string comb_labels[];
pen comb_pens[];

combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
combinations.push("cuts:1"); comb_labels.push("cuts: 1"); comb_pens.push(red);
combinations.push("cuts:1,5"); comb_labels.push("cuts: 1, 3"); comb_pens.push(blue);
combinations.push("cuts:1,5,6"); comb_labels.push("cuts: 1, 3, 4"); comb_pens.push(heavygreen);
combinations.push("cuts:1,5,6,7"); comb_labels.push("cuts: 1, 3, 4, 5"); comb_pens.push(magenta);

MakeComparison("$\theta_y^{*R} - \theta_y^{*L}$", 1e6, "\mu rad", "cut 2/h_cq2", 50, 3.3, 50, 10, combinations, comb_labels, comb_pens);

//--------------------
NewRow();

string combinations[];
string comb_labels[];
pen comb_pens[];

combinations.push("no_cuts"); comb_labels.push("no cuts"); comb_pens.push(gray);
combinations.push("cuts:1"); comb_labels.push("cuts: 1"); comb_pens.push(red);
combinations.push("cuts:1,2"); comb_labels.push("cuts: 1, 2"); comb_pens.push(blue);
combinations.push("cuts:1,2,5"); comb_labels.push("cuts: 1, 2, 3"); comb_pens.push(heavygreen);
combinations.push("cuts:1,2,5,6"); comb_labels.push("cuts: 1, 2, 3, 4"); comb_pens.push(magenta);

MakeComparison("$x^{*R} - x^{*L}$", 1e3, "\mu m", "cut 7/h_cq7", 200, 8.7, 100, 20, combinations, comb_labels, comb_pens);
*/

GShipout(hSkip=5mm, vSkip=2mm, margin=0mm);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");

string datasets[] = { "DS4" };

string diagonals[] = { "45b_56t", "45t_56b" };
string dgn_labels[] = { "45 bottom -- 56 top", "45 top -- 56 bottom" };

string ffs[] = { "exp3" };

string object = "corr_final";
//string object = "iteration 1/corr";

string topDir = "../analysis/";

//xSizeDef = 6cm;
//ySizeDef = 4cm;
xSizeDef = 10cm;
ySizeDef = 6cm;

//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	//NewPad(false);
	//label("{\SetFontSizesXX "+datasets[dsi]+"}");

	NewPad("$|t|\ung{GeV^2}$", "unfolding correction $\cal U$",
		xTicks=LeftTicks(0.05, 0.01), yTicks=RightTicks(0.005, 0.001));

	int idx = 0;
	for (int dgi : diagonals.keys)
	{
		pen p = StdPen(++idx);

		AddToLegend(dgn_labels[dgi], p);

		string f = topDir + datasets[dsi] + "/unfolding_"+diagonals[dgi]+".root";
		string ff = topDir + datasets[dsi] + "/unfolding_fit_"+diagonals[dgi]+".root";

		for (int ffi : ffs.keys)
		{
			draw(rGetObj(f, "cf,eb/"+ffs[ffi]+"/"+object), "d0,eb", p);
		}
		
		//draw(rGetObj(ff, "ff"), p);
		
		//draw(rGetObj(topDir+"unfolding_reference.root", "cf,eb/exp3+exp4/corr_final"), "d0,eb", heavygreen+1pt, "old ref");
		
	}

	limits((0, 0.97), (0.2, 1.01), Crop);

	for (real x=0.0; x <= 0.2; x += 0.05)
		yaxis(XEquals(x, false), dotted);
	for (real y=0.97; y <= 1.01; y += 0.005)
		xaxis(YEquals(y, false), dotted);
		
	add(BuildLegend(lineLength=4mm, NE), point(NE), Fill(white));

	NewRow();
}

GShipout(margin=0mm);

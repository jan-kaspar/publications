import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string datasets[] = { "DS2b" };

string diagonals[] = { "45t_56b" };

string RPs[] = { "R_N" };
string RP_labels[] = { "right near" };
real RP_eff_cen[] = { 0.98 };

string topDir = "../analysis/";

real old_const_eff_45b[] = { 0, 0, 0, 0 };
real old_const_eff_45t[] = { 0, 0, 0, 0 };

xSizeDef = 10cm;
ySizeDef = 6cm;
yTicksDef = RightTicks(5., 1.);

int gx=0, gy=0;

TF1_points = 4;

//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	/*
	if (datasets[dsi] == "DS2")
	{
		old_const_eff_45b = new real[] { 96.4, 98.7, 98.0, 96.4 };
		old_const_eff_45t = new real[] { 96.5, 98.5, 98.5, 96.3 };
	}

	if (datasets[dsi] == "DS4")
	{
		old_const_eff_45b = new real[] { 97.0, 98.8, 98.7, 97.5 };
		old_const_eff_45t = new real[] { 97.2, 98.7, 98.9, 97.5 };
	}
	*/

	for (int dgi : diagonals.keys)
	{
		string f = topDir + datasets[dsi] + "/eff3outof4_fit.root";
		string opt = "vl,eb";
		
		/*
		++gy; gx = 0;
		for (int rpi : RPs.keys)
		{
			++gx;
			NewPad(false, gx, gy);
			label(RP_labels[rpi]);
		}
		*/
		
		//NewPad(false, -1, gy);
		//label(replace("\vbox{\SetFontSizesXX\hbox{dataset: "+datasets[dsi]+"}\hbox{diagonal: "+diagonals[dgi]+"}}", "_", "\_"));

		frame fLegend;

		++gy; gx = 0;
		for (int rpi : RPs.keys)
		{
			string d = diagonals[dgi] + "/" + RPs[rpi];

			++gx;
			NewPad("$\theta_y^*\ung{\mu rad}$", "efficiency, $1 - {\cal I}_{3/4}$ \ung{\%}", gx, gy);
			currentpad.xTicks = LeftTicks(20., 10.);
			currentpad.yTicks = RightTicks(1., 0.5);
			draw(scale(1e6, 100), rGetObj(f, d+"/h_refined_ratio.th_y"), opt, blue, "efficiency histogram");

			/*
			rObject fit = rGetObj(f, d+"/pol0");
			TF1_x_min = -inf; TF1_x_max = +inf;
			draw(scale(1e6, 100), fit, heavygreen+2pt, "const fit");
			TF1_x_min = 0; TF1_x_max = 120e-6;
			draw(scale(1e6, 100), fit, heavygreen+dashed);
			*/

			rObject fit = rGetObj(f, d+"/pol1");
			TF1_x_min = -inf; TF1_x_max = +inf;
			draw(scale(1e6, 100), fit, red+2pt, "linear fit");
			TF1_x_min = 0; TF1_x_max = 120e-6;
			draw(scale(1e6, 100), fit, red+dashed);

			/*
			real old_const_eff = 0;
			if (diagonals[dgi] == "45b_56t")
				old_const_eff = old_const_eff_45b[rpi];
			else 
				old_const_eff = old_const_eff_45t[rpi];

			draw((0, old_const_eff)--(100, old_const_eff), heavygreen+2pt, "old constant fit");
			*/

			real y = 100*RP_eff_cen[rpi] - 1.5;

			string slope_label = format("slope = ($%#.1f$", fit.rExec("GetParameter", 1))
				+ format("$\pm %#.1f) \un{rad^{-1}}$", fit.rExec("GetParError", 1));
			label(slope_label, (60, y), red, Fill(white+opacity(0.8)));

			limits((0, 100*RP_eff_cen[rpi] - 2), (110, 100*RP_eff_cen[rpi] + 2), Crop);
			fLegend = BuildLegend();

			for (real x = 0; x <= 110; x += 20)
				yaxis(XEquals(x, false), dotted);

			for (real y = 96; y <= 100; y += 1)
				xaxis(YEquals(y, false), dotted);
		}

		/*
		if (dgi == 0)
		{
			++gx;
			NewPad(false, gx, gy);
			add(fLegend);
		}
		*/
	}
}

GShipout(margin=0pt);

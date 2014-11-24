import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string datasets[] = { "DS4" };
string diagonals[] = { "45b_56t" };

string RPs[] = { "L_F" };
string RP_labels[] = { "left far" };

string topDir = "../analysis/";

xSizeDef = 6.5cm;
ySizeDef = 4cm;

int gx=0, gy=0;

//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	for (int dgi : diagonals.keys)
	{
		string f = topDir + datasets[dsi] + "/eff3outof4_details_fit.root";
		real sgn = (diagonals[dgi] == "45b_56t") ? +1 : -1;
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
			NewPad("$\theta_y^*\ung{\mu rad}$", "efficiency, $1 - {\cal I_{\rm 3/4}}$\ung{\%}", gx, gy);
			currentpad.yTicks = RightTicks(0.5, 0.1);
			draw(scale(sgn, 100), rGetObj(f, d+"/th_y : rel"), opt, blue, "efficiency histogram");

			rObject fit = rGetObj(f, d+"/th_y : rel|ff");
			TF1_x_min = -inf; TF1_x_max = +inf;
			draw(scale(sgn, 100), fit, red+2pt, "linear fit");
			TF1_x_min = -100; TF1_x_max = 110;
			draw(scale(sgn, 100), fit, red+dashed);

			string slope_label = format("slope = ($%#.1f$", fit.rExec("GetParameter", 1)*1e6)
				+ format("$\pm %#.1f) \un{rad^{-1}}$", fit.rExec("GetParError", 1)*1e6);

			label(slope_label, (65, 97.5), red, Fill(white));

			limits((20, 96), (110, 98), Crop);

			for (real x = 20; x <= 110; x += 20)
				yaxis(XEquals(x, false), dotted);
			for (real y = 96; y <= 98; y += 0.5)
				xaxis(YEquals(y, false), dotted);

			fLegend = BuildLegend();
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

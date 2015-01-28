import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");

string topDir = "../analysis/";

string datasets[] = { "DS4" };
real t_min[] = { 0.027 };

string dgns[] = { "45b_56t" };
string dgn_labels[] = { "45b -- 56t" };

//xSizeDef = 6cm;
//ySizeDef = 5cm;
xSizeDef = 10cm;
ySizeDef = 6cm;

//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	string dataset = datasets[dsi];

	for (int dgi : dgns.keys)
	{
		string dgn = dgns[dgi];
		string f = topDir+dataset+"/distributions_" + dgn + ".root";
		
		NewRow();

		//NewPad(false);
		//label("\vbox{\SetFontSizesXX\hbox{"+dataset+"}\hbox{"+dgn_labels[dgi]+"}}");

		/*
		NewPad("$|t_y|\ung{GeV^2}$", "correction factor", yTicks=RightTicks(0.2, 0.1));
		scale(Linear, Linear);
		TH1_x_min = 3e-4;
		draw(rGetObj(f, "acceptance correction/p_t_ub_div_corr"), "ob", blue+1pt, "divergence");
		limits((0, 0.9), (0.2, 2), Crop);
		AttachLegend(NE, NE);
		for (real y = 1.; y <= 2.; y += 0.2)
			xaxis(YEquals(y, false), dotted);
		*/
		
		NewPad("$|t|\ung{GeV^2}$", "acceptance correction ${\cal A}$");
		currentpad.xTicks = LeftTicks(0.05, 0.01);
		//scale(Linear, Log);
		//draw(rGetObj(f, "acceptance correction/ob/p_t_phi_corr"), "d0,eb", heavygreen, "phi");
		draw(rGetObj(f, "acceptance correction/ob/p_t_full_corr"), "d0,eb", red, "full = divergence * phi");
		limits((0, 2e0), (0.2, 7), Crop);
		//AttachLegend(NE, NE);
		yaxis(XEquals(t_min[dsi], false), dashed);

		for (real x = 0; x < 0.2; x += 0.05)
			yaxis(XEquals(x, false), dotted);

		for (real y = 2; y <= 7; y += 1)
			xaxis(YEquals(y, false), dotted);
		
		/*
		NewPad("$|t|\ung{GeV^2}$", "\vbox{\hbox{correction factor}\hbox{(mean $\pm$ std.~dev.~per bin)}}", xTicks=LeftTicks(0.02, 0.005), yTicks=RightTicks(1., 0.5));
		scale(Linear, Linear);
		draw(rGetObj(f, "acceptance correction/ob/p_t_phi_corr"), "d0,eb", heavygreen, "phi");
		draw(rGetObj(f, "acceptance correction/ob/p_t_full_corr"), "d0,eb", red, "full");
		limits((0, 2), (0.1, 10), Crop);
		AttachLegend(NW, NW);
		xaxis(YEquals(5, false), dotted);
		yaxis(XEquals(t_min[dsi], false), dotted);
		*/
		
		/*
		NewPad("$|t|\ung{GeV^2}$", "acceptance");
		//scale(Linear, Log);
		draw(rGetObj(f, "acceptance correction/ob/p_t_full_acc"), "d0,eb,vl", magenta, "acceptance");
		limits((0, 0), (0.25, 1), Crop);
		AttachLegend(NE, NE);
		*/
	}
}

GShipout(margin=0pt);

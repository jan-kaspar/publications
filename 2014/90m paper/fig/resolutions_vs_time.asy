import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");

string datasets[] = { "DS4" };

string diagonals[] = { "45b_56t", "45t_56b" };
string dgn_labels[] = { "45 bottom -- 56 top", "45 top -- 56 bottom" };
pen dgn_pens[] = { blue, red };

string topDir = "../analysis/";

xSizeDef = 6.5cm;
ySizeDef = 2.5cm;

TGraph_errorBar = None;

transform swToHours = scale(1/3600, 1);
transform paperTimeShift = shift(-19.5, 0);

//----------------------------------------------------------------------------------------------------

NewPad("", "$\theta_x^*$ resolution $\ung{\mu rad}$");
currentpad.xTicks = LeftTicks("%",  2., 1.);
currentpad.yTicks = RightTicks(0.2, 0.1);

for (int dsi : datasets.keys)
{
	for (int dgni : diagonals.keys)
	{
		draw(paperTimeShift * swToHours*scale(1, 0.5e6),
			rGetObj(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "time dependences/gRMS_diffLR_th_x_vs_time"), "p,eb,d0",
			dgn_pens[dgni], mCi+1pt+dgn_pens[dgni], dgn_labels[dgni]);

		/*
		rObject fit = rGetObj(topDir+"resolutions/fit_"+datasets[dsi]+".root", diagonals[dgni]+"/x/g_fit");
		draw(shift(0, +0.2)*swToHours*scale(1, 1e6), fit, "l", black+dashed);
		draw(shift(0,  0.0)*swToHours*scale(1, 1e6), fit, "l", black+1pt);
		draw(shift(0, -0.2)*swToHours*scale(1, 1e6), fit, "l", black+dashed);
		*/
	}
}

limits((0, 4), (12, 5), Crop);
for (real y=4; y <= 5; y += 0.2)
	xaxis(YEquals(y, false), dotted);

//----------------

NewRow();
NewPad("time $\ung{h}$", "$\theta_y^*$ resolution $\ung{\mu rad}$");
currentpad.xTicks = LeftTicks(2., 1.);
currentpad.yTicks = RightTicks(0.1, 0.02);

for (int dsi : datasets.keys)
{
	currentpicture.legend.delete();

	for (int dgni : diagonals.keys)
	{
		draw(paperTimeShift * swToHours*scale(1, 0.5e6),
			rGetObj(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "time dependences/gRMS_diffLR_th_y_vs_time"), "p,eb,d0",
			dgn_pens[dgni], mCi+1pt+dgn_pens[dgni], dgn_labels[dgni]);

		/*
		rObject fit = rGetObj(topDir+"resolutions/fit_"+datasets[dsi]+".root", diagonals[dgni]+"/y/g_fit");
		draw(shift(0, +0.05)*swToHours*scale(1, 1e6), fit, "l", black+dashed);
		draw(shift(0,  0.00)*swToHours*scale(1, 1e6), fit, "l", black+1pt);
		draw(shift(0, -0.05)*swToHours*scale(1, 1e6), fit, "l", black+dashed);
		*/
	}
}

limits((0, 1.5), (12, 1.8), Crop);
for (real y=1.5; y <= 1.8; y += 0.1)
	xaxis(YEquals(y, false), dotted);

add(BuildLegend(vSkip=1mm, lineLength=2mm, NW), point(NW), Fill(white));


GShipout(margin=0mm, vSkip=0pt);

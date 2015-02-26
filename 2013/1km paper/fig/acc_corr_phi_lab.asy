import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis/";

//string dataSets[] = { "DS2a", "DS2b" };
string dataSets[] = { "DS2b" };

TH2_palette = Gradient(white, blue, heavygreen, yellow, red);

xSizeDef = 6cm;
ySizeDef = 6cm;

//----------------------------------------------------------------------------------------------------

real cut_th_x_low_top = -50, cut_th_x_high_top = 80;
real cut_th_y_low_top = 13.0, cut_th_y_high_top = +100 - 1.;

real cut_th_x_low_bot = -50, cut_th_x_high_bot = 80;
real cut_th_y_low_bot = -6.5, cut_th_y_high_bot = -100 + 1.;

void DrawAcceptedArcs(real th)
{
	real dphi = 360. / 1000;
	bool inside = false;
	real phi_start;
	for (real phi = 0; phi < 360; phi += dphi)
	{
		real x = th * Cos(phi);
		real y = th * Sin(phi);

		bool p_in = false;
		if (x > cut_th_x_low_top && x < cut_th_x_high_top && y > cut_th_y_low_top && y < cut_th_y_high_top)
			p_in = true;
		if (x > cut_th_x_low_bot && x < cut_th_x_high_bot && y < cut_th_y_low_bot && y > cut_th_y_high_bot)
			p_in = true;

		if (!inside && p_in)
		{
			phi_start = phi;
			inside = true;
		}

		if (inside && !p_in)
		{
			inside = false;
			real phi_end = phi - dphi;
			draw(arc((0, 0), th, phi_start, phi_end), black+1pt);
		}
	}
}

//----------------------------------------------------------------------------------------------------

void DrawFullArc(real th)
{
	draw(scale(th)*unitcircle, dotted);
	label(rotate(-90)*Label(format("\SmallerFonts $%.0f$", th)), (th, 4), 0.5E, Fill(white+opacity(0.8)));
}

//----------------------------------------------------------------------------------------------------

for (int dsi : dataSets.keys)
{
	NewPad("$\theta_x^{*}\ung{\mu rad}$", "$\theta_y^{*}\ung{\mu rad}$");
	scale(Linear, Linear, Log);
	
	// full arcs
	label("$\theta^*\!=$", (20, 4), 0.5W, Fill(white+opacity(0.8)));
	DrawFullArc(20);
	DrawFullArc(60);
	DrawFullArc(100);
	label(rotate(-90)*Label("\SmallerFonts $\rm\mu rad$"), (165, 0), 0.5E, Fill(white+opacity(0.8)));

	/*
	label("\vbox{\hbox{detector}\hbox{edges}}", (-160, -30), SE, blue, Fill(white));
	draw((-120, -35)--(-130, cut_th_y_low_bot), blue, EndArrow());
	draw((-120, -35)--(-110, cut_th_y_low_top), blue, EndArrow());

	label("\vbox{\hbox{LHC}\hbox{appertures}}", (-190, 190), SE, red, Fill(white));
	draw((-180, 130)--(-160, cut_th_y_high_top), red, EndArrow);
	draw((-180, 130)--(-190, cut_th_y_high_bot), red, EndArrow);

	label("\vbox{\hbox{horiz.}\hbox{RPs}}", (200, -150), W, magenta, Fill(white));
	draw((130, -150)--(cut_th_x_high_bot, -140), magenta, EndArrow);
	draw((130, -150)--(cut_th_x_low_bot, -160), magenta, EndArrow);
	*/

	// data: 45 bottom - 56 top
	TH2_z_min = 7;
	TH2_z_max = 9.7;
	draw(scale(1e6, 1e6), rGetObj(topDir+dataSets[dsi]+"/distributions_45b_56t.root", "normalization/h_th_y_vs_th_x_normalized"), "def");
	
	// data: 45 top - 56 bottom
	TH2_z_min = 7;
	TH2_z_max = 9.7;
	draw(scale(1e6, 1e6), rGetObj(topDir+dataSets[dsi]+"/distributions_45t_56b.root", "normalization/h_th_y_vs_th_x_normalized"), "p");
	
	// accepted arcs
	DrawAcceptedArcs(20);
	DrawAcceptedArcs(60);
	DrawAcceptedArcs(100);

	// cut lines
	draw((-200, cut_th_y_low_top)--(+200, cut_th_y_low_top), blue+1pt);
	draw((-200, cut_th_y_low_bot)--(+200, cut_th_y_low_bot), blue+1pt);
	
	draw((-200, cut_th_y_high_top)--(+200, cut_th_y_high_top), red+1pt);
	draw((-200, cut_th_y_high_bot)--(+200, cut_th_y_high_bot), red+1pt);

	draw((cut_th_x_low_top , 0)--(cut_th_x_low_top , +200), magenta+1pt);
	draw((cut_th_x_low_bot , -200)--(cut_th_x_low_bot , 0), magenta+1pt);
	draw((cut_th_x_high_top, 0)--(cut_th_x_high_top, +200), magenta+1pt);
	draw((cut_th_x_high_bot, -200)--(cut_th_x_high_bot, 0), magenta+1pt);
	
	limits((-120, -120), (120, 120), Crop);
	//AttachLegend(dataSets[dsi]);
}

GShipout(margin=0pt);

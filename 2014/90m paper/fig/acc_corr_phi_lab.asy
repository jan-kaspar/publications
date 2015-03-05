import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string top_dir = "../analysis/";

string dataSets[] = { "DS4" };

TH2_palette = Gradient(white, blue, heavygreen, yellow, red);

TH2_paletteBarSpacing = 0.02;
TH2_paletteBarWidth = 0.07;

ySizeDef = 6cm;
xSizeDef = ySizeDef * 190/160;

//----------------------------------------------------------------------------------------------------

real cut_th_x_low_top = -250, cut_th_x_high_top = 250;
real cut_th_y_low_top = 33., cut_th_y_high_top = +100;

real cut_th_x_low_bot = -250, cut_th_x_high_bot = 250;
real cut_th_y_low_bot = -33., cut_th_y_high_bot = -105;

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
	label(rotate(-90)*Label(format("$%.0f$", th)), (th, 0), 0.5E, Fill(white+opacity(0.8)));
	draw((-200, cut_th_y_low_top)--(+200, cut_th_y_low_top), blue+1pt);
	draw((-200, cut_th_y_low_bot)--(+200, cut_th_y_low_bot), blue+1pt);
}

//----------------------------------------------------------------------------------------------------

for (int dsi : dataSets.keys)
{
	NewPad("$\theta_x^{*}\ung{\mu rad}$", "$\theta_y^{*}\ung{\mu rad}$", axesAbove = true);
	scale(Linear, Linear, Log);
	currentpad.xTicks = LeftTicks(50., 10.);
	currentpad.yTicks = RightTicks(50., 10.);
	
	label("$\rightarrow$", (50, 0), 0.5W, Fill(white+opacity(0.8)));
	label(rotate(-90)*Label("$\theta^*$"), (30, 0), 0.5W);
	label(rotate(-90)*Label("$\rm [\mu rad]$"), (13, 0), 0.5W);
	DrawFullArc(50);
	DrawFullArc(100);
	DrawFullArc(150);

	//string obj_name = "normalization/h_th_y_vs_th_x_normalized";
	string obj_name = "acceptance correction/h_th_y_vs_th_x_after";

	TH2_z_min = 0;
	TH2_z_max = 3.7;

	// 45 bottom - 56 top
	draw(scale(1e6, 1e6), rGetObj(top_dir+"/"+dataSets[dsi]+"/distributions_45b_56t.root", obj_name), "def");
	
	// 45 top - 56 bottom
	draw(scale(1e6, 1e6), rGetObj(top_dir+"/"+dataSets[dsi]+"/distributions_45t_56b.root", obj_name), "p");
	
	draw((-200, cut_th_y_low_top)--(+200, cut_th_y_low_top), magenta+1pt);
	draw((-200, cut_th_y_low_bot)--(+200, cut_th_y_low_bot), magenta+1pt);
	
	draw((-200, cut_th_y_high_top)--(+200, cut_th_y_high_top), red+1pt);
	draw((-200, cut_th_y_high_bot)--(+200, cut_th_y_high_bot), red+1pt);

	/*
	draw((cut_th_x_low_top , 0)--(cut_th_x_low_top , +200), magenta+1pt);
	draw((cut_th_x_low_bot , -200)--(cut_th_x_low_bot , 0), magenta+1pt);
	draw((cut_th_x_high_top, 0)--(cut_th_x_high_top, +200), magenta+1pt);
	draw((cut_th_x_high_bot, -200)--(cut_th_x_high_bot, 0), magenta+1pt);
	*/
	
	DrawAcceptedArcs(50);
	DrawAcceptedArcs(100);
	DrawAcceptedArcs(150);

	/*
	label("\vbox{\hbox{detector}\hbox{edges}}", (-160, -130), SE, blue, Fill(white));
	draw((-120, -135)--(-130, cut_th_y_low_bot), blue, EndArrow());
	draw((-120, -135)--(-110, cut_th_y_low_top), blue, EndArrow());

	label("\vbox{\hbox{LHC}\hbox{appertures}}", (-190, 190), SE, red, Fill(white));
	draw((-180, 130)--(-160, cut_th_y_high_top), red, EndArrow);
	draw((-180, 130)--(-190, cut_th_y_high_bot), red, EndArrow);
	*/

	/*
	label("\vbox{\hbox{horiz.}\hbox{RPs}}", (200, -150), W, magenta, Fill(white));
	draw((130, -150)--(cut_th_x_high_bot, -140), magenta, EndArrow);
	draw((130, -150)--(cut_th_x_low_bot, -160), magenta, EndArrow);
	*/
	
	limits((-190, -160), (190, 160), Crop);
	//AttachLegend(dataSets[dsi]);
}

GShipout(margin=0pt);

import root;
import pad_layout;

xSizeDef = 6.5cm;
ySizeDef = 4.8cm;

drawGridDef = false;

pen p_Nico = blue, p_Durh = heavygreen, p_Durh_odd = p_Durh+dashed;
mark m_Nico = mTU + 2pt + blue, m_Durh = mTD + 2pt + heavygreen;

//----------------------------------------------------------------------------------------------------

// fine shift
real fsh=0;

void DrawPoint(real W, real si, real em, real ep=em, pen col=red, marker m)
{
	col += squarecap;

	draw(shift(fsh, 0)*(Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);

	// reset fine shift
	fsh = 0;
}

//----------------------------------------------------------------------------------------------------

void DrawAxes(real y_label)
{
	yaxis(XEquals(0.546e3, false), dotted + roundcap);
	yaxis(XEquals(0.9e3, false), dotted + roundcap);
	yaxis(XEquals(1.8e3, false), dotted + roundcap);
	yaxis(XEquals(2.76e3, false), dotted + roundcap);
	yaxis(XEquals(7e3, false), dotted + roundcap);
	yaxis(XEquals(8e3, false), dotted + roundcap);
	yaxis(XEquals(13e3, false), dotted + roundcap);

	label(rotate(90)*Label("\SmallerFonts$0.546\un{TeV}$"), Scale((0.546e3, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$0.9\un{TeV}$"), Scale((0.9e3, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$1.8\un{TeV}$"), Scale((1.8e3, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$2.76\un{TeV}$"), Scale((2.76e3, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$7\un{TeV}$"), Scale((7e3-300, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$8\un{TeV}$"), Scale((8e3+300, y_label)), Fill(white));
	label(rotate(90)*Label("\SmallerFonts$13\un{TeV}$"), Scale((13e3, y_label)), Fill(white));
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

TGraph_x_max = 1.1e5;

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm pp}\ung{mb}$");
currentpad.drawGridY = true;
currentpad.yTicks = RightTicks(10., 5.);
scale(Log, Linear);

// Nicolescu's 2017 paper
draw(Scale((2.76e3, 83.66))--Scale((7e3, 98.76))--Scale((8e3, 101.09))--Scale((13e3, 109.92)), nullpen, m_Nico);

draw(RootGetObject("model_2017_ex.root", "g_si_tot_pp_vs_s"), red);
draw(RootGetObject("model_2017.root", "g_si_tot_pp_vs_s"), heavygreen+dashed);

limits((1e1, 40), (2e4, 120), Crop);

DrawAxes(50);


//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{GeV}$", "$\rh_{\rm pp}$");
currentpad.drawGridY = true;
currentpad.yTicks = RightTicks(0.01, 0.005);
scale(Log, Linear);

// Nicolescu's 2017 paper
draw(Scale((2.76e3, 0.123))--Scale((7e3, 0.109))--Scale((8e3, 0.106))--Scale((13e3, 0.0976)), nullpen, "Table 3", m_Nico);

AddToLegend("<reproductions by Jan:");

draw(RootGetObject("model_2017_ex.root", "g_rho_pp_vs_s"), red, "exactly according to Eq.~(15)");
draw(RootGetObject("model_2017.root", "g_rho_pp_vs_s"), heavygreen+dashed, "Eq.~(15) without the leading factor $1/m^2$");

limits((1e1, 0.06), (2e4, 0.16), Crop);

DrawAxes(0.075);

AttachLegend(NW, NE);

//----------------------------------------------------------------------------------------------------

GShipout(margin=1mm, hSkip=1mm);

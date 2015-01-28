import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");

TH2_palette = Gradient(white, blue, heavygreen, yellow, red);


string dataset = "DS4";

string diagonal = "45t_56b";

string topDir = "../analysis/";

//xSizeDef = 5cm;
//ySizeDef = 4.5cm;
xSizeDef = 5cm;
ySizeDef = 5cm;

int cuts[] = { 1, 2, 5, 6, 9 };

string cut_desc[] = { "cut 1", "cut 2", "", "", "cut 3", "cut 4", "", "", "cut 5" };

real scale_x[] = { 1e6, 1e6, 1e6, 1e6, 1e0, 1e0, 1e6, 1e0, 1e3 };
real scale_y[] = { 1e6, 1e6, 1e0, 1e0, 1e0, 1e0, 1e0, 1e0, 1e3 };

string label_x[] = { "$\theta_x^{*\rm R}\ung{\mu rad}$", "$\theta_y^{*\rm R}\ung{\mu rad}$", "$\theta_x^{*\rm R}\ung{\mu rad}$", "$\theta_x^{*\rm L}\ung{\mu rad}$", "$y^{\rm R,N}\ung{mm}$", "$y^{\rm L,N}\ung{mm}$", "$\theta_x^*\ung{\mu rad}$", "bla", "$x^{*\rm R}\ung{\mu m}$" };
string label_y[] = { "$\theta_x^{*\rm L}\ung{\mu rad}$", "$\theta_y^{*\rm L}\ung{\mu rad}$", "$x^{*\rm R}\ung{mm}$", "$x^{*\rm L}\ung{mm}$", "$y^{\rm R,F} - y^{\rm R,N}\ung{mm}$", "$y^{\rm L,F} - y^{\rm L,N}\ung{mm}$", "$\De^{\rm R-L} x^*\ung{mm}$", "bla", "$x^{*\rm L}\ung{\mu m}$" };
string label_cut[] = { "$\De^{R-L} \theta_x^{*}\ung{\mu rad}$", "$\De^{R-L} \theta_y^{*}\ung{\mu rad}$", "$x^{*R}\ung{mm}$", "$x^{*L}\ung{mm}$", "$cq5$", "$cq6$", "$cq7$", "cq8",  "vtx R - vtx L"};

real lim_x_low[] = { -400, -120, 0, 0, -30,   5, -200, 0, -800 };
real lim_x_high[] = { +400, -20, 1, 1, -5,   +30,  +200, 1, 800 };

real lim_y_low[] = { -400, -120, 0, 0,  -3,  0.5, -0.2, 0, -800 };
real lim_y_high[] = { +400, -20, 1, 1,  -0.5, +3,  +0.2, 1, 800 };

int en = 0;
for (int ci : cuts.keys)
{
	int cut = cuts[ci];
	int idx = cut - 1;

	write("idx = ", idx);

	string f = topDir+dataset+"/distributions_" + diagonal + ".root";
	
	if ((en % 2) == 0)
		NewRow();

	NewPad(label_x[idx], label_y[idx], axesAbove=true);
	scale(Linear, Linear, Log);
	string objC = format("elastic cuts/cut %i", cut) + format("/plot_before_cq%i", cut);
	draw(scale(scale_x[idx], scale_y[idx]), rGetObj(f, objC+"#0"));
	draw(scale(scale_x[idx], scale_y[idx]), rGetObj(f, objC+"#1"), black+1pt);
	draw(scale(scale_x[idx], scale_y[idx]), rGetObj(f, objC+"#2"), black+1pt);

	limits((lim_x_low[idx], lim_y_low[idx]), (lim_x_high[idx], lim_y_high[idx]), Crop);

	AttachLegend(cut_desc[idx], NW, NW);

	++en;
}

GShipout(hSkip=3mm, vSkip=2mm, margin=0mm);

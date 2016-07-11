import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis/";

TH2_palette = Gradient(blue, heavygreen, yellow, red);
TH2_paletteBarSpacing = 0.02;
TH2_paletteBarWidth = 0.07;

xSizeDef = 6.0cm;
ySizeDef = 6.0cm;

string datasets[] = { "DS2b" };

string dgns[] = { "45t_56b" };
//string dgns[] = { "45b_56t" };

int cuts[] = { 1, 2, 7 };

real scale_x[] = { 1e6, 1e6, 1e6, 1e6, 1e0, 1e0, 1e6 };
real scale_y[] = { 1e6, 1e6, 1e0, 1e0, 1e0, 1e0, 1e0 };

string label_x[] = { "$\theta_x^{*\rm R}\ung{\mu rad}$", "$\theta_y^{*\rm R}\ung{\mu rad}$", "$\theta_x^{*\rm R}\ung{\mu rad}$", "$\theta_x^{*\rm L}\ung{\mu rad}$", "$y^{\rm R,N}\ung{mm}$", "$y^{\rm L,N}\ung{mm}$", "$\theta_x^*\ung{\mu rad}$" };
string label_y[] = { "$\theta_x^{*\rm L}\ung{\mu rad}$", "$\theta_y^{*\rm L}\ung{\mu rad}$", "$x^{*\rm R}\ung{mm}$", "$x^{*\rm L}\ung{mm}$", "$y^{\rm R,F} - y^{\rm R,N}\ung{mm}$", "$y^{\rm L,F} - y^{\rm L,N}\ung{mm}$", "$x^{*\rm R} - x^{*\rm L}\ung{mm}$" };
string label_cut[] = { "$\De^{R-L} \theta_x^{*}\ung{\mu rad}$", "$\De^{R-L} \theta_y^{*}\ung{\mu rad}$", "$x^{*R}\ung{mm}$", "$x^{*L}\ung{mm}$", "$cq5$", "$cq6$", "$cq7$" };

real lim_x_low[] = { -200, -120, 0, 0, -300, 0, -200 };
real lim_x_high[] = { +200, 0, 100, +150, +300, +150, +200 };

real lim_y_low[] = { -200, -120, 0, -30, -10, 0, -1.5 };
real lim_y_high[] = { +200, +0, +150, +30, +10, 100, +1.5 };

string paper_labels[] = { "1", "2", "", "", "", "", "3" };

for (int ci : cuts.keys)
{
	int cut = cuts[ci];
	int idx = cut - 1;

	write("idx = ", idx);
	
	NewRow();

	for (int dsi : datasets.keys)
	{
		string dataset = datasets[dsi];

		for (int dgi : dgns.keys)
		{
			string dgn = dgns[dgi];
			string f = topDir+dataset+"/distributions_" + dgn + ".root";

			NewPad(label_x[idx], label_y[idx]);
			scale(Linear, Linear, Log);
			string objC = format("elastic cuts/cut %i", cut) + format("/plot_before_cq%i", cut);
			draw(scale(scale_x[idx], scale_y[idx]), RootGetObject(f, objC+"#0"));
			draw(scale(scale_x[idx], scale_y[idx]), RootGetObject(f, objC+"#1"), black+1pt);
			draw(scale(scale_x[idx], scale_y[idx]), RootGetObject(f, objC+"#2"), black+1pt);
			limits((lim_x_low[idx], lim_y_low[idx]), (lim_x_high[idx], lim_y_high[idx]), Crop);

			AttachLegend("cut " + paper_labels[idx], NW, NW);
		}
	}
}

GShipout(margin=0pt, hSkip=3mm, vSkip=3mm);

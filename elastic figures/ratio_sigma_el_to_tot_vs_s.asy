import root;
import pad_layout;
import common_code;

drawGridDef = false;

//----------------------------------------------------------------------------------------------------

real size = 13cm;
NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el} / \si_{\rm tot}\ung{\%}$", size, size*2/3);
currentpad.yTicks=RightTicks(Step=2, step=1);
currentpad.drawGridY = true;
scale(Log, Linear);

// -------------------- fits --------------------

// p-anti p
DrawFitUncBand(yscale(100), "rat_si_el_tot_p_ap", black+opacity(0.1));
DrawFit(yscale(100), "rat_si_el_tot_p_ap", linetype(new real[] {8, 8}, offset=8));

// p-p
DrawFitUncBand(yscale(100), "rat_si_el_tot_p_p", black+opacity(0.1));
DrawFit(yscale(100), "rat_si_el_tot_p_p", linetype(new real[] {8, 8}, offset=7));

// -------------------- PDG --------------------
DrawElToTotDataSet("pdg/pbarp_total.dat", "pdg/pbarp_elastic.dat", heavygreen+0.2pt, mTU+2pt+false+heavygreen);
DrawElToTotDataSet("pdg/pp_total.dat", "pdg/pp_elastic.dat", blue+0.2pt, mTD+2pt+true+blue);

// -------------------- LHC, 2.76 TeV --------------------

// TOTEM, not yet published
fsh =   0.0; DrawPoint(2.76e3, 25.7, 1.1, 1.1, red, mCi+true+2pt+red);

// -------------------- LHC, 7 TeV --------------------

// TOTEM
fsh = -0.01; DrawPoint(7e3, 25.8, 0.56, 0.56, red, mCi+true+2pt+red);

// ATLAS-ALFA
fsh = +0.01; DrawPoint(7e3, 25.2, 0.4, 0.4, blue, mTL+false+2pt+blue);

// -------------------- LHC, 8 TeV --------------------

// TOTEM
fsh =   0.0; DrawPoint(8e3, 26.6, 0.6, 0.6, red, mCi+true+2pt+red);

// ATLAS-ALFA
fsh = +0.01; DrawPoint(8e3, 25.32, 0.47, 0.47, blue, mTL+false+2pt+blue);

// -------------------- LHC, 13 TeV --------------------

// TOTEM, preliminary, not yet published
fsh = 0.0; DrawPoint(13e3, 28.1, 0.9, red, mCi+true+2pt+red);

// -------------------- limits --------------------

limits((1e1, 15), (1e5, 30), Crop);

// -------------------- axes --------------------

yaxis(XEquals(0.546e3, false), dotted + roundcap);
yaxis(XEquals(0.9e3, false), dotted + roundcap);
yaxis(XEquals(1.8e3, false), dotted + roundcap);
yaxis(XEquals(2.76e3, false), dotted + roundcap);
yaxis(XEquals(7e3, false), dotted + roundcap);
yaxis(XEquals(8e3, false), dotted + roundcap);
yaxis(XEquals(13e3, false), dotted + roundcap);

real y_label = 18;
label(rotate(90)*Label("\SmallerFonts$0.546\un{TeV}$"), Scale((0.546e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$0.9\un{TeV}$"), Scale((0.9e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$1.8\un{TeV}$"), Scale((1.8e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$2.76\un{TeV}$"), Scale((2.76e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$7\un{TeV}$"), Scale((7e3-300, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$8\un{TeV}$"), Scale((8e3+300, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$13\un{TeV}$"), Scale((13e3, y_label)), Fill(white));


// -------------------- legend --------------------

AddToLegend("$\rm \bar pp$, PDG", heavygreen, mTU+false+3pt+heavygreen);
AddToLegend("$\rm pp$, PDG", blue, mTD+false+3pt+blue);

AddToLegend("{\bf TOTEM}", red, mCi+true+2.5pt+red);
AddToLegend("ATLAS/ALFA", blue, mTL+false+3pt+blue);
//AddToLegend("$\displaystyle\hbox{\strut $\si_{\rm el}$ fit by TOTEM}\over\hbox{\strut $\si_{\rm tot}$ fits by COMPETE ($\rm RRP_{\rm nf}L2_{\rm u}$)}$", dashed);
AddToLegend("ratio of $\si_{\rm el}$ fit by TOTEM", dashed);
AddToLegend("and $\si_{\rm tot}$ fits by COMPETE");
AddToLegend("(pre-LHC model $\rm RRP_{\rm nf}L2_{\rm u}$)");

AttachLegend(BuildLegend(lineLength=8mm, NW), NW);

GShipout();

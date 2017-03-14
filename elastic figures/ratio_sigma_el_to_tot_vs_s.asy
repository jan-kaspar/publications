import root;
import pad_layout;
import common_code;

//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el} / \si_{\rm tot}\ung{\%}$", yTicks=RightTicks(Step=2, step=1), 8cm, 8cm);
scale(Log, Linear);

// -------------------- fits --------------------

// p-anti p
compete_fit_sign = +1;
draw(graph(RatioSigmaElToTotFit, 10, 1e5, 100), black+dashed);

// p-p
compete_fit_sign = -1;
draw(graph(RatioSigmaElToTotFit, 10, 1e5, 100), black+dashed);

// -------------------- PDG --------------------
DrawElToTotDataSet("pdg/pbarp_total.dat", "pdg/pbarp_elastic.dat", heavygreen+0.2pt, mTU+2pt+false+heavygreen);
DrawElToTotDataSet("pdg/pp_total.dat", "pdg/pp_elastic.dat", blue+0.2pt, mTD+2pt+true+blue);

// -------------------- LHC, 2.76 TeV --------------------

// TOTEM
fsh =   0.0; DrawPoint(2.76e3, 25.7, 1.9, 1.9, red, mCi+true+2pt+red);

// -------------------- LHC, 7 TeV --------------------

// TOTEM
fsh = -0.01; DrawPoint(7e3, 25.8, 0.56, 0.56, red, mCi+true+2pt+red);

// ATLAS-ALFA
fsh = +0.01; DrawPoint(7e3, 25.2, 0.4, 0.4, blue, mSq+true+2pt+blue);

// -------------------- LHC, 8 TeV --------------------

// TOTEM
fsh =   0.0; DrawPoint(8e3, 26.6, 0.6, 0.6, red, mCi+true+2pt+red);

// ATLAS-ALFA
fsh = +0.01; DrawPoint(8e3, 25.32, 0.47, 0.47, blue, mSq+true+2pt+blue);


// -------------------- legend --------------------
AddToLegend("$\rm pp$, PDG", blue, mTD+false+2pt+blue);
AddToLegend("$\rm \bar pp$, PDG", heavygreen, mTU+false+2pt+heavygreen);
AddToLegend("TOTEM", red, mCi+true+2pt+red);
AddToLegend("ATLAS-ALFA", blue, mSq+true+2pt+blue);
AddToLegend("fits from EPL 101 (2013) 21004", dashed);

limits((1e1, 15), (1e4, 30), Crop);
AttachLegend(BuildLegend(lineLength=8mm, NW), NW);

GShipout();

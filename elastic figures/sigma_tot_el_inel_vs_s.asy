import root;
import pad_layout;
import common_code;

drawGridDef = false;

texpreamble("\def\ln{\mathop{\rm ln}}");
//texpreamble("\SelectCMFonts\LoadFonts\rm");
//texpreamble("\def\ung#1{\quad{\rm[#1]}}");

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el}$ (green), $\si_{\rm inel}$ (blue) and  $\si_{\rm tot}$ (red) $\ung{mb}$", 14cm, 10cm);

scale(Log, Linear);

// -------------------- fits --------------------

// p-anti p
compete_fit_sign = +1;
draw(graph(SigmaTotFit, 10, 1e5, 100), black);
draw(graph(SigmaInelFit, 10, 1e5, 100), dashdotted);

// pp
compete_fit_sign = -1;
draw(graph(SigmaTotFit, 10, 1e5, 100), black);
draw(graph(SigmaInelFit, 10, 1e5, 100), dashdotted);

draw(graph(SigmaElFit, 10, 1e5, 100), dashed);

// -------------------- PDG --------------------

// PDG sigma tot data
DrawDataSet("pdg/pbarp_total.dat", red+0.2pt, mTU);
DrawDataSet("pdg/pp_total.dat", red+0.2pt, mTD);

// PDG sigma el data
DrawDataSet("pdg/pbarp_elastic.dat", heavygreen+0.2pt, mTU);
DrawDataSet("pdg/pp_elastic.dat", heavygreen+0.2pt, mTD);

// PDG sigma inel data
DrawInelasticDataSet("pdg/pbarp_total.dat", "pdg/pbarp_elastic.dat", blue+0.2pt, mTU);
DrawInelasticDataSet("pdg/pp_total.dat", "pdg/pp_elastic.dat", blue+0.2pt, mTD);

// PDG Labels
AddToLegend("$\rm \bar pp$ (PDG)", nullpen, mTU+false+3pt);
AddToLegend("$\rm pp$ (PDG)", nullpen, mTD+false+3pt);

// -------------------- cosmics --------------------

// Auger
DrawPointE(57e3-200, 6e3, 6e3, 92, 14.8, 13.4, blue, mSq+false+1.5pt+blue);
DrawPointE(57e3+200, 6e3, 6e3, 133, 28.7, 26.7, red, mSq+false+1.5pt+red);

// -------------------- LHC, 2.76 TeV --------------------

// ALICE
DrawPointE(2.76e3-100, 0, 0, 62.8, 4.2, 2.7, blue, mSt+false+1.5pt+blue);

// TOTEM
fsh = 0; DrawPoint(2.76e3, 84.7, 3.3, 3.3, red+0.8pt, mCi+true+1.8pt+red);					// total
fsh = 0; DrawPoint(2.76e3, 62.8, 2.9, 2.9, blue+0.8pt, mCi+true+1.8pt+blue);				// inelastic
fsh = 0; DrawPoint(2.76e3, 21.8, 1.4, 1.4, heavygreen+0.8pt, mCi+true+1.8pt+heavygreen);	// elastic

// -------------------- LHC, 7 TeV --------------------

// ALICE
DrawPointE(7e3-400, 0, 0, 73.1, 5.3, 3.3, blue, mSt+false+1.5pt+blue);

// ATLAS
//DrawPointE(7e3-150, 0, 0, 69.1, 7.3, 7.3, blue, mTL+false+1.5pt+blue);

// ATLAS - ALFA
DrawPointE(7e3-150, 0, 0, 95.35, 1.36, 1.36, red, mTL+false+1.7pt+red);					// total
DrawPointE(7e3-150, 0, 0, 71.34, 0.90, 0.90, blue, mTL+false+1.7pt+blue);				// inelastic
DrawPointE(7e3-150, 0, 0, 24.00, 0.60, 0.60, heavygreen, mTL+false+1.7pt+heavygreen);	// elastic

// CMS
DrawPointE(7e3+150, 0, 0, 68.0, 5.1, 5.1, blue, mTR+false+1.5pt+blue);					// CMS-PAS-FWD-11-001
//DrawPointE(7e3+300, 0, 0, 64.5, 3.4, 3.4, blue, mTR+false+1.5pt+blue);				// CMS-PAS-QCD-11-002	

// TOTEM
fsh = 0; DrawPointRel(7e3, 98.1, 2.4, red+0.8pt, mCi+true+1.8pt+red);					// total
fsh = 0; DrawPointRel(7e3, 72.9, 2.0, blue+0.8pt, mCi+true+1.8pt+blue);					// inelastic
fsh = 0; DrawPointRel(7e3, 25.1, 4.3, heavygreen+0.8pt, mCi+true+1.8pt+heavygreen);		// elastic

// -------------------- LHC, 8 TeV --------------------

// TOTEM 8 TeV data
fsh = 0; DrawPointRel(8e3, 102, 2.8, red+0.8pt, mCi+true+1.8pt+red);					// total
fsh = 0; DrawPointRel(8e3, 74.7, 2.1, blue+0.8pt, mCi+true+1.8pt+blue);					// inelastic
fsh = 0; DrawPointRel(8e3, 27.0, 4.8, heavygreen+0.8pt, mCi+true+1.8pt+heavygreen);		// elastic

// ATLAS - ALFA, Phys. Lett. B 761 (2016) 158-178
DrawPointE(8e3, 0, 0, 96.07, 0.92, 0.92, red, mTL+false+1.7pt+red);						// total
DrawPointE(8e3, 0, 0, 71.73, 0.71, 0.71, blue, mTL+false+1.7pt+blue);					// inelastic
DrawPointE(8e3, 0, 0, 24.33, 0.39, 0.39, heavygreen, mTL+false+1.7pt+heavygreen);		// elastic

// -------------------- LHC, 13 TeV --------------------

// ATLAS, Phys. Rev. Lett. 117, 182002
DrawPointE(13e3-80, 0, 0, 78.1, 2.9, 2.9, blue, mTL+false+1.5pt+blue);

// CMS, FSQ-15-005
DrawPointE(13e3+80, 0, 0, 71.3, 3.5, 3.5, blue, mTR+false+1.5pt+blue);

// -------------------- arrows --------------------

real w = 2.76e3;
draw(Label("$2.76\un{TeV}$", 0, N), (log10(w), 110)--(log10(w), 90), EndArrow);

//real w = 13e3;
//draw(Label("$13\un{TeV}$", 0, N, Fill(white+opacity(0.8))), (log10(w), 130)--(log10(w), 113), EndArrow);

// -------------------- labels --------------------

AddToLegend("Auger (+ Glauber)", mSq+false+3pt+black);
AddToLegend("ALICE", mSt+false+3pt+black);
AddToLegend("ATLAS, ATLAS-ALFA", mTL+false+3pt+black);
AddToLegend("CMS", mTR+false+3pt+black);
AddToLegend("TOTEM ($\cal L$ independent)", nullpen, mCi+true+2pt);

label("$\si_{\rm tot}$", (3, 75), red);
label("$\si_{\rm inel}$", (3, 46), blue);
label("$\si_{\rm el}$", (3, 21), heavygreen);

// fit labels
AddToLegend("best COMPETE $\si_{\rm tot}$ fits", black);
AddToLegend("$11.7 - 1.59\ln s + 0.134\ln^2 s$", dashed);

limits((1e1, 0), (1e5, 140), Crop);
//AttachLegend("$\si_{\rm tot}$ (red), $\si_{\rm inel}$ (blue) and $\si_{\rm el}$ (green)", 1, NW, NW);
AttachLegend("", 1, NW, NW);

GShipout();

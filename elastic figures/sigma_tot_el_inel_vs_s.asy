import root;
import pad_layout;
import common_code;

drawGridDef = false;

texpreamble("\def\ln{\mathop{\rm ln}}");
//texpreamble("\SelectCMFonts\LoadFonts\rm");
//texpreamble("\def\ung#1{\quad{\rm[#1]}}");

defaultpen(squarecap);

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

// PDG reference: K. Nakamura et al. (Particle Data Group), J. Phys. G 37, 075021 (2010)

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

// Auger; P. Abreu et al. (Pierre Auger Collaboration), Phys. Rev. Lett. 109, 062002 (2012)
DrawPointE(57e3-200, 6e3, 6e3, 92, 14.8, 13.4, blue, mSq+false+1.5pt+blue);
DrawPointE(57e3+200, 6e3, 6e3, 133, 28.7, 26.7, red, mSq+false+1.5pt+red);


// -------------------- LHC, 2.76 TeV --------------------

// ALICE
DrawPointE(2.76e3-100, 0, 0, 62.8, 4.2, 2.7, blue, mSt+false+1.5pt+blue);				// Eur. Phys. J. C73 no. 6, (2013) 2456; unct. added in quad.

// TOTEM
fsh = 0; DrawPoint(2.76e3, 84.7, 3.3, 3.3, red+0.6pt, mCi+true+1.6pt+red);					// total
fsh = 0; DrawPoint(2.76e3, 62.8, 2.9, 2.9, blue+0.6pt, mCi+true+1.6pt+blue);				// inelastic
fsh = 0; DrawPoint(2.76e3, 21.8, 1.4, 1.4, heavygreen+0.6pt, mCi+true+1.6pt+heavygreen);	// elastic


// -------------------- LHC, 7 TeV --------------------

// ALICE
DrawPointE(7e3-400, 0, 0, 73.1, 5.3, 3.3, blue, mSt+false+1.5pt+blue);					// Eur. Phys. J. C73 no. 6, (2013) 2456; unct. added in quad.

// ATLAS
DrawPointE(7e3-150, 0, 0, 69.1, 7.3, 7.3, blue, mTL+false+1.5pt+blue);					// Nature Commun. 2 (2011) 463; unct. added in quad.

// ATLAS - ALFA; Nucl. Phys. B889 (2014) 486–548
DrawPointE(7e3-150, 0, 0, 95.35, 1.36, 1.36, red, mTL+false+1.7pt+red);					// total
DrawPointE(7e3-150, 0, 0, 71.34, 0.90, 0.90, blue, mTL+false+1.7pt+blue);				// inelastic
DrawPointE(7e3-150, 0, 0, 24.00, 0.60, 0.60, heavygreen, mTL+false+1.7pt+heavygreen);	// elastic

// CMS
DrawPointE(7e3+150, 0, 0, 68.0, 5.1, 5.1, blue, mTR+false+1.5pt+blue);					// CMS-PAS-FWD-11-001
//DrawPointE(7e3+300, 0, 0, 64.5, 3.4, 3.4, blue, mTR+false+1.5pt+blue);				// CMS-PAS-QCD-11-002	

// LHCb
DrawPointE(7e3+300, 0, 0, 66.9, 5.3, 5.3, blue, mPl2+false+1.5pt+blue);					// JHEP 02 (2015) 129; unct. added in quad.

// TOTEM; EPL 101 (2013) 21004, luminosity independent
fsh = 0; DrawPoint(7e3-200, 98.0, 2.5, 2.5, red+0.6pt, mCi+true+1.6pt+red);					// total

// TOTEM; EPL 101 (2013) 21004, elastic only
fsh = 0; DrawPoint(7e3+200, 98.6, 2.2, 2.2, red+0.6pt, mCi+true+1.6pt+red);					// total

// TOTEM; Europhys. Lett. 101 (2013) 21004
fsh = 0; DrawPointE(7e3, 0, 0, 72.9, 1.5, 1.5, blue+0.6pt, mCi+true+1.6pt+blue);				// inelastic
fsh = 0; DrawPointE(7e3, 0, 0, 25.1, 1.1, 1.1, heavygreen+0.6pt, mCi+true+1.6pt+heavygreen);	// elastic


// -------------------- LHC, 8 TeV --------------------

// TOTEM; Phys. Rev. Lett. 111 no. 1, (2013) 012001
// tot: 101.7 +- 2.9
fsh = 0; DrawPoint(8e3, 74.7, 1.7, 1.7, blue+0.6pt, mCi+true+1.6pt+blue);					// inelastic
fsh = 0; DrawPoint(8e3, 27.1, 1.4, 1.7, heavygreen+0.6pt, mCi+true+1.6pt+heavygreen);		// elastic

// TOTEM; Nucl. Phys. B 899 (2015) 527-546, N_b = 2
fsh = 0; DrawPoint(8e3-250, 101.5, 2.1, 2.1, red+0.6pt, mCi+true+1.6pt+red);			// total

// TOTEM; Eur. Phys. J. C76 (2016) 661, N_b = 3, Cahn/KL, constant phase
fsh = 0; DrawPoint(8e3+150, 102.9, 2.3, 2.3, red+0.6pt, mCi+true+1.6pt+red);			// total

// ATLAS - ALFA, Phys. Lett. B 761 (2016) 158-178
DrawPointE(8e3, 0, 0, 96.07, 0.92, 0.92, red, mTL+false+1.7pt+red);						// total
DrawPointE(8e3, 0, 0, 71.73, 0.71, 0.71, blue, mTL+false+1.7pt+blue);					// inelastic
DrawPointE(8e3, 0, 0, 24.33, 0.39, 0.39, heavygreen, mTL+false+1.7pt+heavygreen);		// elastic


// -------------------- LHC, 13 TeV --------------------

// ATLAS; Phys. Rev. Lett. 117, 182002
DrawPointE(13e3-80, 0, 0, 78.1, 2.9, 2.9, blue, mTL+false+1.5pt+blue);

// CMS; CMS-PAS-FSQ-15-005 also arXiv:1607.02033; uncertainties summed in quadrature
DrawPointE(13e3+80, 0, 0, 71.3, 3.5, 3.5, blue, mTR+false+1.5pt+blue);


// -------------------- arrows --------------------

//real w = 2.76e3;
//draw(Label("$2.76\un{TeV}$", 0, N), (log10(w), 110)--(log10(w), 90), EndArrow);

//real w = 13e3;
//draw(Label("$13\un{TeV}$", 0, N, Fill(white+opacity(0.8))), (log10(w), 130)--(log10(w), 113), EndArrow);

// -------------------- limits --------------------

limits((1e1, 0), (1e5, 140), Crop);

// -------------------- axes --------------------

yaxis(XEquals(0.9e3, false), dotted + roundcap);
yaxis(XEquals(2.76e3, false), dotted + roundcap);
yaxis(XEquals(7e3, false), dotted + roundcap);
yaxis(XEquals(8e3, false), dotted + roundcap);
yaxis(XEquals(13e3, false), dotted + roundcap);

label(rotate(90)*Label("\SmallerFonts$0.9\un{TeV}$"), Scale((0.9e3, 30)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$2.76\un{TeV}$"), Scale((2.76e3, 35)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$7\un{TeV}$"), Scale((7e3-100, 40)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$8\un{TeV}$"), Scale((8e3+100, 41)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$13\un{TeV}$"), Scale((13e3, 45)), Fill(white));

// -------------------- labels --------------------

AddToLegend("Auger (+ Glauber)", mSq+false+3pt+black);
AddToLegend("ALICE", mSt+false+3pt+black);
AddToLegend("ATLAS, ATLAS-ALFA", mTL+false+3pt+black);
AddToLegend("CMS", mTR+false+3pt+black);
AddToLegend("LHCb", mPl2+false+3pt+black);
AddToLegend("TOTEM", nullpen, mCi+true+2pt);

label("$\si_{\rm tot}$", (2.75, 78), red);
label("$\si_{\rm inel}$", (2.75, 42), blue);
label("$\si_{\rm el}$", (2.75, 18), heavygreen);

// fit labels
AddToLegend("best COMPETE $\si_{\rm tot}$ fits", black);
AddToLegend("$11.7 - 1.59\ln s + 0.134\ln^2 s$", dashed);

//AttachLegend("$\si_{\rm tot}$ (red), $\si_{\rm inel}$ (blue) and $\si_{\rm el}$ (green)", 1, NW, NW);
AttachLegend("", 1, NW, NW);

GShipout();

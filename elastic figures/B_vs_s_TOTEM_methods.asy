import root;
import pad_layout;
import common_code;

drawGridDef = false;

//----------------------------------------------------------------------------------------------------
// B as a function of sqrt(s)

real size = 13cm;
NewPad("$\sqrt s\ung{GeV}$", "estimate of $B^{\rm H}(t=0)\ung{GeV^{-2}}$", yTicks=RightTicks(Step=1, step=0.2), size, size*2/3);
currentpad.drawGridY = true;
scale(Log, Linear);

// fit
TF1_x_min = 10;
TF1_x_max = 1e5;
pen p_fit = linetype(new real[] {8,8}, offset=7);	// tuned dashed
DrawFitUncBand("B", black+opacity(0.2));
DrawFit("B", p_fit);

// ISR (CERN–Rome Collaboration), pp
//DrawPoint(31.0, 13.0, 0.7, 0.7, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B36 (1971) 504
//DrawPoint(45.4, 12.9, 0.4, 0.4, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B36 (1971) 504
//DrawPoint(53.6, 13.0, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B36 (1971) 504

DrawPoint(23.6, 11.8, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B62 (1976) 460
DrawPoint(30.8, 12.3, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B62 (1976) 460
DrawPoint(45.0, 12.8, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B62 (1976) 460
DrawPoint(53.2, 13.1, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B62 (1976) 460
DrawPoint(63.2, 13.3, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B62 (1976) 460

// ISR (ACHGT Collaboration)
DrawPoint(21.5, 11.57, 0.03, 0.03, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B39 (1972) 663
DrawPoint(30.8, 11.87, 0.28, 0.28, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B39 (1972) 663
DrawPoint(44.9, 12.87, 0.20, 0.20, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B39 (1972) 663
DrawPoint(48.0, 12.40, 0.30, 0.30, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B39 (1972) 663

// R-211 (ISR), pp and app
DrawPoint(23.5, 11.8, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(30.6, 12.2, 0.3, 0.3, black+0.6pt, mTD+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(30.4, 12.7, 0.5, 0.5, black+0.6pt, mTU+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(52.8, 12.87, 0.14, 0.14, black+0.6pt, mTD+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(52.6, 13.03, 0.52, 0.52, black+0.6pt, mTU+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(62.3, 13.02, 0.27, 0.27, black+0.6pt, mTD+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(62.3, 13.47, 0.52, 0.52, black+0.6pt, mTU+false+1.5pt+black);	// Nucl. Phys. B262 (1985) 689-714

// R-210 (ISR), pp and app
DrawPoint(52.8, 13.09, 0.58, 0.58, black+0.6pt, mTD+false+1.5pt+black);	// Phys. Lett. B115B (1982) 495
DrawPoint(52.8, 13.92, 0.59, 0.59, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Lett. B115 (1982) 495

// UA1, app
fsh = -0.01; DrawPoint(540, 13.3, 1.5, 1.5, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Lett. B 147 (1984) 385-391

// UA4, app
fsh = +0.01; DrawPoint(540, 13.7, 0.3, 0.3, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Lett. B127 (1983) 472
fsh = -0.01; DrawPoint(546, 15.5, 0.8, 0.8, black+0.6pt, mTU+false+1.5pt+black); // Phys. Lett. B 198 (1987) 583-589

// UA4/2, app
fsh = +0.02; DrawPoint(541, 15.52, 0.07, 0.07, black+0.6pt, mTU+false+1.5pt+black);	// Phys.Lett. B316 (1993) 448-454

// CDF, app
fsh = +0.01; DrawPoint(546, 15.35, 0.19, 0.19, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Rev. D 50 (1994) 5518–5534 
fsh = -0.01; DrawPoint(1800, 16.98, 0.25, 0.25, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Rev. D 50 (1994) 5518–5534

// E710, app
//DrawPoint(1800, 17.2, 1.3, 1.3, black+0.6pt, mTU+false+1.5pt+black);	// 1988
//DrawPoint(1800, 16.3, 0.5, 0.5, black+0.6pt, mTU+false+1.5pt+black);	// 1988
//DrawPoint(1800, 16.3, 0.3, 0.3, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Lett. B 247 (1990) 127-130
fsh = +0.01; DrawPoint(1800, 16.99, 0.47, 0.47, black+0.6pt, mTU+false+1.5pt+black);	// Phys. Rev. Lett. 68 (1992) 2433
DrawPoint(1020, 16.2, 1.0, 1.0, black+0.6pt, mTU+false+1.5pt+black);	// Nuovo Cimento A 106 (1992) 123-129

// E811, app
// no B measurement

// D0, app
DrawPoint(1.96e3, 16.54, 0.9, 0.9, black+0.6pt, mTU+false+1.5pt+black);	// D0 Note 6056-CONF

// pp2pp, pp
DrawPoint(200, 16.3, 1.84, 1.84, black+0.6pt, mTD+false+1.5pt+black);	// Phys.Lett. B579 (2004) 245-250

// -------------------- LHC, TOTEM --------------------

pen p_exp1 = blue;
pen p_exp3 = red;

bool r_full = true;
bool r_low = false;

mark m_coul_sub = mSt + 2.5pt;
mark m_coul_ign = mCi + 2pt;

// -------------------- LHC, 2.76 TeV --------------------

// TOTEM, not yet published
DrawPoint(2.76e3, 17.1, 0.3, 0.3, p_exp1, m_coul_ign + r_full + p_exp1);



// -------------------- LHC, 7 TeV --------------------

// TOTEM, EPL 101 (2013) 21002, abstract
DrawPoint(7e3, 19.9, 0.3, 0.3, p_exp1, m_coul_ign + r_full + p_exp1);



// -------------------- LHC, 8 TeV --------------------

// TOTEM, Phys. Rev. Lett. 111, 012001 (2013)
DrawPoint(8e3, 19.9, 0.3, 0.3, p_exp1, m_coul_ign + r_full + p_exp1);

// TOTEM, Nucl. Phys. B 899 (2015) 527-546
fsh = +0.01; DrawPoint(8e3, 20.14, 0.15, 0.15, p_exp3, m_coul_ign + r_full + p_exp3);

// TOTEM, Eur. Phys. J. C76 (2016) 661, const. phase
fsh = -0.01; DrawPoint(8e3, 20.47, 0.14, 0.14, p_exp3, m_coul_sub + r_full + p_exp3);



// -------------------- LHC, 13 TeV --------------------

// TOTEM, 90m optics, preliminary, not yet published
DrawPoint(13e3, 20.35, 0.3, 0.3, p_exp1, m_coul_ign + r_full + p_exp1);

// TOTEM, 2.5km optics, preliminary, not yet published
fsh = +0.01; DrawPoint(13e3, 20.77, 0.06, 0.06, p_exp1, m_coul_sub + r_low + p_exp1);
fsh = -0.01; DrawPoint(13e3, 21.25, 0.13, 0.13, p_exp3, m_coul_sub + r_full + p_exp3);



// -------------------- limits --------------------

limits((1e1, 11), (1e5, 22), Crop);

// -------------------- axes --------------------

yaxis(XEquals(0.546e3, false), dotted + roundcap);
yaxis(XEquals(0.9e3, false), dotted + roundcap);
yaxis(XEquals(1.8e3, false), dotted + roundcap);
yaxis(XEquals(2.76e3, false), dotted + roundcap);
yaxis(XEquals(7e3, false), dotted + roundcap);
yaxis(XEquals(8e3, false), dotted + roundcap);
yaxis(XEquals(13e3, false), dotted + roundcap);

real y_label = 13;
label(rotate(90)*Label("\SmallerFonts$0.546\un{TeV}$"), Scale((0.546e3-100, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$0.9\un{TeV}$"), Scale((0.9e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$1.8\un{TeV}$"), Scale((1.8e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$2.76\un{TeV}$"), Scale((2.76e3, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$7\un{TeV}$"), Scale((7e3-300, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$8\un{TeV}$"), Scale((8e3+300, y_label)), Fill(white));
label(rotate(90)*Label("\SmallerFonts$13\un{TeV}$"), Scale((13e3, y_label)), Fill(white));

// -------------------- labels --------------------

AddToLegend("<{\it pre-LHC experiments:}");

AddToLegend("$\rm \bar pp$", black, mTU+false+3pt+black);
AddToLegend("$\rm pp$", black, mTD+false+3pt+black);
AddToLegend("fit linear in $\log s$, data $\sqrt s < 3\un{TeV}$", p_fit);


AddToLegend("");
AddToLegend("<{\it TOTEM, different methods:}");

AddToLegend("<colours: fit parametrisation");
AddToLegend("exp1", p_exp1);
AddToLegend("exp3", p_exp3);

AddToLegend("<filling: fit range");
AddToLegend("filled: full $|t|$ range");
AddToLegend("hollow: low $|t|$ only");

AddToLegend("<marker: Coulomb treatment");
AddToLegend("Coulomb ignored", m_coul_ign);
AddToLegend("Coulomb subtracted", m_coul_sub);

AttachLegend(BuildLegend(lineLength=8mm, NW), NE);

GShipout();

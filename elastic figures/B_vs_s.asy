import root;
import pad_layout;

drawGridDef = false;

//----------------------------------------------------------------------------------------------------

void DrawPoint(real W, real B, real em, real ep, pen col=red, marker m, real corr=0)
{
	draw( shift(corr, 0) * ( Scale((W, B-em))--Scale((W, B))--Scale((W, B+ep)) ), col);
	draw( shift(corr, 0) * Scale((W, B)), m);

	real e = (ep + em) / 2.;
	//write(format("	AddPoint(%#6.1f, ", W) + format("%#5.2f, ", B) + format("%#4.2f);", e));
}

//----------------------------------------------------------------------------------------------------
// B as a function of sqrt(s)

NewPad("$\sqrt s\ung{GeV}$", "$B\ung{GeV^{-2}}$", yTicks=RightTicks(Step=1, step=0.2), 8cm, 8cm);
scale(Log, Linear);

// fit
TF1_x_min = 10;
TF1_x_max = 2e4;
draw(RootGetObject("B_vs_s.root", "B_vs_s|ff"), dashed);
//AddToLegend("fit quadratic", dashed);
//AddToLegend("in $\log s$");


// ISR (CERN–Rome Collaboration), pp
//DrawPoint(31.0, 13.0, 0.7, 0.7, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B36 (1971) 504
//DrawPoint(45.4, 12.9, 0.4, 0.4, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B36 (1971) 504
//DrawPoint(53.6, 13.0, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B36 (1971) 504

DrawPoint(23.6, 11.8, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B62 (1976) 460
DrawPoint(30.8, 12.3, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B62 (1976) 460
DrawPoint(45.0, 12.8, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B62 (1976) 460
DrawPoint(53.2, 13.1, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B62 (1976) 460
DrawPoint(63.2, 13.3, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B62 (1976) 460

// ISR (ACHGT Collaboration)
DrawPoint(21.5, 11.57, 0.03, 0.03, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B39 (1972) 663
DrawPoint(30.8, 11.87, 0.28, 0.28, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B39 (1972) 663
DrawPoint(44.9, 12.87, 0.20, 0.20, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B39 (1972) 663
DrawPoint(48.0, 12.40, 0.30, 0.30, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B39 (1972) 663

// R-211 (ISR), pp and app
DrawPoint(23.5, 11.8, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(30.6, 12.2, 0.3, 0.3, blue+0.6pt, mTD+false+1.5pt+blue);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(30.4, 12.7, 0.5, 0.5, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(52.8, 12.87, 0.14, 0.14, blue+0.6pt, mTD+false+1.5pt+blue);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(52.6, 13.03, 0.52, 0.52, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Nucl. Phys. B262 (1985) 689-714

DrawPoint(62.3, 13.02, 0.27, 0.27, blue+0.6pt, mTD+false+1.5pt+blue);	// Nucl. Phys. B262 (1985) 689-714
DrawPoint(62.3, 13.47, 0.52, 0.52, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Nucl. Phys. B262 (1985) 689-714

// R-210 (ISR), pp and app
DrawPoint(52.8, 13.09, 0.58, 0.58, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys. Lett. B115B (1982) 495
DrawPoint(52.8, 13.92, 0.59, 0.59, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Phys. Lett. B115 (1982) 495

// UA1, app
DrawPoint(540, 13.3, 1.5, 1.5, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, -0.01);	// Phys. Lett. B 147 (1984) 385-391

// UA4, app
DrawPoint(540, 13.7, 0.3, 0.3, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, +0.01);	// Phys. Lett. B127 (1983) 472
DrawPoint(546, 15.5, 0.8, 0.8, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, -0.01); // Phys. Lett. B 198 (1987) 583-589

// UA4/2, app
DrawPoint(541, 15.52, 0.07, 0.07, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, +0.02);	// Phys.Lett. B316 (1993) 448-454

// CDF, app
DrawPoint(546, 15.35, 0.19, 0.19, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, +0.01);	// Phys. Rev. D 50 (1994) 5518–5534 
DrawPoint(1800, 16.98, 0.25, 0.25, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen,-0.01);	// Phys. Rev. D 50 (1994) 5518–5534

// E710, app
//DrawPoint(1800, 17.2, 1.3, 1.3, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// 1988
//DrawPoint(1800, 16.3, 0.5, 0.5, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// 1988
//DrawPoint(1800, 16.3, 0.3, 0.3, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Phys. Lett. B 247 (1990) 127-130
DrawPoint(1800, 16.99, 0.47, 0.47, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen, +0.01);	// Phys. Rev. Lett. 68 (1992) 2433
DrawPoint(1020, 16.2, 1.0, 1.0, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// Nuovo Cimento A 106 (1992) 123-129

// E811, app
// no B measurement

// D0, app
DrawPoint(1.96e3, 16.54, 0.9, 0.9, heavygreen+0.6pt, mTU+false+1.5pt+heavygreen);	// D0 Note 6056-CONF

// pp2pp, pp
DrawPoint(200, 16.3, 1.84, 1.84, blue+0.6pt, mTD+false+1.5pt+blue);	// Phys.Lett. B579 (2004) 245-250

// TOTEM, pp, 2.76 TeV
DrawPoint(2.76e3, 17.1, 0.2, 0.2, red+0.8pt, mCi+true+2pt+red);

// ATLAS-ALFA, pp, 7 TeV
DrawPoint(7e3, 19.73, 0.29, 0.29, blue+0.8pt, mTL+false+2pt+blue, +0.01);

// TOTEM, pp, 7 TeV
DrawPoint(7e3, 19.9, 0.26, 0.26, red+0.8pt, mCi+true+2pt+red, -0.01);

// ATLAS-ALFA, pp, 8 TeV
DrawPoint(8e3, 19.74, 0.24, 0.24,  blue+0.8pt, mTL+false+2pt+blue, +0.01);

// TOTEM, pp, 8 TeV
DrawPoint(8e3, 19.9, 0.3, 0.3, red+0.8pt, mCi+true+2pt+red);

AddToLegend("$\rm \bar pp$", heavygreen, mTU+false+3pt+heavygreen);
AddToLegend("$\rm pp$", blue, mTD+false+3pt+blue);
AddToLegend("TOTEM", red+0.8pt, mCi+true+2.5pt+red);
AddToLegend("ATLAS-ALFA", blue+0.8pt, mTL+false+3pt+blue);

// arrows
/*
real x = log10(2.76e3);
draw(rotate(90)*Label("$\sqrt s = 2.76\un{TeV}$", 0., Fill(white)), (x, 15.5)--(x, 17.5), EndArrow);

real x = log10(13e3);
draw(rotate(90)*Label("$\sqrt s = 13\un{TeV}$", 0., Fill(white)), (x, 17.2)--(x, 20.2), EndArrow);
*/

limits((1e1, 11), (1e4, 21), Crop);

AttachLegend(BuildLegend(lineLength=8mm, NW), NW);

GShipout();

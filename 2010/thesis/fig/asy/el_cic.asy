import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 5.4cm;

string f3 = "../elastic/coulomb3_anal.root";
string f4 = "../elastic/coulomb4_anal.root";

real las[] = { 1e-2, 1e-3, 1e-4 };
pen colors[] = { red, blue, heavygreen };

NewPad("$|t|\un{GeV^2}$", "$|F_C|$");
scale(Log, Log);
draw(rGetObj(f3, "F_C#0|cmp_F_C_mod"), black, "Born ($\la = 0$)");
for (int li : las.keys)
	draw(rGetObj(f3, "F_C#0|F_C_mod,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, 1e4), (1e1, 1e11), Crop);
AttachLegend(SW, SW);


NewPad("$|t|\un{GeV^2}$", "$\arg F_C / \pi$");
scale(Log, Linear);
//draw(yscale(1/3.141593), rGetObj(f3, "F_C#1|cmp_F_C_arg"), black, "Cahn");
for (int li : las.keys) {
	draw(yscale(1/3.141593), rGetObj(f3, "F_C#1|F_C_arg,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
	draw(yscale(1/3.141593), rGetObj(f3, "F_C#1|F_C_arg_th,la="+format("%.0E", las[li])), colors[li]+dashed, format("$\la=%.0E\,\rm GeV$", las[li]));
}
limits((1e-5, 0.95), (1e1, 1.01), Crop);

GShipout("el_cic_noff_F_C", hSkip=5mm);



NewPad("$|t|\un{GeV^2}$", "$\Re \Psi$");
scale(Log, Linear);
draw(rGetObj(f3, "interference#0|cmp_CH_phase_re"), black, "Cahn");
for (int li : las.keys)
	draw(rGetObj(f3, "interference#0|CH_phase_re,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -0.4), (1e1, 0.3), Crop);
AttachLegend(SW, SW);

NewPad("$|t|\un{GeV^2}$", "$\Im \Psi$");
scale(Log, Linear);
draw(rGetObj(f3, "interference#1|cmp_CH_phase_im"), black, "Cahn");
for (int li : las.keys)
	draw(rGetObj(f3, "interference#1|CH_phase_im,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -0.02), (1e1, 0.02), Crop);

GShipout("el_cic_noff_Psi", hSkip=5mm);



NewPad("$|t|\un{GeV^2}$", "$Z\un{\%}$");
scale(Log, Linear);
draw(yscale(100), rGetObj(f3, "interference#2|cmp_CH_Z"), black, "Cahn");
for (int li : las.keys)
	draw(yscale(100), rGetObj(f3, "interference#2|CH_Z,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -30), (1e1, 30), Crop);
AttachLegend();

NewPad("$|t|\un{GeV^2}$", "$\zeta$");
scale(Log, Linear);
for (int li : las.keys)
	draw(yscale(1), rGetObj(f3, "interference#3|CH_zeta,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, 0), (1e1, 1.2), Crop);

GShipout("el_cic_noff_Z", hSkip=5mm);

//--------------------------------------------------

NewPad("$|t|\un{GeV^2}$", "$|F_C|$");
scale(Log, Log);
for (int li : las.keys) {
	draw(rGetObj(f4, "dipole/F_C#2|F_C_mod,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
	draw(rGetObj(f4, "dipole/F_C#2|F_C_mod_th,la="+format("%.0E", las[li])), colors[li]+dashed);
}
draw(rGetObj(f4, "dipole/F_C#2|cmp_F_C_mod"), black);
limits((1e-5, 1e4), (1e0, 1e11), Crop);
AttachLegend(SW, SW);

NewPad("$|t|\un{GeV^2}$", "$\arg F_C / \pi$");
scale(Log, Linear);
for (int li : las.keys) {
	draw(yscale(1/3.141593), rGetObj(f4, "dipole/F_C#3|F_C_arg,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
	draw(yscale(1/3.141593), rGetObj(f4, "dipole/F_C#3|F_C_arg_th,la="+format("%.0E", las[li])), colors[li]+dashed);
}
limits((1e-5, 0.95), (1e0, 1.01), Crop);

GShipout("el_cic_diff_F_C", hSkip=5mm);



real Cahn_nu(real mt)
{
	real La_sq = 0.71;
	real al = 7.297e-3;
	// plotting alpha * nu, in units of pi !!
	return al * 2*mt/La_sq * (2*log(La_sq/4/mt) - 1) / 3.141593;
}

real Selyugin_nu(real mt)
{
	real c1 = 0.11;
	real c2 = 20;
	real al = 7.297e-3;
	return al * c1 * log(1 + c2*c2*mt) / 3.141593;
}

NewPad("$|t|\un{GeV^2}$", "$\De \arg F_C / \pi$");
scale(Log, Linear);
for (int li : las.keys) {
	draw(yscale(1/3.141593), rGetObj(f4, "dipole/F_C#5|F_C_de_arg,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
}
draw(graph(Cahn_nu, 1e-5, 1e0, 1000), black, "Cahn's $\nu$");
draw(graph(Selyugin_nu, 1e-5, 1e0, 1000), black+dashed, "Selyugin's $\nu$");
limits((1e-5, -1e-3), (1e-1, +2e-3), Crop);

GShipout("el_cic_diff_F_C_darg", hSkip=5mm);



NewPad("$|t|\un{GeV^2}$", "$\Re \Psi$");
scale(Log, Linear);
draw(rGetObj(f4, "dipole/interference#0|cmp_CH_phase_re"), black, "KL");
for (int li : las.keys)
	draw(rGetObj(f4, "dipole/interference#0|CH_phase_re,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -0.1), (1e0, 0.1), Crop);
AttachLegend(NW, NW);

NewPad("$|t|\un{GeV^2}$", "$\Im \Psi$");
scale(Log, Linear);
draw(rGetObj(f4, "dipole/interference#1|cmp_CH_phase_im"), black, "KL");
for (int li : las.keys)
	draw(rGetObj(f4, "dipole/interference#1|CH_phase_im,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -0.01), (1e0, 0.01), Crop);

GShipout("el_cic_diff_Psi", hSkip=5mm);



NewPad("$|t|\un{GeV^2}$", "$Z\un{\%}$");
scale(Log, Linear);
draw(yscale(100), rGetObj(f4, "dipole/interference#2|cmp_CH_Z"), black, "KL");
for (int li : las.keys)
	draw(yscale(100), rGetObj(f4, "dipole/interference#2|CH_Z,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, -20), (1e0, 30), Crop);
AttachLegend();

NewPad("$|t|\un{GeV^2}$", "$\zeta$");
scale(Log, Linear);
for (int li : las.keys)
	draw(yscale(1), rGetObj(f4, "dipole/interference#3|CH_zeta,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
limits((1e-5, 0), (1e0, 1.2), Crop);

GShipout("el_cic_diff_Z", hSkip=5mm);

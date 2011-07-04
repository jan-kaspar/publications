import root;
import pad_layout;

StdFonts();

xSizeDef = ySizeDef = 5.5cm;

string fff = "../elastic/coulomb_ff.root";
string f4 = "../elastic/coulomb_anal.root";

real las[] = { 1e-2, 1e-3, 1e-4 };
pen colors[] = { red, blue, heavygreen };

string cModes[] = { "WY", "SWY", "KL" };
string cNames[] = { "WY", "SWY", "CKL" };
pen cm_colors[] = { heavygreen, blue, red };

string FFs[] = { "dipole", "Hofstadter", "Puckett" };
pen ff_colors[] = { red, blue, heavygreen };


real t_min = 1e-4, t_max = 3e0;

string es(real x)
{
	return "10^{"+format("%i", floor(log10(x)))+"}";
}

//--------------------------------------------------
write("* el_cic_noff_F_C");

NewPad("$|t|\un{GeV^2}$", "$|F^{\rm C}|$");
scale(Log, Log);
draw(rGetObj(f4, "none/F_C#2|cmp_F_C_mod"), black);
for (int li : las.keys)
	draw(rGetObj(f4, "none/F_C#2|F_C_mod,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
limits((t_min, 1e5), (t_max, 1e10), Crop);
AttachLegend(NE, NE);

ClearLegend();
AddToLegend("Born ($\la = 0$)", black);
AttachLegend("no form factor", SW, SW);

NewPad("$|t|\un{GeV^2}$", "$\arg F^{\rm C} / \pi$");
scale(Log, Linear);
for (int li : las.keys) {
	draw(yscale(1/3.141593), rGetObj(f4, "none/F_C#3|F_C_arg,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
	draw(yscale(1/3.141593), rGetObj(f4, "none/F_C#3|F_C_arg_th,la="+format("%.0E", las[li])), colors[li]+longdashed, "$\la="+es(las[li])+"\,\rm GeV$");
}
limits((t_min, 0.95), (t_max, 1.01), Crop);

GShipout("el_cic_noff_F_C", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_noff_Psi");

NewPad("$|t|\un{GeV^2}$", "real part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
for (int ci : cModes.keys)
	draw(rGetObj(f4, "none/interference#0|cmp_"+cModes[ci]+"_CH_phase_re"), cm_colors[ci]+longdashed, cNames[ci]);
for (int li : las.keys)
	draw(rGetObj(f4, "none/interference#0|CH_phase_re,la="+format("%.0E", las[li])), colors[li]);
limits((t_min, -0.2), (t_max, 0.7), Crop);
AttachLegend("no form factor", NW, NW);

NewPad("$|t|\un{GeV^2}$", "imaginary part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
for (int ci : cModes.keys)
	draw(rGetObj(f4, "none/interference#1|cmp_"+cModes[ci]+"_CH_phase_im"), cm_colors[ci]+longdashed);
for (int li : las.keys)
	draw(rGetObj(f4, "none/interference#1|CH_phase_im,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
limits((t_min, -0.25), (t_max, 0.25), Crop);
AttachLegend(NE, NE);

GShipout("el_cic_noff_Psi", hSkip=5mm);


//--------------------------------------------------
write("* el_cic_noff_Z");

NewPad("$|t|\un{GeV^2}$", "$Z\un{\%}$");
scale(Log, Linear);
for (int ci : cModes.keys)
	draw(yscale(100), rGetObj(f4, "none/interference#2|cmp_"+cModes[ci]+"_CH_Z"), cm_colors[ci]+longdashed, cNames[ci]);
for (int li : las.keys)
	draw(yscale(100), rGetObj(f4, "none/interference#2|CH_Z,la="+format("%.0E", las[li])), colors[li]);
limits((t_min, -30), (t_max, 30), Crop);
AttachLegend("no form factor", NW, NW);

NewPad("$|t|\un{GeV^2}$", "$\zeta$");
scale(Log, Linear);
for (int li : las.keys)
	draw(yscale(1), rGetObj(f4, "none/interference#3|CH_zeta,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
limits((t_min, 0), (t_max, 1.2), Crop);
AttachLegend(NE, N+0.88E);

GShipout("el_cic_noff_Z", hSkip=5mm);

//--------------------------------------------------
//--------------------------------------------------
write("* el_cic_diff_F_C");

NewPad("$|t|\un{GeV^2}$", "$|F^{\rm C}|$");
scale(Log, Log);
draw(rGetObj(f4, "Puckett/F_C#2|cmp_F_C_mod"), black);
for (int li : las.keys) {
	draw(rGetObj(f4, "Puckett/F_C#2|F_C_mod,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
	//draw(rGetObj(f4, "dipole/F_C#2|F_C_mod_th,la="+format("%.0E", las[li])), colors[li]+longdashed);
}
limits((t_min, 1e5), (t_max, 1e10), Crop);
AttachLegend(NE, NE);

ClearLegend();
AddToLegend("Born ($\la = 0$)", black);
AttachLegend("Puckett form factor", SW, SW);

/*
NewPad("$|t|\un{GeV^2}$", "$\arg F_C / \pi$");
scale(Log, Linear);
for (int li : las.keys) {
	draw(yscale(1/3.141593), rGetObj(f4, "dipole/F_C#3|F_C_arg,la="+format("%.0E", las[li])), colors[li], format("$\la=%.0E\,\rm GeV$", las[li]));
	draw(yscale(1/3.141593), rGetObj(f4, "dipole/F_C#3|F_C_arg_th,la="+format("%.0E", las[li])), colors[li]+longdashed);
}
limits((t_min, 0.95), (t_max, 1.01), Crop);
*/

GShipout("el_cic_diff_F_C", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_diff_nu");

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

NewPad("$|t|\un{GeV^2}$", "$\al\nu / \pi$");
scale(Log, Linear);
for (int ffi : FFs.keys)
	draw(yscale(1/3.141593), rGetObj(fff, FFs[ffi]+"/nu|nu_1E-04"), ff_colors[ffi], FFs[ffi]);

draw(graph(Cahn_nu, t_min, t_max, 1000), black, "Cahn's $\nu$");
draw(graph(Selyugin_nu, t_min, t_max, 1000), black+longdashed, "Selyugin's $\nu$");
limits((t_min, -1e-3), (t_max, +4e-3), Crop);
AttachLegend(NW, NW);

GShipout("el_cic_diff_nu", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_diff_Psi_ff");

NewPad("$|t|\un{GeV^2}$", "real part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
for (int ffi : FFs.keys) {
	draw(rGetObj(f4, FFs[ffi]+"/interference#0|cmp_SWY_CH_phase_re"), ff_colors[ffi]+longdashed);
	draw(rGetObj(f4, FFs[ffi]+"/interference#0|cmp_KL_CH_phase_re"), ff_colors[ffi]);
}
AddToLegend("solid: CKL");
AddToLegend("longdashed: SWY");
limits((t_min, -0.05), (t_max, 0.06), Crop);
AttachLegend(SE, SE);

NewPad("$|t|\un{GeV^2}$", "imaginary part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
for (int ffi : FFs.keys) {
	draw(rGetObj(f4, FFs[ffi]+"/interference#1|cmp_SWY_CH_phase_im"), ff_colors[ffi]+longdashed);
	draw(rGetObj(f4, FFs[ffi]+"/interference#1|cmp_KL_CH_phase_im"), ff_colors[ffi], FFs[ffi]);
}
limits((t_min, -0.01), (t_max, 0.1), Crop);
AttachLegend(NE, NE);

GShipout("el_cic_diff_Psi_ff", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_diff_Psi_eik");


NewPad("$|t|\un{GeV^2}$", "real part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
draw(rGetObj(f4, "Puckett/interference#0|cmp_KL_CH_phase_re"), black+longdashed, "CKL");
for (int li : las.keys) {
	if (li == 0)
		continue;
	draw(rGetObj(f4, "Puckett/interference#0|CH_phase_re,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
}
limits((t_min, -0.05), (t_max, 0.06), Crop);

NewPad("$|t|\un{GeV^2}$", "imaginary part of $\al\Ps$ or $-\al\Ph$");
scale(Linear, Linear);
draw(rGetObj(f4, "Puckett/interference#1|cmp_KL_CH_phase_im"), black+longdashed, "CKL");
for (int li : las.keys)
	draw(rGetObj(f4, "Puckett/interference#1|CH_phase_im,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
limits((t_min, -0.01), (t_max, 0.1), Crop);
AttachLegend("Puckett form factor", NE, NE);

GShipout("el_cic_diff_Psi_eik", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_diff_Z_ff");

NewPad("$|t|\un{GeV^2}$", "$Z\un{\%}$");
scale(Log, Linear);
for (int ffi : FFs.keys) {
	draw(yscale(100), rGetObj(f4, FFs[ffi]+"/interference#2|cmp_SWY_CH_Z"), ff_colors[ffi]+longdashed);
	draw(yscale(100), rGetObj(f4, FFs[ffi]+"/interference#2|cmp_KL_CH_Z"), ff_colors[ffi], FFs[ffi]);
}
limits((t_min, -20), (t_max, 10), Crop);
AttachLegend(SE, SE);

ClearLegend();
AddToLegend("solid: CKL");
AddToLegend("longdashed: SWY");
AttachLegend(NW, NW);


/*
NewPad("$|t|\un{GeV^2}$", "$\zeta$");
scale(Log, Linear);
for (int ffi : FFs.keys) {
	draw(rGetObj(f4, FFs[ffi]+"/interference#3|cmp_SWY_CH_zeta"), colors[ffi]+longdashed);
	draw(rGetObj(f4, FFs[ffi]+"/interference#3|cmp_KL_CH_zeta"), colors[ffi], FFs[ffi]);
}
limits((t_min, 0), (t_max, 1.2), Crop);
*/

GShipout("el_cic_diff_Z_ff", hSkip=5mm);

//--------------------------------------------------
write("* el_cic_diff_Z_eik");

NewPad("$|t|\un{GeV^2}$", "$Z\un{\%}$");
scale(Log, Linear);
draw(yscale(100), rGetObj(f4, "Puckett/interference#2|cmp_KL_CH_Z"), black+longdashed, "CKL");
for (int li : las.keys)
	draw(yscale(100), rGetObj(f4, "Puckett/interference#2|CH_Z,la="+format("%.0E", las[li])), colors[li]);
limits((t_min, -20), (t_max, 0), Crop);
AttachLegend("Puckett form factor", SE, SE);

NewPad("$|t|\un{GeV^2}$", "$\zeta$");
scale(Log, Linear);
for (int li : las.keys)
	draw(yscale(1), rGetObj(f4, "Puckett/interference#3|CH_zeta,la="+format("%.0E", las[li])), colors[li], "$\la="+es(las[li])+"\,\rm GeV$");
limits((t_min, 0), (t_max, 1.2), Crop);
AttachLegend(NE, NE);

GShipout("el_cic_diff_Z_eik", hSkip=5mm);

import pad_layout;
import root;
import latex_aux_parser;

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");
texpreamble("\def\ln{\mathop{\rm ln}}");

ParseAuxFile("../combined_epl.aux");

StdFonts();

pen[] paletteColor2 = {blue, green, yellow, red};
TH2_palette = paletteColor2;

//----------------------------------------------------------------------------------------------------
// sigma tot, sigma elastic

real p2W(real p)
{
	real m = 0.938270; // GeV
	real E = sqrt(m*m + p*p);
	return sqrt(2*m*(m + E));
}

int DrawDataSet(string filename, pen col, mark m, string legend="")
{
	file f = input(filename, false);
	if (error(f))
		return 1;

	while (!eof(f)) {
		string line = f;

		string[] bits = split(line);
		if (bits.length < 10)
			continue;

		real p = (real) bits[2];		// GeV
		real p_min = (real) bits[3];
		real p_max = (real) bits[4];
		
		real si = (real) bits[5];		// mb
		real si_sep = (real) bits[6];
		real si_sem = (real) bits[7];
		real si_srep = (real) bits[8];	// %
		real si_srem = (real) bits[9];

		//real si_ep = si_sep;
		//real si_em = si_sem;
		
		real si_ep = sqrt(si_sep^2 + (si*si_srep/100)^2);
		real si_em = sqrt(si_sem^2 + (si*si_srem/100)^2);

		// W = sqrt(s)
		real W = p2W(p);
		real W_min = p2W(p_min);
		real W_max = p2W(p_max);

		draw(Scale((W_min, si))--Scale((W_max, si)), col);
		draw(Scale((W, si-si_em))--Scale((W, si+si_ep)), col);
		draw(Scale((W, si)), m+false+1.5pt+col);

		//if (W > 500 && W < 600)
		//	write("AddPoint(" + format("%E", W) + ", " + format("%E", si) + ", " + format("%E", (si_ep+si_em)/2) +  ");");

		//label(bits[1], Scale((W, 130)));
	}

	//AddToLegend(legend, col, m+false+0.7pt+col);
	return 0;
}

struct Meas {
	real p, p_min, p_max;
	real si, si_ep, si_em;
	string ref;
}

int LoadFile(string fn, Meas data[])
{
	file f = input(fn, false);
	if (error(f))
		return 1;

	while (!eof(f)) {
		string line = f;

		string[] bits = split(line);
		if (bits.length < 10)
			continue;

		Meas m;
		m.p = (real) bits[2];		// GeV
		m.p_min = (real) bits[3];
		m.p_max = (real) bits[4];
		
		m.si = (real) bits[5];		// mb
		real si_sep = (real) bits[6];
		real si_sem = (real) bits[7];
		real si_srep = (real) bits[8];	// %
		real si_srem = (real) bits[9];
		m.ref = bits[10];

		m.si_ep = sqrt(si_sep^2 + (m.si*si_srep/100)^2);
		m.si_em = sqrt(si_sem^2 + (m.si*si_srem/100)^2);
		
		data.push(m);
	}
	
	return 0;
}

int DrawInelasticDataSet(string fileT, string fileE, pen col, mark m)
{
	Meas dataT[], dataE[];
	LoadFile(fileT, dataT);
	LoadFile(fileE, dataE);

	for (int idxT : dataT.keys) {
		for (int idxE : dataE.keys) {
			if (dataT[idxT].p == dataE[idxE].p && dataT[idxT].ref == dataE[idxE].ref) {
				real W = p2W(dataT[idxT].p);
				real W_min = p2W(dataT[idxT].p_min);
				real W_max = p2W(dataT[idxT].p_max);

				real si_E = dataE[idxE].si, si_E_e = (dataE[idxE].si_em + dataE[idxE].si_ep) / 2;
				real si_T = dataT[idxT].si, si_T_e = (dataT[idxT].si_em + dataT[idxT].si_ep) / 2;
				real si_I = si_T - si_E, si_I_e = sqrt(si_E_e*si_E_e + si_T_e*si_T_e);
				
				draw(Scale((W_min, si_I))--Scale((W_max, si_I)), col);
				draw(Scale((W, si_I-si_I_e))--Scale((W, si_I+si_I_e)), col);
				draw(Scale((W, si_I)), m+false+1.5pt+col);

				//write("AddPoint("+format("%E", )+", "+format("%E", )+", "+format("%E", )+")");
			}
		}
	}

	return 0;
}

real sign = 1;
real SigmaTotFit(real W)
{
	real s0 = 29.1, s1 = 1;
	real Z = 35.5, B = 0.307, Y1 = 42.6, Y2 = sign*33.4;
	real et1 = 0.46, et2 = 0.545;

	real s = W^2;
	return Z + B * log(s/s0)^2 + Y1*(s1/s)^et1 + Y2*(s1/s)^et2;
}

real SigmaElFit(real W)
{
	real s = W*W;
	real xi = log(s);
	return 11.4 - 1.52*xi + 0.130*xi*xi;

	real xi = log10(W);
	return 11.4 - 7.02*xi + 2.76*xi*xi;
}

real SigmaInelFit(real W)
{
	return SigmaTotFit(W) - SigmaElFit(W);
}

real base = 1e3, fac = 1;
while (true) {
	real W = fac * base;
	write(format("%.1E", W)+", " + format("%.2E", SigmaTotFit(W))+", " + format("%.2E", SigmaInelFit(W))+", " + format("%.2E", SigmaElFit(W)));

	fac += 1;
/*
	if (fac > 9) {
		fac = 1;
		base *= 10;
	}
	if (base > 1e4)
		break;
*/
	if (fac > 20)
		break;
}


real fsh=0;
void DrawPoint(real W, real si, real em, real ep, pen col=red, marker m)
{
	draw(shift(fsh, 0)*(Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);
}

void DrawPointRel(real W, real si, real re, pen col=red, marker m)
{
	draw(shift(fsh, 0)*(Scale((W, si*(1-re/100)))--Scale((W, si*(1+re/100)))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);
}

void DrawPointE(real W, real Wm, real Wp, real si, real em, real ep, pen col=red, marker m, string label)
{
	draw(Scale((W, si-em))--Scale((W, si+ep)), col);
	draw(Scale((W-Wm, si))--Scale((W+Wp, si)), col);
	draw(Scale((W, si)), col, m);
	if (label != "")
		AddToLegend(label, nullpen, m);
}

//----------------------------------------------------------------------------------------------------

void MakePlot(real wl, real wr, real sl, string ubw, string legendFont, bool useCMSPoints)
{
	NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el},\ \si_{\rm inel},\hbox{ and } \si_{\rm tot}\ung{mb}$", xSize=wl, 77mm, yTicks=RightTicks(Step=20, step=10));
	FixPad(sl, -77);
	
	scale(Log, Linear);
	
	// fits
	sign = +1; draw(graph(SigmaTotFit, 10, 1e5, 100), black);
	sign = -1; draw(graph(SigmaTotFit, 10, 1e5, 100), black);
	sign = +1; draw(graph(SigmaInelFit, 10, 1e5, 100), dashdotted);
	sign = -1; draw(graph(SigmaInelFit, 10, 1e5, 100), dashdotted);
	draw(graph(SigmaElFit, 10, 1e5, 100), dashed);
	
	// PDG sigma tot data
	DrawDataSet("pbarp_total.dat", red+0.2pt, mTU);
	DrawDataSet("pp_total.dat", red+0.2pt, mTD);
	
	// PDG sigma el data
	DrawDataSet("pbarp_elastic.dat", heavygreen+0.2pt, mTU);
	DrawDataSet("pp_elastic.dat", heavygreen+0.2pt, mTD);
	
	// PDG sigma inel data
	DrawInelasticDataSet("pbarp_total.dat", "pbarp_elastic.dat", blue+0.2pt, mTU);
	DrawInelasticDataSet("pp_total.dat", "pp_elastic.dat", blue+0.2pt, mTD);
	
	// PDG Labels
	AddToLegend("$\rm \bar pp$, Ref.~["+GetLatexReference("bibcite", "pdg")+"]", nullpen, mTU+false+1.5pt);
	AddToLegend("$\rm pp$, Ref.~["+GetLatexReference("bibcite", "pdg")+"]", nullpen, mTD+false+1.5pt);
	
	// CMS, ATLAS and ALICE
	DrawPointE(2.76e3, 0, 0, 62.8, 4.2, 2.7, blue, mSt+false+1.5pt+blue, "");
	DrawPointE(7e3-400, 0, 0, 73.1, 5.3, 3.3, blue, mSt+false+1.5pt+blue, "ALICE, Ref.~["+GetLatexReference("bibcite", "alice_inel")+"]");
	
	DrawPointE(7e3-150, 0, 0, 69.1, 7.3, 7.3, blue, mTL+false+1.5pt+blue, "ATLAS, Ref.~["+GetLatexReference("bibcite", "atlas_inel")+"]");
	
	if (useCMSPoints) {
		DrawPointE(7e3+150, 0, 0, 68.0, 5.1, 5.1, blue, mTR+false+1.5pt+blue, "CMS, Ref.~["+GetLatexReference("bibcite", "cms_inel")+"]");	// CMS-PAS-FWD-11-001
		//DrawPointE(7e3+300, 0, 0, 64.5, 3.4, 3.4, blue, mTR+false+1.5pt+blue, "");															// CMS-PAS-QCD-11-002
	}
	
	// Auger
	DrawPointE(57e3-200, 6e3, 6e3, 92, 14.8, 13.4, blue, mSq+false+1.5pt+blue, "");
	DrawPointE(57e3+200, 6e3, 6e3, 133, 28.7, 26.7, red, mSq+false+1.5pt+red, "");
	AddToLegend("Auger + Glauber, Ref.~["+GetLatexReference("bibcite", "auger")+"]", nullpen, mSq+false+1.5pt+black);
	
	
	// TOTEM 7 TeV data
	
	// tot
	fsh = 0; DrawPointRel(7e3, 98.1, 2.4, yellow+opacity(0.3)+2pt, mCi+true+4pt+(yellow+opacity(0.3)));
	fsh = 0; DrawPointRel(7e3, 98.1, 2.4, black+0.8pt, mCi+true+1.7pt+black);
	
	// inel
	fsh = 0; DrawPointRel(7e3, 72.9, 2.0, yellow+opacity(0.3)+2pt, mCi+true+4pt+(yellow+opacity(0.3)));
	fsh = 0; DrawPointRel(7e3, 72.9, 2.0, black+0.8pt, mCi+true+1.7pt+black);
	
	// el
	fsh = 0; DrawPointRel(7e3, 25.1, 4.3, yellow+opacity(0.3)+2pt, mCi+true+4pt+(yellow+opacity(0.3)));
	fsh = 0; DrawPointRel(7e3, 25.1, 4.3, black+0.8pt, mCi+true+1.7pt+black);
	
	fsh = 0;
	
	AddToLegend("TOTEM ($\cal L$-independent)", nullpen, mCi+true+1.7pt);
	
	label("$\si_{\rm tot}$", (3, 75), red);
	label("$\si_{\rm inel}$", (3, 46), blue);
	label("$\si_{\rm el}$", (3, 21), heavygreen);
	
	// fit labels
	AddToLegend("best COMPETE $\si_{\rm tot}$ fits", black);
	AddToLegend("$11.4 - 1.52\ln s + 0.130\ln^2 s$", dashed);
	
	limits((1e1, 0), (1e5, 140), Crop);
	//AttachLegend("$\si_{\rm tot}$ (red), $\si_{\rm inel}$ (blue) and $\si_{\rm el}$ (green)", 2, NW, NW);
	legendLabelPen = fontcommand(legendFont);
	add(Legend(1, lineLength=3mm, NW), point(NW), Fill(white));
	currentpen = fontcommand("\SetFontSizesX");
	
	
	//--------------------
	
	NewPad(false);
	
	label("{Measurements at $\sqrt s = 7\un{TeV}$}", (0, 0), (0, 0));
	FixPad(-10, 49);
	
	//--------------------
	
	real si_tot[] = {98.3, 98.6, 98.0, 99.1};
	real si_tot_un[] = {2.8, 2.2, 2.5, 4.3};
	
	real si_inel[] = {73.5, 73.2, 72.9, 73.7};
	real si_inel_un[] = {1.6, 1.3, 1.5, 3.4};
	
	real si_el[] = {24.8, 25.4, 25.1, 25.4};
	real si_el_un[] = {1.2, 1.1, 1.1, 1.1};

	real x_up = (useCMSPoints) ? 8 : 7; 
	
	
	NewRow();
	
	xSizeDef = 42mm; ySizeDef = 23mm;
	pen dense_dotted=linetype(new real[] {0, 2});
	
	NewPad("", "$\si_{\rm tot}\ung{mb}$", xSize=wr, xTicks = NoTicks(), yTicks=RightTicks(Step=5, step=1));
	real m = 98.25, ep = 2.1, em = 1.9;
	draw((0.5, m)--(4.5, m), black+dense_dotted);
	
	for (int i : si_tot.keys) {
		draw((i+1, si_tot[i]), mCi+2pt+red);
		draw((i+1, si_tot[i]-si_tot_un[i])--(i+1, si_tot[i]+si_tot_un[i]), red);
	}
	
	label(scale(1.)*Label("$\si_{\rm tot}$"), (0.5, 107), E, red);
	
	limits((0, 90), (x_up, 110), Crop);
	//AttachLegend("total cross section");
	
	//--------------------
	NewRow();
	
	NewPad("", "$\si_{\rm inel}\ung{mb}$", xSize=wr, xTicks = NoTicks(), yTicks=RightTicks(Step=5, step=1));
	real m = 73.3225;
	draw((0.5, m)--(4.5, m), black+dense_dotted);
	
	for (int i : si_inel.keys) {
		draw((i+1, si_inel[i]), mCi+2pt+blue);
		draw((i+1, si_inel[i]-si_inel_un[i])--(i+1, si_inel[i]+si_inel_un[i]), blue);
	}
	
	DrawPointE(5, 0, 0, 73.1, 5.3, 3.3, blue, mSt+false+2pt+blue, "");
	DrawPointE(6, 0, 0, 69.1, 7.3, 7.3, blue, mTL+false+2pt+blue, "");
	if (useCMSPoints) {
		real ep = 0.;
		DrawPointE(7-ep, 0, 0, 68.0, 5.1, 5.1, blue, mTR+false+2pt+blue, "");	// CMS-PAS-FWD-11-001
		//DrawPointE(7+ep, 0, 0, 64.5, 3.4, 3.4, blue, mTR+false+2pt+blue, "");   // CMS-PAS-QCD-11-002
	}
	
	limits((0, 60), (x_up, 80), Crop);
	//AttachLegend("inelastic cross section");
	label(scale(1.)*Label("$\si_{\rm inel}$"), (0.5, 77), E, blue);
	
	//--------------------
	NewRow();
	
	string MethName(real x)
	{
		if (fabs(x - 1) < 0.1) return "\vbox{\hbox{elastic only (Jun)}}";
		if (fabs(x - 2) < 0.1) return "\vbox{\hbox{elastic only (Oct)}}";
		if (fabs(x - 3) < 0.1) return "${\cal L}_{\rm int}$-independent";
		if (fabs(x - 4) < 0.1) return "$\rh$-independent";
		if (fabs(x - 5) < 0.1) return "ALICE, Ref.~["+GetLatexReference("bibcite", "alice_inel")+"]";
		if (fabs(x - 6) < 0.1) return "ATLAS, Ref.~["+GetLatexReference("bibcite", "atlas_inel")+"]";
		if (fabs(x - 7) < 0.1) return "CMS, Ref.~["+GetLatexReference("bibcite", "cms_inel")+"]";
		return "??";
	}
	
	NewPad("", "$\si_{\rm el}\ung{mb}$", xSize=wr, xTicks=NoTicks(), yTicks=RightTicks(Step=5, step=1));
	real m = 25.175;
	draw((0.5, m)--(4.5, m), black+dense_dotted);
	
	for (int i : si_el.keys) {
		draw((i+1, si_el[i]), mCi+2pt+heavygreen);
		draw((i+1, si_el[i]-si_el_un[i])--(i+1, si_el[i]+si_el_un[i]), heavygreen);
	}
	limits((0, 15), (x_up, 35), Crop);
	//AttachLegend("elastic cross section");
	label(scale(1.)*Label("$\si_{\rm el}$"), (0.5, 32), E, heavygreen);
	
	xaxis(YEquals(15, false), LeftTicks(rotate(90)*Label(""), MethName, Step=1, step=1, beginlabel=false, endlabel=false));
	
	//--------------------
	
	NewPad(false);
	label("$\underbrace{\hbox to"+ubw+"{\hfil}}_{\hbox{TOTEM}}$");
	FixPad(-22, -278);
}

//----------------------------------------------------------------------------------------------------

MakePlot(104mm, 42mm, -260, "20mm", "\SetFontSizesVIII", true);
GShipout("sigma_tot_el_inel_cmp_big", vSkip=0);

//----------------------------------------------------------------------------------------------------

MakePlot(91mm, 37mm, -226, "18mm", "\SetFontSizesVII", true);
GShipout("sigma_tot_el_inel_cmp_big_cern", vSkip=0);

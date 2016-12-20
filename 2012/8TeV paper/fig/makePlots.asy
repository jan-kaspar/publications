import pad_layout;
import root;

texpreamble("\def\ln{\mathop{\rm ln}}");
texpreamble("\SelectCMFonts\LoadFonts\rm");
texpreamble("\def\ung#1{\quad{\rm[#1]}}");

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

bool verbose = false;

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

		if (verbose)
			write(format("AddPoint(%E", W) + format(", %E", si) + format(", %E);", (abs(si_em) + abs(si_ep))/2.));

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

	/* fit including 7 and 8 TeV TOTEM points and pp and app PDG points with sqrt s > 10 GeV
	p0                        =      11.7359   +/-   0.318563    
	p1                        =     -1.58513   +/-   0.0870728   
	p2                        =     0.133567   +/-   0.00584892 
	*/

	return 11.7359 - 1.58513 *xi + 0.133567 *xi*xi;
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

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el}$ (green), $\si_{\rm inel}$ (blue) and  $\si_{\rm tot}$ (red) $\ung{mb}$", 14cm, 10cm);

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

//verbose = true;

// PDG sigma el data
DrawDataSet("pbarp_elastic.dat", heavygreen+0.2pt, mTU);
DrawDataSet("pp_elastic.dat", heavygreen+0.2pt, mTD);

// PDG sigma inel data
DrawInelasticDataSet("pbarp_total.dat", "pbarp_elastic.dat", blue+0.2pt, mTU);
DrawInelasticDataSet("pp_total.dat", "pp_elastic.dat", blue+0.2pt, mTD);

// PDG Labels
AddToLegend("$\rm \bar pp$ (PDG)", nullpen, mTU+false+1.5pt);
AddToLegend("$\rm pp$ (PDG)", nullpen, mTD+false+1.5pt);

// Auger
DrawPointE(57e3-200, 6e3, 6e3, 92, 14.8, 13.4, blue, mSq+false+1.5pt+blue, "");
DrawPointE(57e3+200, 6e3, 6e3, 133, 28.7, 26.7, red, mSq+false+1.5pt+red, "");
AddToLegend("Auger + Glauber", nullpen, mSq+false+1.5pt+black);

// CMS, ATLAS and ALICE
/*
DrawPointE(7e3-150, 0, 0, 69.4, 7.3, 7.3, blue, mTL+false+1.5pt+blue, "ATLAS");
DrawPointE(7e3+150, 0, 0, 68, 5.1, 5.1, blue, mTR+false+1.5pt+blue, "CMS");

DrawPointE(2.76e3, 0, 0, 62.1, 4.6, 4.6, blue, mSt+false+1.5pt+blue, "");
DrawPointE(7e3-400, 0, 0, 72.7, 5.2, 5.2, blue, mSt+false+1.5pt+blue, "ALICE");
*/

DrawPointE(2.76e3, 0, 0, 62.8, 4.2, 2.7, blue, mSt+false+1.5pt+blue, "");
DrawPointE(7e3-400, 0, 0, 73.1, 5.3, 3.3, blue, mSt+false+1.5pt+blue, "ALICE");

DrawPointE(7e3-150, 0, 0, 69.1, 7.3, 7.3, blue, mTL+false+1.5pt+blue, "ATLAS");

DrawPointE(7e3+150, 0, 0, 68.0, 5.1, 5.1, blue, mTR+false+1.5pt+blue, "CMS");	// CMS-PAS-FWD-11-001
//DrawPointE(7e3+300, 0, 0, 64.5, 3.4, 3.4, blue, mTR+false+1.5pt+blue, "");	// CMS-PAS-QCD-11-002	


// TOTEM 7 TeV data
// tot
//fsh = 0; DrawPointRel(7e3, 98.1, 2.4, yellow+2pt, mCi+true+4pt+yellow);
fsh = 0; DrawPointRel(7e3, 98.1, 2.4, black+0.8pt, mCi+true+1.7pt+black);

// inel
//fsh = 0; DrawPointRel(7e3, 72.9, 2.0, yellow+2pt, mCi+true+4pt+yellow);
fsh = 0; DrawPointRel(7e3, 72.9, 2.0, black+0.8pt, mCi+true+1.7pt+black);

// el
//fsh = 0; DrawPointRel(7e3, 25.1, 4.3, yellow+2pt, mCi+true+4pt+yellow);
fsh = 0; DrawPointRel(7e3, 25.1, 4.3, black+0.8pt, mCi+true+1.7pt+black);


// TOTEM 8 TeV data
// tot
fsh = 0; DrawPointRel(8e3, 102, 2.8, yellow+opacity(0.75)+2pt, mCi+true+4pt+(yellow+opacity(0.75)));
fsh = 0; DrawPointRel(8e3, 102, 2.8, black+0.8pt, mCi+true+1.7pt+black);

// inel
fsh = 0; DrawPointRel(8e3, 74.7, 2.1, yellow+opacity(0.75)+2pt, mCi+true+4pt+(yellow+opacity(0.75)));
fsh = 0; DrawPointRel(8e3, 74.7, 2.1, black+0.8pt, mCi+true+1.7pt+black);

// el
fsh = 0; DrawPointRel(8e3, 27.0, 4.8, yellow+opacity(0.75)+2pt, mCi+true+4pt+(yellow+opacity(0.75)));
fsh = 0; DrawPointRel(8e3, 27.0, 4.8, black+0.8pt, mCi+true+1.7pt+black);


AddToLegend("TOTEM ($\cal L$ indep.)", nullpen, mCi+true+1.7pt);

label("$\si_{\rm tot}$", (3, 75), red);
label("$\si_{\rm inel}$", (3, 46), blue);
label("$\si_{\rm el}$", (3, 21), heavygreen);

// fit labels
AddToLegend("best COMPETE $\si_{\rm tot}$ fits", black);
AddToLegend("$11.7 - 1.59\ln s + 0.134\ln^2 s$", dashed);

limits((1e1, 0), (1e5, 140), Crop);
//AttachLegend("$\si_{\rm tot}$ (red), $\si_{\rm inel}$ (blue) and $\si_{\rm el}$ (green)", 1, NW, NW);
AttachLegend("", 1, NW, NW);


GShipout("sigma_tot_el_inel_cmp", vSkip=0);

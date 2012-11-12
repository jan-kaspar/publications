import pad_layout;
import root;
import latex_aux_parser;

ParseAuxFile("../combined_epl.aux");

StdFonts();

texpreamble("\SelectCMFonts\LoadFonts\NormalFonts");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

pen[] paletteColor2 = {blue, green, yellow, red};
TH2_palette = paletteColor2;

string base_dir = "/home/jkaspar/publications/2011/elastic_90m";

xSizeDef = 6cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------
// sigma tot, sigma elastic

real p2W(real p)
{
	real m = 0.938270; // GeV
	real E = sqrt(m*m + p*p);
	return sqrt(2*m*(m + E));
}

//----------------------------------------------------------------------------------------------------

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

//----------------------------------------------------------------------------------------------------

struct Meas {
	real p, p_min, p_max;
	real si, si_ep, si_em;
	string ref;
}

//----------------------------------------------------------------------------------------------------

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

//----------------------------------------------------------------------------------------------------

int DrawElToTotDataSet(string fileT, string fileE, pen col, mark m)
{
	Meas dataT[], dataE[];
	LoadFile(fileT, dataT);
	LoadFile(fileE, dataE);

	write(dataT.length);
	write(dataE.length);

	for (int idxT : dataT.keys) {
		for (int idxE : dataE.keys) {
			if (dataT[idxT].p == dataE[idxE].p && dataT[idxT].ref == dataE[idxE].ref) {
				real W = p2W(dataT[idxT].p);
				real W_min = p2W(dataT[idxT].p_min);
				real W_max = p2W(dataT[idxT].p_max);

				real si_E = dataE[idxE].si, si_E_e = (dataE[idxE].si_em + dataE[idxE].si_ep) / 2;
				real si_T = dataT[idxT].si, si_T_e = (dataT[idxT].si_em + dataT[idxT].si_ep) / 2;
				real r = si_E / si_T * 100.;
				real r_e = r * sqrt(si_E_e*si_E_e/si_E/si_E + si_T_e*si_T_e/si_T/si_T);
				
				draw(Scale((W_min, r))--Scale((W_max, r)), col);
				draw(Scale((W, r-r_e))--Scale((W, r+r_e)), col);
				draw(Scale((W, r)), m+false+1.5pt+col);

				//write("AddPoint("+format("%E", )+", "+format("%E", )+", "+format("%E", )+")");
			}
		}
	}

	return 0;
}

//----------------------------------------------------------------------------------------------------

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

real RFit(real W)
{
	return SigmaElFit(W) / SigmaTotFit(W) * 100.;
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



void DrawPoint(real W, real si, real em, real ep, pen col=red, marker m, real corr=0)
{
	draw((Scale((W, si-em)) + (corr, 0) )--Scale((W, si))--(Scale((W, si+ep)) + (corr, 0)), col);
	draw(Scale((W, si)), m);
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

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm el} / \si_{\rm tot}\ung{\%}$", yTicks=RightTicks(Step=2, step=1), 6cm, 4cm);
scale(Log, Linear);
//currentpad.xSize = 15cm;
//currentpad.ySize = 9cm;

for (real x = 1; x <= 4; x += 1)
	draw((x, 15)--(x, 30), dotted);

for (real y = 16; y < 30; y += 2)
	draw((1, y)--(4, y), dotted);


// fits
draw(graph(RFit, 10, 1e5, 100), black+dashed);

// PDG ratio data
DrawElToTotDataSet(base_dir+"/pbarp_total.dat", base_dir+"/pbarp_elastic.dat", heavygreen+0.2pt, mTU+2pt+false+heavygreen);
DrawElToTotDataSet(base_dir+"/pp_total.dat", base_dir+"/pp_elastic.dat", blue+0.2pt, mTD+2pt+true+blue);

DrawPoint(7e3, 25.8, 0.56, 0.56, red+0.8pt, mCi+true+2pt+red);		// totem

limits((1e1, 15), (1e4, 30), Crop);
AddToLegend("$\rm pp$, Ref.~["+GetLatexReference("bibcite", "pdg")+"]", blue, mTD+true+2pt+blue);
AddToLegend("$\rm \bar pp$, Ref.~["+GetLatexReference("bibcite", "pdg")+"]", heavygreen, mTU+false+2pt+heavygreen);
AddToLegend("this publication", red+0.8pt, mCi+true+2pt+red);
AttachLegend(NW, NW);

GShipout("sigma_el_to_sigma_tot");

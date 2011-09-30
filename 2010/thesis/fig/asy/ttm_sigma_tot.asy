import pad_layout;
import root;

string dir = "../sigma_tot";

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
	file f = input(dir + "/" + filename, false);
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

void DrawPoint(real W, real si, real em, real ep, pen col=red, marker m)
{
	draw(Scale((W, si-em))--Scale((W, si+ep)), col);
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

NewPad("$\sqrt s\un{GeV}$", "$\si_{\rm tot}\un{mb}$");
currentpad.xSize = 10cm;
//currentpad.ySize = 9cm;

scale(Log, Linear);

// fits
sign = +1; draw(graph(SigmaTotFit, 10, 1e5, 100), black);
sign = -1; draw(graph(SigmaTotFit, 10, 1e5, 100), black);
//draw(graph(SigmaElFit, 10, 1e5, 100), dashed);

draw(
(log10(1e2), 47.3).. 
(log10(2e2), 53.3).. 
(log10(4e2), 60.5).. 
(log10(1e3), 72.2).. 
(log10(2e3), 82.5).. 
(log10(4e3), 94.6).. 
(log10(1e4), 112.0).. 
(log10(2e4), 127.0), dashed 
);

draw(
(log10(1e2), 46.2).. 
(log10(2e2), 51.7).. 
(log10(4e2), 58.0).. 
(log10(1e3), 67.3).. 
(log10(2e3), 73.4).. 
(log10(4e3), 78.9).. 
(log10(1e4), 85.0).. 
(log10(2e4), 88.9), dashed 
);

// PDG sigma tot data
DrawDataSet("pbarp_total.dat", heavygreen+0.2pt, mCi);
DrawDataSet("pp_total.dat", blue+0.2pt, mCi);

// PDG sigma el data
//DrawDataSet("pbarp_elastic.dat", heavygreen+0.2pt, mCi);
//DrawDataSet("pp_elastic.dat", blue+0.2pt, mCi);

// PDG Labels
AddToLegend("$\rm \bar pp$ (PDG)", nullpen, mCi+heavygreen+false+1.5pt);
AddToLegend("$\rm pp$ (PDG)", nullpen, mCi+blue+false+1.5pt);

// fit labels
AddToLegend("best COMPETE fits", black);
AddToLegend("total COMPETE error", dashed);
//AddToLegend("parabolic $\si_{\rm el}$ fit", dashed);

// TOTEM data
pen p = darkred*0.5 + white*0.5;
DrawPoint(7e3, 98.3, 2.77, 3., red+0.8pt, mCi+true+1.7pt+red);		// tot
//DrawPoint(7e3, 24.8, 1.26, 1.26, red+0.8pt, mCi+true+1.7pt+red);	// el
AddToLegend("TOTEM", nullpen, mCi+red+true+1.7pt);

DrawPoint(7e3, 120, 0.98, 0.98, magenta+0.8pt, mPl+true+1pt+magenta);		// tot
label(Label("\vbox{\hbox{TOTEM}\hbox{ultimate}\hbox{error}}"), (3.8, 110), NW, magenta);

//label("$\si_{\rm tot}$", (3, 75), black);
//label("$\si_{\rm el}$", (3, 21), black);

//label("TOTEM:", (3.15, 130), red);
//label("$\si_{\rm tot} = (98.3 \pm 0.2^{\rm stat} \pm 2.8^{\rm syst})\,\rm mb$", (3.15, 120), red);



// data labels
label(rotate(90)*Label("ISR"), (log10(46), 45), N);

label(rotate(90)*Label("UA4/2, UA2, UA1"), (log10(546), 73), N);
label(rotate(90)*Label("CDF, UA4"), (log10(546), 58), S);

label(rotate(90)*Label("UA5"), (log10(900), 62), S);
label(rotate(90)*Label("E811, E710"), (log10(1800), 69), S);
label(rotate(90)*Label("CDF"), (log10(1800), 83), N);

label(rotate(90)*Label("TOTEM"), (log10(7000), 78), S);

limits((1e1, 20), (3e4, 140), Crop);
AttachLegend(NW, NW);

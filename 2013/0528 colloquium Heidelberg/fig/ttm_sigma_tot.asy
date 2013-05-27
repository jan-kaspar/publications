import pad_layout;
import root;

string dir = "/home/jkaspar/publications/2012/8TeV paper/fig";

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

		real p = (real) bits[1];		// GeV
		real p_min = (real) bits[2];
		real p_max = (real) bits[3];
		
		real si = (real) bits[4];		// mb
		real si_sep = (real) bits[5];
		real si_sem = (real) bits[6];
		real si_srep = (real) bits[7];	// %
		real si_srem = (real) bits[8];

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

NewPad("$\sqrt s\ung{GeV}$", "$\si_{\rm tot}\ung{mb}$");
currentpad.xSize = 11cm;
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
DrawDataSet("pbarp_total.dat", red+0.5pt, mCi);
DrawDataSet("pp_total.dat", blue+0.5pt, mCi);

// PDG Labels
AddToLegend("$\rm \bar pp$ (PDG)", nullpen, mCi+red+false+1.5pt);
AddToLegend("$\rm pp$ (PDG)", nullpen, mCi+blue+false+1.5pt);

// fit labels
AddToLegend("best COMPETE fits", black);
AddToLegend("total COMPETE error", dashed);
//AddToLegend("parabolic $\si_{\rm el}$ fit", dashed);



// data labels
label(rotate(90)*Label("ISR"), (log10(46), 45), N);

label(rotate(90)*Label("UA4/2, UA2, UA1"), (log10(546), 73), N);
label(rotate(90)*Label("CDF, UA4"), (log10(546), 58), S);

label(rotate(90)*Label("UA5"), (log10(900), 62), S);
label(rotate(90)*Label("E811, E710"), (log10(1800), 69), S);
label(rotate(90)*Label("CDF"), (log10(1800), 83), N);

limits((1e1, 20), (3e4, 140), Crop);
AttachLegend(NW, NW);

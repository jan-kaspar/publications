import pad_layout;
import root;

StdFonts();

//texpreamble("\SelectCMFonts\LoadFonts\NormalFonts");
//texpreamble("\def\ung#1{\quad[{\rm#1}]}");

pen[] paletteColor2 = {blue, green, yellow, red};
TH2_palette = paletteColor2;

string base_dir = "/home/jkaspar/publications/2012/7TeV three papers/combined/fig/";

xSizeDef = 8cm;
ySizeDef = 8cm;

//----------------------------------------------------------------------------------------------------
// sigma tot, sigma elastic

real p2W(real p)
{
	real m = 0.938270; // GeV
	real E = sqrt(m*m + p*p);
	return sqrt(2*m*(m + E));
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
		m.p = (real) bits[1];		// GeV
		m.p_min = (real) bits[2];
		m.p_max = (real) bits[3];
		
		m.si = (real) bits[4];		// mb
		real si_sep = (real) bits[5];
		real si_sem = (real) bits[6];
		real si_srep = (real) bits[7];	// %
		real si_srem = (real) bits[8];
		m.ref = bits[9];

		m.si_ep = sqrt(si_sep^2 + (m.si*si_srep/100)^2);
		m.si_em = sqrt(si_sem^2 + (m.si*si_srem/100)^2);
		
		data.push(m);
	}
	
	return 0;
}

void DrawPoint(real W, real si, real em, real ep, pen col=red, marker m, real corr=0)
{
	draw((Scale((W, si-em)) + (corr, 0) )--Scale((W, si))--(Scale((W, si+ep)) + (corr, 0)), col);
	draw(Scale((W, si)), m);
}

//----------------------------------------------------------------------------------------------------

void PlotRho(string f, pen col, mark m)
{
	Meas data_rho[];
	LoadFile(base_dir + f, data_rho);
	
	for (int pi : data_rho.keys) {
		//write(data_rho[pi].si);
	
		real W = p2W(data_rho[pi].p);
		real W_min = p2W(data_rho[pi].p_min);
		real W_max = p2W(data_rho[pi].p_max);
	
		real rho = data_rho[pi].si;
		real rho_ep = data_rho[pi].si_ep;
		real rho_em = data_rho[pi].si_em;
	
	
		draw(Scale((W_min, rho))--Scale((W_max, rho)), col);
		draw(Scale((W, rho-rho_em))--Scale((W, rho+rho_ep)), col);
		draw(Scale((W, rho)), m+col);
	}
}

//----------------------------------------------------------------------------------------------------

bool competeRho = false;

real Compete_RRP_nf_L2_u(real W)
{
	real Z_pp = 35.497, B = 0.30763, s0 = 29.204, Y_1_pp = 42.593, eta_1 = 0.4600, Y_2_pp = 33.363, eta_2 = 0.5454;
	real s = W*W;
	real si_pp = Z_pp + B * log(s/s0)^2 + Y_1_pp * s^(-eta_1) - Y_2_pp * s^(-eta_2);

	if (!competeRho)
		return si_pp;

	real si_pp_rho_pp = pi * B * log(s/s0) - Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) - Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_pp_rho_pp / si_pp;
}

real Compete_R_qc_RL_qc(real W)
{
	real B = 0.7597, s0 = 119.3437, Y_1_pp = 11.907, eta_1 = 0.20193, Y_2_pp = 35.454, eta_2 = 0.55543;
	real s = W*W;
	real si_pp = 9*B * log(s/s0) + 9*Y_1_pp * s^(-eta_1) - Y_2_pp * s^(-eta_2);

	if (!competeRho)
		return si_pp;

	real si_pp_rho_pp = 9 * pi * B/2  - 9 * Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) - Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_pp_rho_pp / si_pp;
}

//----------------------------------------------------------------------------------------------------

/*
NewPad("$\sqrt s\ung{GeV}$");
scale(Log, Linear);

competeRho = false;

draw(graph(Compete_RRP_nf_L2_u, 1e1, 1e4), black);
draw(graph(Compete_R_qc_RL_qc, 1e1, 1e4), red);
*/

//----------------------------------------------------------------------------------------------------

real x_corr_scale = 0.03;
real x_corr = 0;

void DrawPointUnc(real v, real u)
{
	real W = 8e3;
	draw(Scale((W, v)) + (x_corr, 0), mCi+2pt+true+red);
	draw(shift(x_corr) * (Scale((W, v-u))--Scale((W, v+u))), red+0.8pt);

	x_corr += x_corr_scale;
}

//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{GeV}$", "$\rh$", yTicks=RightTicks(0.05, 0.01));
scale(Log, Linear);

PlotRho("pbarp_elastic_reim.dat", heavygreen, mTU+2pt+false);
PlotRho("pp_elastic_reim.dat", blue, mTD+2pt+true);

DrawPoint(7e3, 0.145, 0.091, 0.091, red+0.8pt, mCi+false+2pt+red);		// TOTEM 7 TeV

//DrawPoint(8e3, 0.107, 0.031, 0.031, red+0.8pt, mCi+true+2pt+red);		// TOTEM 8 TeV

x_corr = -0.5 * x_corr_scale;
DrawPointUnc(0.037, 0.023);
DrawPointUnc(0.098, 0.026);
DrawPointUnc(0.116, 0.03);

//DrawRange(0.046, 0.105);
DrawPointUnc(0.066, 0.023);
//DrawRange(0.087, 0.127);
DrawPointUnc(0.093, 0.026);
//DrawRange(0.097, 0.117);
DrawPointUnc(0.11, 0.03);

competeRho = true;
draw(graph(Compete_RRP_nf_L2_u, 1e1, 2e4), black+dashed);
//draw(graph(Compete_R_qc_RL_qc, 1e1, 1e4), red);

AddToLegend("$\rm pp$ (PDG)", blue, mTD+false+3pt+blue);
AddToLegend("$\rm\bar pp$ (PDG)", heavygreen, mTU+false+3pt+heavygreen);
AddToLegend("COMPETE preferred-model $\rm pp$ fit", black+dashed);
AddToLegend("TOTEM indirect at $\sqrt s = 7\un{TeV}$", red+0.8pt, mCi+false+3pt+red);
AddToLegend("TOTEM direct at $\sqrt s = 8\un{TeV}$", red+0.8pt, mCi+true+3pt+red);

limits((1e1, -0.2), (2e4, +0.2), Crop);

for (real y = -0.2; y <= 0.2; y += 0.05)
	xaxis(YEquals(y, false), dotted);

AttachLegend(SE, SE);

//----------------------------------------------------------------------------------------------------

string MeasDesc(real vr)
{
	int v = floor(vr + 0.5);
	v = 9 - v;

	if (v == 0) return "\vbox{\hsize45mm\leftskip0pt plus1fil\rightskip0pt\parfillskip0pt\noindent {\it COMPETE}: preferred model and band from all models}";

	if (v == 2) return "\vbox{\hsize45mm\leftskip0pt plus1fil\rightskip0pt\parfillskip0pt\noindent {\it TOTEM}: red = fit uncertainty, cyan = band from varying peripheral phase}";
	
	//if (v == 3) return "\vbox{\hsize45mm\leftskip0pt plus1fil\rightskip0pt\parfillskip0pt\noindent {\it TOTEM}: band from varying peripheral phase}";

	if (v == 4) return "{\it model}: Block et al.";
	if (v == 5) return "{\it model}: Bourrely et al.";
	if (v == 6) return "{\it model}: Petrov et al. (3P)";
	if (v == 7) return "{\it model}: Petrov et al. (2P)";
	if (v == 8) return "{\it model}: Islam et al.";

	return "";
}

string MeasAxisDesc(real v)
{
	return MeasDesc(v);
}



NewPad("$\rh$", "", 8cm);
currentpad.xTicks = LeftTicks(Step=0.02, step=0.01);
currentpad.yTicks = RightTicks(rotate(0)*Label(""), MeasAxisDesc, Step=1, step=0);

transform t = (0, 9, 0, 1, -1, 0);

real y, v, e, ys = 0.3;

void DrawPointUnc(real v, real e)
{
	draw(t * (y, v), red, mCi+red+3pt);
	draw(t * ((y, v-e)--(y, v+e)), red+1pt);
	y += ys;
}

void DrawRange(real vf, real vt)
{
	real h = 0.07;
	filldraw(t * ((y-h, vf)--(y-h, vt)--(y+h, vt)--(y+h, vf)--cycle), cyan, nullpen);
}

y = 0; v = 0.1399; e = 0.002;
draw(t * (y, v), black, mSq+black+3pt);
draw(t * ((y, 0.064)--(y, 0.148)), black+1pt, Bars(8));

y = 2 - 2.5ys;
DrawPointUnc(0.037, 0.023);
DrawPointUnc(0.098, 0.026);
DrawPointUnc(0.116, 0.03);

DrawRange(0.046, 0.105);
DrawPointUnc(0.066, 0.023);
DrawRange(0.087, 0.127);
DrawPointUnc(0.093, 0.026);
DrawRange(0.097, 0.117);
DrawPointUnc(0.11, 0.03);

y = 4; v = 0.119;
draw(t * (y, v), blue, mCr+(magenta+1pt)+3pt);

y = 5; v = 0.125;
draw(t * (y, v), blue, mCr+(magenta+1pt)+3pt);

y = 6; v = 0.114;
draw(t * (y, v), blue, mCr+(magenta+1pt)+3pt);

y = 7; v = 0.099;
draw(t * (y, v), blue, mCr+(magenta+1pt)+3pt);

y = 8; v = 0.124;
draw(t * (y, v), blue, mCr+(magenta+1pt)+3pt);

//AddToLegend("phenomenological models", mSq+magenta+3pt);
//AddToLegend("TOTEM", mCi+red+3pt);
//AddToLegend("COMPETE", mCr+black+3pt);

limits((0.00, 0.5), (0.16, 9.5), Crop);
for (real x = 0.00; x < 0.16; x += 0.01)
	yaxis(XEquals(x, false), dotted);

/*
limits((0, 0), (9, 0.25), Crop);
for (real y = -0.; y <= 0.2; y += 0.05)
	xaxis(YEquals(y, false), dotted);
*/

AttachLegend("details at $\sqrt s = 8\un{TeV}$", SW, SW);

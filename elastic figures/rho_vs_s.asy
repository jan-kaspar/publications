import root;
import pad_layout;

//StdFonts();
//texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesIX");
//texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string base_dir = "pdg/";

xSizeDef = 10cm;
ySizeDef = 8cm;

drawGridDef = true;

//----------------------------------------------------------------------------------------------------

real p2W(real p)
{
	real m = 0.938270; // GeV
	real E = sqrt(m*m + p*p);
	return sqrt(2*m*(m + E));
}

//----------------------------------------------------------------------------------------------------

struct Meas
{
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

	while (!eof(f))
	{
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

		m.ref = bits[9] + " " + bits[10] + ";";
		for (int i = 11; i < bits.length; ++i)
			m.ref += " " + bits[i];

		m.si_ep = sqrt(si_sep^2 + (m.si*si_srep/100)^2);
		m.si_em = sqrt(si_sem^2 + (m.si*si_srem/100)^2);
		
		data.push(m);
	}
	
	return 0;
}

//----------------------------------------------------------------------------------------------------

void PlotRho(string f, pen col, mark m)
{
	Meas data_rho[];
	LoadFile(base_dir + f, data_rho);
	
	for (int pi : data_rho.keys)
	{
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

		//label(rotate(90)*Label("{\SetFontSizesVI " + data_rho[pi].ref + "}"), Scale((W_min, rho)), N, col);
	}
}

//----------------------------------------------------------------------------------------------------

real rho_pp_compete_RRP_nf_L2_u(real W)
{
	real Z_pp = 35.497, B = 0.30763, s0 = 29.204, Y_1_pp = 42.593, eta_1 = 0.4600, Y_2_pp = 33.363, eta_2 = 0.5454;
	real s = W*W;

	real si = Z_pp + B * log(s/s0)^2 + Y_1_pp * s^(-eta_1) - Y_2_pp * s^(-eta_2);

	real si_rho = pi * B * log(s/s0) - Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) - Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_rho / si;
}

//----------------------------------------------------------------------------------------------------

real rho_app_compete_RRP_nf_L2_u(real W)
{
	real Z_pp = 35.497, B = 0.30763, s0 = 29.204, Y_1_pp = 42.593, eta_1 = 0.4600, Y_2_pp = 33.363, eta_2 = 0.5454;
	real s = W*W;

	real si = Z_pp + B * log(s/s0)^2 + Y_1_pp * s^(-eta_1) + Y_2_pp * s^(-eta_2);

	real si_rho = pi * B * log(s/s0) - Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) + Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_rho / si;
}

//----------------------------------------------------------------------------------------------------

real rho_pp_compete_R_qc_RL_qc(real W)
{
	real B = 0.7597, s0 = 119.3437, Y_1_pp = 11.907, eta_1 = 0.20193, Y_2_pp = 35.454, eta_2 = 0.55543;
	real s = W*W;
	real si_pp = 9*B * log(s/s0) + 9*Y_1_pp * s^(-eta_1) - Y_2_pp * s^(-eta_2);

	real si_pp_rho_pp = 9 * pi * B/2  - 9 * Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) - Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_pp_rho_pp / si_pp;
}

//----------------------------------------------------------------------------------------------------

real rho_app_compete_R_qc_RL_qc(real W)
{
	real B = 0.7597, s0 = 119.3437, Y_1_pp = 11.907, eta_1 = 0.20193, Y_2_pp = 35.454, eta_2 = 0.55543;
	real s = W*W;
	real si_pp = 9*B * log(s/s0) + 9*Y_1_pp * s^(-eta_1) + Y_2_pp * s^(-eta_2);

	real si_pp_rho_pp = 9 * pi * B/2  - 9 * Y_1_pp * s^(-eta_1) / tan (pi * (1. - eta_1) / 2.) + Y_2_pp * s^(-eta_2) * tan (pi * (1. - eta_2) / 2.);

	return si_pp_rho_pp / si_pp;
}

//----------------------------------------------------------------------------------------------------

void DrawPoint(real W, real si, real em, real ep, pen col=red, marker m, real corr=0)
{
	draw((Scale((W, si-em)) + (corr, 0) )--Scale((W, si))--(Scale((W, si+ep)) + (corr, 0)), col);
	draw(Scale((W, si)), m);
}

//----------------------------------------------------------------------------------------------------

real x_corr_scale = 0.03;
real x_corr = 0;

void DrawPointUnc(real v, real u, mark m)
{
	real W = 8e3;
	draw(Scale((W, v)) + (x_corr, 0), m+2pt+true+red);
	draw(shift(x_corr) * (Scale((W, v-u))--Scale((W, v+u))), red+0.8pt);

	x_corr += x_corr_scale;
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

real size = 13cm;
NewPad("$\sqrt s\ung{GeV}$", "$\rh$", size, size*2/3);
currentpad.yTicks=RightTicks(0.05, 0.01);
scale(Log, Linear);

// PDG data
PlotRho("pbarp_elastic_reim.dat", heavygreen, mTU+2pt+false);
PlotRho("pp_elastic_reim.dat", blue, mTD+2pt+true);

AddToLegend("<PDG:");
AddToLegend("$\rm \bar pp$", mTU+false+3pt+heavygreen);
AddToLegend("$\rm pp$", mTD+true+3pt+blue);

// TOTEM measurements
AddToLegend("<TOTEM:");

// 7 TeV
DrawPoint(7e3, 0.145, 0.091, 0.091, red+0.8pt, mCi+false+2pt+red);
AddToLegend("$\sqrt s = 7\un{TeV}$", mCi+false+3pt+red);

// 8 TeV
DrawPoint(8e3, 0.12, 0.03, 0.03, red+0.8pt, mCi+true+2pt+red);
AddToLegend("$\sqrt s = 8\un{TeV}$", mCi+true+3pt+red);

// 13 TeV
DrawPoint(13e3, 0.10, 0.01, 0.01, red+0.8pt, mCi+true+2pt+red);
AddToLegend("$\sqrt s = 13\un{TeV}$", mCi+true+3pt+red);

// fits
AddToLegend("<COMPETE model $\rm RRP_{nf}L2_{u}$ (highest rank):");
draw(graph(rho_app_compete_RRP_nf_L2_u, 1e1, 2e4), heavygreen, "$\rm\bar pp$");
draw(graph(rho_pp_compete_RRP_nf_L2_u, 1e1, 2e4), blue, "$\rm pp$");

//AddToLegend("<COMPETE model $\rm R^{qc}RL^{qc}$:");
//draw(graph(rho_app_compete_R_qc_RL_qc, 1e1, 2e4), black, "$\rm\bar pp$");
//draw(graph(rho_pp_compete_R_qc_RL_qc, 1e1, 2e4), red, "$\rm pp$");


limits((1e1, -0.2), (2e4, +0.25), Crop);

AttachLegend(shift(0, 0)*BuildLegend(NW), NE);

GShipout(margin=0.5mm, hSkip=5mm);

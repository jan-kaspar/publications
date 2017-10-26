import root;
import pad_layout;

//----------------------------------------------------------------------------------------------------
// code to plot PDG data
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
		m.ref = bits[9];

		m.si_ep = sqrt(si_sep^2 + (m.si*si_srep/100)^2);
		m.si_em = sqrt(si_sem^2 + (m.si*si_srem/100)^2);
		
		data.push(m);
	}
	
	return 0;
}

//----------------------------------------------------------------------------------------------------

int DrawDataSet(string filename, pen col, mark m, string legend="")
{
	Meas data[];
	LoadFile(filename, data);

	col += squarecap;

	for (Meas e : data)
	{
		// W = sqrt(s)
		real W = p2W(e.p);
		real W_min = p2W(e.p_min);
		real W_max = p2W(e.p_max);

		if (W > 8.12e3 && W < 8.13e3)
			W += 150;

		draw(Scale((W_min, e.si))--Scale((W_max, e.si)), col);
		draw(Scale((W, e.si - e.si_em))--Scale((W, e.si + e.si_ep)), col);
		draw(Scale((W, e.si)), m+false+1.5pt+col);

		/*
		if (W > 10)
			write(format("AddPoint(%.3E", W) + format(", %.3f", e.si) + format(", %.3f);", (e.si_em + e.si_ep)/2));
		*/
	}

	return 0;
}

//----------------------------------------------------------------------------------------------------

int DrawInelasticDataSet(string fileT, string fileE, pen col, mark m)
{
	Meas dataT[], dataE[];
	LoadFile(fileT, dataT);
	LoadFile(fileE, dataE);

	col += squarecap;

	for (int idxT : dataT.keys)
	{
		for (int idxE : dataE.keys)
		{
			if (dataT[idxT].p == dataE[idxE].p && dataT[idxT].ref == dataE[idxE].ref)
			{
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

//----------------------------------------------------------------------------------------------------

int DrawElToTotDataSet(string fileT, string fileE, pen col, mark m)
{
	write(">> DrawElToTotDataSet");

	col += squarecap;

	Meas dataT[], dataE[];
	LoadFile(fileT, dataT);
	LoadFile(fileE, dataE);

	write("dataT.length = ", dataT.length);
	write("dataE.length = ", dataE.length);

	for (int idxT : dataT.keys)
	{
		for (int idxE : dataE.keys)
		{
			if (dataT[idxT].p == dataE[idxE].p && dataT[idxT].ref == dataE[idxE].ref)
			{
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
//----------------------------------------------------------------------------------------------------

// fine shift
real fsh=0;

void DrawPoint(real W, real si, real em, real ep=em, pen col=red, marker m, string label="")
{
	col += squarecap;

	draw(shift(fsh, 0)*(Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);

	if (label != "")
		AddToLegend(label, nullpen, m);

	// reset fine shift
	fsh = 0;
}

//----------------------------------------------------------------------------------------------------

void DrawPointE(real W, real Wm, real Wp, real si, real em, real ep, pen col=red, marker m, string label="")
{
	col += squarecap;

	draw(shift(fsh, 0)* (Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)* (Scale((W-Wm, si))--Scale((W+Wp, si))), col);
	draw(shift(fsh, 0)*Scale((W, si)), col, m);

	if (label != "")
		AddToLegend(label, nullpen, m);

	// reset fine shift
	fsh = 0;
}


//----------------------------------------------------------------------------------------------------
// cross-section and rho fits
//----------------------------------------------------------------------------------------------------

RootObject obj_compete_si_tot_pp = RootGetObject("compete/distributions.root", "Model_RRPL2u_21/g_si_p_p");
RootObject obj_compete_si_tot_app = RootGetObject("compete/distributions.root", "Model_RRPL2u_21/g_si_p_ap");

RootObject obj_compete_rho_pp = RootGetObject("compete/distributions.root", "Model_RRPL2u_21/g_rho_p_p");
RootObject obj_compete_rho_app = RootGetObject("compete/distributions.root", "Model_RRPL2u_21/g_rho_p_ap");

real si_tot_app_compete(real W)
{
	return obj_compete_si_tot_app.rExec("Eval", W);
}

//----------------------------------------------------------------------------------------------------

real si_tot_pp_compete(real W)
{
	return obj_compete_si_tot_pp.rExec("Eval", W);
}

//----------------------------------------------------------------------------------------------------

real si_el_fit_TOTEM(real W)
{
	real s = W*W;
	real xi = log(s);

	/*
	fit including
		* PDG points with sqrt(s) > 10 GeV
		* TOTEM measurements
  NO.   NAME      VALUE            ERROR          SIZE      DERIVATIVE 
   1  p0           1.18407e+01   2.58281e-01   1.00963e-04  -7.31567e-07
   2  p1          -1.61727e+00   6.58012e-02   1.52574e-05  -4.09819e-06
   3  p2           1.35940e-01   4.07407e-03   2.04687e-06  -2.18175e-05
	*/

	return 11.84 - 1.617 *xi + 0.1359 *xi*xi;
}

//----------------------------------------------------------------------------------------------------

real si_inel_pp_fit_diff(real W)
{
	return si_tot_pp_compete(W) - si_el_fit_TOTEM(W);
}

//----------------------------------------------------------------------------------------------------

real si_inel_app_fit_diff(real W)
{
	return si_tot_app_compete(W) - si_el_fit_TOTEM(W);
}

//----------------------------------------------------------------------------------------------------

real si_el_to_tot_pp_fit_ratio(real W)
{
	return si_el_fit_TOTEM(W) / si_tot_pp_compete(W) * 100.;
}

//----------------------------------------------------------------------------------------------------

real si_el_to_tot_app_fit_ratio(real W)
{
	return si_el_fit_TOTEM(W) / si_tot_app_compete(W) * 100.;
}

//----------------------------------------------------------------------------------------------------

void DrawCompeteUncBand(string bup, string bdw, pen p)
{
	RootObject obj_up = RootGetObject("compete/uncertainty_RRPL2u_21.root", bup);
	RootObject obj_dw = RootGetObject("compete/uncertainty_RRPL2u_21.root", bdw);

	guide g_up, g_dw;
	for (int i = 0; i < obj_up.iExec("GetN"); ++i)
	{
		real ax[] = {0.};
		real ay[] = {0.};
		obj_up.vExec("GetPoint", i, ax, ay);
		g_up = g_up -- Scale((ax[0], ay[0]));

		obj_dw.vExec("GetPoint", i, ax, ay);
		g_dw = g_dw -- Scale((ax[0], ay[0]));
	}

	guide g = g_up -- reverse(g_dw) -- cycle;
	filldraw(g, p, nullpen);
}

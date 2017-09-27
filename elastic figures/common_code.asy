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
	}

	return 0;
}

//----------------------------------------------------------------------------------------------------

int DrawInelasticDataSet(string fileT, string fileE, pen col, mark m)
{
	Meas dataT[], dataE[];
	LoadFile(fileT, dataT);
	LoadFile(fileE, dataE);

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
// code to plot cross-section fits
//----------------------------------------------------------------------------------------------------

// +1 for p-anti p
// -1 for p-p
real compete_fit_sign = 0;

real SigmaTotFit(real W)
{
	real s0 = 29.1, s1 = 1;
	real Z = 35.5, B = 0.307, Y1 = 42.6, Y2 = compete_fit_sign*33.4;
	real et1 = 0.46, et2 = 0.545;

	real s = W^2;
	return Z + B * log(s/s0)^2 + Y1*(s1/s)^et1 + Y2*(s1/s)^et2;
}

//----------------------------------------------------------------------------------------------------

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

//----------------------------------------------------------------------------------------------------

real SigmaInelFit(real W)
{
	return SigmaTotFit(W) - SigmaElFit(W);
}

//----------------------------------------------------------------------------------------------------

real RatioSigmaElToTotFit(real W)
{
	return SigmaElFit(W) / SigmaTotFit(W) * 100.;
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

// fine shift
real fsh=0;

void DrawPoint(real W, real si, real em, real ep=em, pen col=red, marker m, string label="")
{
	draw(shift(fsh, 0)*(Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);

	if (label != "")
		AddToLegend(label, nullpen, m);

	// reset fine shift
	fsh = 0;
}

//----------------------------------------------------------------------------------------------------

/*
void DrawPointRel(real W, real si, real re, pen col=red, marker m)
{
	draw(shift(fsh, 0)*(Scale((W, si*(1-re/100)))--Scale((W, si*(1+re/100)))), col);
	draw(shift(fsh, 0)*Scale((W, si)), m);

	// reset fine shift
	fsh = 0;
}
*/

//----------------------------------------------------------------------------------------------------

void DrawPointE(real W, real Wm, real Wp, real si, real em, real ep, pen col=red, marker m, string label="")
{
	draw(shift(fsh, 0)* (Scale((W, si-em))--Scale((W, si+ep))), col);
	draw(shift(fsh, 0)* (Scale((W-Wm, si))--Scale((W+Wp, si))), col);
	draw(shift(fsh, 0)*Scale((W, si)), col, m);

	if (label != "")
		AddToLegend(label, nullpen, m);

	// reset fine shift
	fsh = 0;
}


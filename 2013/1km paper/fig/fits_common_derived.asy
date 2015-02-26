include pad_layout;
include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/plots/base";

string topDir = "../analysis_combined/coulomb_analysis/";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

// datasets
string dataColls[];
pen dataColl_colors[];

////dataColls.push("1000-ob-1-4"); dataColl_colors.push(black);
////dataColls.push("1000-ob-1-10"); dataColl_colors.push(red);
////dataColls.push("1000-ob-3-4"); dataColl_colors.push(black);
////dataColls.push("1000-ob-5-4"); dataColl_colors.push(orange);
//dataColls.push("1000-ob-0-1"); dataColl_colors.push(orange);

////dataColls.push("1000-ob-3-4,90-DS4-sc-ob"); dataColl_colors.push(heavygreen);
dataColls.push("1000-ob-0-1,90-DS4-sc-ob"); dataColl_colors.push(heavygreen);

////dataColls.push("1000-ob4,90-DS2-ob,90-DS4-sc-ob"); dataColl_colors.push(blue);

// fit methods
string fitters[] = {
//	"simple",

	"parcmp",

	//"simsep-1000,v,v,v-90,v,v,f",
	//"simsep-90,v,v,f-1000,f,f,v",

	//"simsep-1000,v,v,v-90,f,v,f",
	//"simsep-90,v,v,f-1000,v,f,v",
	
//	"simsep-1000,f,f,v-90,v,v,f",
//	"simsep-1000,v,f,v-90,f,v,f",

//	"simple",
};

string methods[] = {
//	"1,SWY,con,chisq,,st+sy",
	
	"1,KL,con,chisq,,st+sy",
	"2,KL,con,chisq,,st+sy",
	"3,KL,con,chisq,,st+sy",

/*
	"1,KL,bai,chisq,,st+sy",
	"2,KL,bai,chisq,,st+sy",
	"3,KL,bai,chisq,,st+sy",

	"1,KL,std,chisq,,st+sy",
	"2,KL,std,chisq,,st+sy",
	"3,KL,std,chisq,,st+sy",
*/

/*
	"1,KL,per-var4,chisq,,st+sy",
	"2,KL,per-var4,chisq,,st+sy",
	"3,KL,per-var4,chisq,,st+sy",
*/

	"1,KL,per-var0,chisq,,st+sy",
	"2,KL,per-var0,chisq,,st+sy",
	"3,KL,per-var0,chisq,,st+sy",

/*
	"1,KL,per-var4,chisq,,st+sy",
	"2,KL,per-var4,chisq,,st+sy",
	"3,KL,per-var4,chisq,,st+sy",

	"1,KL,per-var8,chisq,,st+sy",
	"2,KL,per-var8,chisq,,st+sy",
	"3,KL,per-var8,chisq,,st+sy",
*/
};

//----------------------------------------------------------------------------------------------------

bool plotChiSqNorm_1fit = false;
bool plotChiSqNorm = false;
bool plotSig = false;
bool plotDPt = false;
bool plotP0 = false;
bool plotRho = true;
bool plotIntercept = false;
bool plotB = true;
bool plotSigmaTot = true;

bool plotBRMSEl = false;
bool plotBRMSInel = false;
bool plotBRMSTot = false;

//----------------------------------------------------------------------------------------------------

string TickLabels(real x)
{
	if (x >=0 && x < methods.length)
		return FormatMethodName("bla:" +methods[(int)x]);
	else
		return "";
}

//----------------------------------------------------------------------------------------------------

int idx = 0;

if (plotChiSqNorm_1fit)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX 1st fit: $\ch^2 / \hbox{ndf}$}");
}

if (plotChiSqNorm)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\ch^2 / \hbox{ndf}$}");
}

if (plotSig)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX significance}");
}

if (plotDPt)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX decisive point $|t|$'s}");
}

if (plotP0)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $p_0$}");
}

if (plotRho)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\rh \equiv \left. {\Re F^{\rm H}\over \Im F^{\rm H}}\right |_{t=0}$}");
}

if (plotIntercept)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\d\si^{\rm H}_{\rm el}/\d t|_0\ung{mb/GeV^2}$}");
}

if (plotB)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\left. B^{\rm H}\right |_{t = 0}\ung{GeV^{-2}}$}");
}

if (plotSigmaTot)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\si_{\rm tot}^{\rm H}\ung{mb}$}");
}

if (plotBRMSEl)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\sqrt{\langle b^2\rangle_{\rm el}}\ung{fm}$}");
}

if (plotBRMSInel)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\sqrt{\langle b^2\rangle_{\rm inel}}\ung{fm}$}");
}

if (plotBRMSTot)
{
	NewPad(false, -1, ++idx); label("{\SetFontSizesXX $\sqrt{\langle b^2\rangle_{\rm tot}}\ung{fm}$}");
}

//----------------------------------------------------------------------------------------------------
// prepare pads

pen ref_pen = olive;
pen ref_unc_pen = yellow+opacity(0.4);

PadSet padSets[];

xSizeDef = 2.3cm * (methods.length + 1);

for (int di = 0; di < 1; ++di)
{
	//NewPad(false, 0, di);
	//label("{\SetFontSizesXX " + replace(dataColls[di], "_", "\_") + "}");
	
	real x_min = -1, x_max = methods.length;
	
	PadSet ps;

	xTicksDef = LeftTicks(TickLabels, Step=1, step=0);
	//yTicksDef = RightTicks(Step=0.01, step=0.002);
	idx = 0;

	if (plotChiSqNorm_1fit)
	{
		ps.chi1fit = NewPad("", "$\ch^2 / \hbox{ndf}$", yTicks = RightTicks(Step=1, step=0.2), di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotChiSqNorm)
	{
		ps.chi = NewPad("", "$\ch^2 / \hbox{ndf}$", yTicks = RightTicks(Step=1, step=0.2), di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotSig)
	{
		ps.sig = NewPad("", "significance$\ung{\si}$", yTicks = RightTicks(Step=1, step=0.2), di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotDPt)
	{
		ps.dpt = NewPad("", "$|t|\ung{GeV^2}$", yTicks = RightTicks(Step=0.05, step=0.01), di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotP0)
	{
		ps.p0 = NewPad("", "", di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotRho)
	{
		ps.rho = NewPad("", "", yTicks = RightTicks(Step=0.05, step=0.01), di, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}
	
	xTicksDef = LeftTicks(Label(" "), Step=1, step=0);

	if (plotIntercept)
	{
		ps.a = NewPad("", "$\d\si/\d t|_0\ung{mb/GeV^2}$", yTicks = RightTicks(Step=10, step=2), di, ++idx);
		real v = 540, u = 27; // stat only: u = 5;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}

	if (plotB)
	{
		ps.B = NewPad("", "$B\ung{GeV^{-2}}$", yTicks = RightTicks(Step=1, step=0.2), di, ++idx);
		real v = 19.9, u = 0.3; // stat only: u = 0.1;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}
	
	if (plotSigmaTot)
	{
		ps.si_tot = NewPad("", "$\si_{\rm tot}^{\rm H}\ung{mb}$", yTicks = RightTicks(Step=1, step=0.2), di, ++idx);
		real v = 101.7, u = 2.9;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}

	if (plotBRMSEl)
		ps.b_rms_el = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm el}}\ung{fm}$", di, ++idx);

	if (plotBRMSInel)
		ps.b_rms_inel = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm inel}}\ung{fm}$", di, ++idx);

	if (plotBRMSTot)
		ps.b_rms_tot = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm tot}}\ung{fm}$", di, ++idx);

	padSets[di] = ps;
}

//----------------------------------------------------------------------------------------------------

int points_per_method = fitters.length * dataColls.length;
int idx_per_method = -1;

picture p_legend;

for (int fi : fitters.keys)
{
	currentpicture = p_legend;
	AddToLegend("<{\it " + replace(fitters[fi], "_", "\_") + "}");

	for (int di : dataColls.keys)
	{
		string dataColl = dataColls[di];

		++idx_per_method;
	
		// determine point color		
		// TODO
		//pen p = dataColl_colors[di];
		pen p = StdPen(idx_per_method);

		pen ca[] = {red, heavygreen, cyan, magenta, orange};
		pen p = ca[idx_per_method];

		// add point to legend
		currentpicture = p_legend;
		AddToLegend(dataColls[di], mCi+2pt+p);
	
		for (int meti : methods.keys)
		{
			string method = methods[meti];
	
			string df = topDir + "data/"+dataColl+"/"+fitters[fi] + ":" + method+"/fit.out";
			if (dataColl == "old")
				df = "../../4000GeV,beta1000/coulomb_analysis/data/merged/combined/"+replace(method, "st+sy", "st+mis+nor")+"/dsdt.out";
	
			write(df);
	
			Results ra[] = { new Results };
			ParseData(df, ra);
			Results r = ra[0];

			real dx = 0.10;
			real x = meti + dx * (idx_per_method - ((real) (points_per_method - 1)) / 2.);
	
			// result valid?
			bool valid = r.Valid();
	
			// plot results
			int psi = 0;
	
			if (plotChiSqNorm_1fit)
			{
				SetPad(padSets[psi].chi1fit);
				DrawPoint(x, r.quality, 0, p, valid);
				//label(format("%.3f", r.chi_sq_norm), (x, r.chi_sq_norm), S);
			}
	
			if (plotChiSqNorm)
			{
				SetPad(padSets[psi].chi);
				DrawPoint(x, r.chi_sq_norm, 0, p, valid);
				//label(format("%.3f", r.chi_sq_norm), (x, r.chi_sq_norm), S);
			}
	
			if (plotSig)
			{
				SetPad(padSets[psi].sig);
				DrawPoint(x, r.sig, 0, p, valid);
				//label(format("%.3f", r.sig), (x, r.sig), S);
			}
	
			if (plotDPt)
			{
				SetPad(padSets[psi].dpt);
				for (int i : r.decisivePoints.keys)
					DrawPoint(x, r.decisivePoints[i], 0, p, false);
			}
	
			if (plotP0)
			{
				SetPad(padSets[psi].p0); DrawPoint(x, r.p0, r.p0_e, p, valid);
			}
	
			if (plotRho)
			{
				SetPad(padSets[psi].rho); DrawPoint(x, r.rho, r.rho_e, p, valid);
			}
	
			if (plotIntercept)
			{
				SetPad(padSets[psi].a); DrawPoint(x, r.a, r.a_e, p, valid);
			}
	
			if (plotB)
			{
				SetPad(padSets[psi].B); DrawPoint(x, r.B, r.B_e, p, valid);
			}
	
			real si_tot = sqrt(19.572 / (1 + r.rho^2) * r.a);
			real si_tot_e = (r.rho_e > 0 && r.a_e > 0) ? si_tot/2 * sqrt( (2*r.rho / (1 + r.rho^2) * r.rho_e)^2 + (r.a_e / r.a)^2 ) : 0;
	
			if (plotSigmaTot)
			{
				SetPad(padSets[psi].si_tot); DrawPoint(x, si_tot, si_tot_e, p, valid);
			}

			if (plotBRMSEl)
			{
				SetPad(padSets[psi].b_rms_el); DrawPoint(x, r.b_rms_el, 0, p, valid);
			}

			if (plotBRMSInel)
			{
				SetPad(padSets[psi].b_rms_inel); DrawPoint(x, r.b_rms_inel, 0, p, valid);
			}

			if (plotBRMSTot)
			{
				SetPad(padSets[psi].b_rms_tot); DrawPoint(x, r.b_rms_tot, 0, p, valid);
			}
	
			/*
			write(
				format("rho = %.3f", r.rho) + format(" +- %.3f", r.rho_e)
				+ format(", si_tot = %.3f", si_tot) + format(" +- %.3f", si_tot_e)
				+ format(", B = %.3f", r.B) + format(" +- %.3f", r.B_e)
			);
			*/
		}
	}
}

//----------------------------------------------------------------------------------------------------

currentpicture = p_legend;
AddToLegend("<{\it Phys. Rev. Lett. 111, 012001 (2013):}");
AddToLegend("mean $B^{\rm C+H}$ and $\si_{\rm tot}$", MarkerArray(mSq+10pt+ref_unc_pen, scale(1, 1/10)*(mSq+10pt+ref_pen)));

//----------------------------------------------------------------------------------------------------

for (int psi : padSets.keys)
{
	real x_min = -1, x_max = methods.length;
	
	if (plotChiSqNorm_1fit)
	{
		SetPad(padSets[psi].chi1fit);
		limits((x_min, 0), (x_max, 10), Crop);
		for (real y = 0; y <= 10; y += 1)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotChiSqNorm)
	{
		SetPad(padSets[psi].chi);
		limits((x_min, 0), (x_max, 10), Crop);
		for (real y = 0; y <= 10; y += 1)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotSig)
	{
		SetPad(padSets[psi].sig);
		limits((x_min, 0), (x_max, 10), Crop);
		for (real y = 0; y <= 10; y += 1)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotDPt)
	{
		SetPad(padSets[psi].dpt);
		limits((x_min, 0.), (x_max, 0.2), Crop);
		for (real y = 0.; y <= 0.2; y += 0.05)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotP0)
	{
		SetPad(padSets[psi].p0);
		limits((x_min, 1.4), (x_max, 1.6), Crop);
		for (real y = 1.4; y < 1.6; y += 0.02)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotRho)
	{
		SetPad(padSets[psi].rho);

		// stamp
		/*
		label("\vbox{\hbox{\strut{\bf TOTEM} {\it PRELIMINARY}}\hbox{\strut elastic scattering}\hbox{\strut$\sqrt s = 8\un{TeV}$, $\be^* = 1000$ (and 90) m}}",
			(1, 0), E, Fill(1mm, white));
		*/

		limits((x_min, -0.05), (x_max, 0.20), Crop);
		for (real y = 0.; y < 0.2; y += 0.05)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotIntercept)
	{
		SetPad(padSets[psi].a);
		limits((x_min, 500), (x_max, 580), Crop);
		for (real y = 500; y < 580; y += 10)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotB)
	{
		SetPad(padSets[psi].B);
		limits((x_min, 19), (x_max, 22), Crop);
		for (real y = 19; y < 22; y += 0.2)
			xaxis(YEquals(y, false), dotted);
	}
	
	if (plotSigmaTot)
	{
		SetPad(padSets[psi].si_tot);
		limits((x_min, 98), (x_max, 106), Crop);
		for (real y = 98; y < 106; y += 1)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSEl)
	{
		SetPad(padSets[psi].b_rms_el);
		limits((x_min, 0), (x_max, 3), Crop);
		for (real y = 0; y < 3; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSInel)
	{
		SetPad(padSets[psi].b_rms_inel);
		limits((x_min, 0), (x_max, 3), Crop);
		for (real y = 0; y < 3; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSTot)
	{
		SetPad(padSets[psi].b_rms_tot);
		limits((x_min, 0), (x_max, 3), Crop);
		for (real y = 0; y < 3; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}

	//--------------------
	
	/*
	NewPad(false, 2, 1);
	frame f_legend = BuildLegend(p_legend);
	attach(shift(0, 100)*f_legend);
	*/
}

GShipout(vSkip=0, margin=0mm);

include pad_layout;

include "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,combined/coulomb_analysis/plots/base.asy";
import patterns;

string topDir = "../analysis_combined/coulomb_analysis/";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

add("hatch-excl", hatch(1.7mm, NE, black));

ySizeDef = 3.8cm;
real columnWidth = 1.8cm;

//----------------------------------------------------------------------------------------------------

// datasets
struct ColumnData
{
	string labels[];
};

struct PointData
{
	string src;
	pen p;
};

int colIdx = -1;
ColumnData columns[];
PointData points[][];

void AddColumn(... string labels[])
{
	ColumnData cd;
	cd.labels = labels;
	columns.push(cd);

	points.push(new PointData[]);
	colIdx = points.length - 1;
}

void AddPoint(string src, pen p)
{
	PointData pd;
	pd.src = src;
	pd.p = p;

	points[colIdx].push(pd);
}

pen cyan2 = 0.5*lightblue + 0.5*heavygreen;

if (true)
{
	for (int nb = 1; nb <= 3; ++nb)
	{
		string nbs = format("%i", nb);
		AddColumn("$N_b = "+nbs+"$", "constant");
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmp:"+nbs+",KL,con,chisq,,st+sy", black);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-90,v,v,f-1000,f,f,v:"+nbs+",KL,con,chisq,,st+sy", red);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-90,f,v,f-1000,v,f,v:"+nbs+",KL,con,chisq,,st+sy", blue);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-1000,f,f,v-90,v,v,f:"+nbs+",KL,con,chisq,,st+sy", magenta);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-1000,v,f,v-90,f,v,f:"+nbs+",KL,con,chisq,,st+sy", cyan2);
	}
	
	for (int nb = 1; nb <= 3; ++nb)
	{
		string nbs = format("%i", nb);
		AddColumn("$N_b = "+nbs+"$", "peripheral");
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpper:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", black);
	
		// shape variable in fit
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmppersepm2-90,v,v,f,v-1000,f,f,v,f:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", red);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmppersepm2-90,f,v,f,v-1000,v,f,v,f:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", blue);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmppersepm2-1000,f,f,v,f-90,v,v,f,v:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", magenta);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmppersepm2-1000,v,f,v,f-90,f,v,f,v:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", cyan2);
		
		/*
		// shape fixed
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-90,v,v,f-1000,f,f,v:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", red);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-90,f,v,f-1000,v,f,v:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", blue);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-1000,f,f,v-90,v,v,f:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", magenta);
		AddPoint("1000-ob-0-1,90-DS4-sc-ob/parcmpsepm2-1000,v,f,v-90,f,v,f:"+nbs+",KL,per-exa"+nbs+"-1,chisq,,st+sy", cyan2);
		*/
	}

}

//----------------------------------------------------------------------------------------------------

bool plotChiSqNorm_1fit = false;
bool plotChiSqNorm = false;
bool plotSig = true;
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
	if (x >= 0 && x < columns.length)
	{
		int ci = (int) (x + 0.5);

		string label = "\vbox{";
		for (int li : columns[ci].labels.keys)
			label += "\hbox to0pt{\hss " + columns[ci].labels[li] + "\hss}";
		label += "}";

		return label;
	} else
		return "";
}

//----------------------------------------------------------------------------------------------------
// prepare pads

pen ref_pen = olive;
pen ref_unc_pen = yellow+opacity(0.4);

PadSet padSet;

xSizeDef = columnWidth * (columns.length + 1);

{
	real x_min = -1, x_max = columns.length;

	xTicksDef = LeftTicks(TickLabels, Step=1, step=0);
	//yTicksDef = RightTicks(Step=0.01, step=0.002);

	int idx = 0;

	if (plotChiSqNorm_1fit)
	{
		padSet.chi1fit = NewPad("", "$\ch^2 / \hbox{ndf}$", yTicks = RightTicks(Step=1, step=0.2), 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotChiSqNorm)
	{
		padSet.chi = NewPad("", "$\ch^2 / \hbox{ndf}$", yTicks = RightTicks(Step=1, step=0.2), 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotSig)
	{
		padSet.sig = NewPad("", "significance$\ung{\si}$", yTicks = RightTicks(Step=2, step=1), 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotDPt)
	{
		padSet.dpt = NewPad("", "$|t|\ung{GeV^2}$", yTicks = RightTicks(Step=0.05, step=0.01), 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotP0)
	{
		padSet.p0 = NewPad("", "", 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);
	}

	if (plotRho)
	{
		padSet.rho = NewPad("", "\hbox to10mm{\hfil}$\rh$", yTicks = RightTicks(Step=0.05, step=0.01), 0, ++idx);
		xTicksDef = LeftTicks(Label(" "), Step=1, step=0);

		real v = 0.140, u = 0.007;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, heavygreen+opacity(0.3), nullpen);
		draw((x_min, v)--(x_max, v), darkgreen+2pt);
	}
	
	xTicksDef = LeftTicks(Label(" "), Step=1, step=0);

	if (plotIntercept)
	{
		padSet.a = NewPad("", "$\d\si/\d t|_0\ung{mb/GeV^2}$", yTicks = RightTicks(Step=10, step=2), 0, ++idx);

		real v = 540, u = 27; // stat only: u = 5;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}

	if (plotB)
	{
		padSet.B = NewPad("", "$B^{\rm N}(t = 0)\ung{GeV^{-2}}$", yTicks = RightTicks(Step=0.5, step=0.1), 0, ++idx);

		real v = 19.9, u = 0.3; // stat only: u = 0.1;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}
	
	if (plotSigmaTot)
	{
		padSet.si_tot = NewPad("", "$\si_{\rm tot}\ung{mb}$", yTicks = RightTicks(Step=2, step=1), 0, ++idx);

		real v = 101.7, u = 2.9;
		filldraw((x_min, v-u)--(x_max, v-u)--(x_max, v+u)--(x_min, v+u)--cycle, ref_unc_pen, nullpen);
		draw((x_min, v)--(x_max, v), ref_pen+2pt);
	}

	if (plotBRMSEl)
		padSet.b_rms_el = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm el}}\ung{fm}$", 0, ++idx);

	if (plotBRMSInel)
		padSet.b_rms_inel = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm inel}}\ung{fm}$", 0, ++idx);

	if (plotBRMSTot)
		padSet.b_rms_tot = NewPad("", "$\sqrt{\langle b^2\rangle_{\rm tot}}\ung{fm}$", 0, ++idx);
}

//----------------------------------------------------------------------------------------------------


picture p_legend;

for (int coli : columns.keys)
{
	int points_per_method = points[coli].length;

	for (int pnti : points[coli].keys)
	{
		PointData pd = points[coli][pnti];
	
		string df = topDir + "data/" + pd.src + "/fit.out";
		write(df);
	
		Results ra[] = { new Results };
		ParseData(df, ra);
		Results r = ra[0];
	
		// result valid?
		bool valid = r.Valid();
	
		// plot results
		pen p = pd.p;

		real dx = 0.10;
		real x = coli + dx * (pnti - ((real) (points_per_method - 1)) / 2.);

		if (plotChiSqNorm_1fit)
		{
			SetPad(padSet.chi1fit);
			DrawPoint(x, r.quality, 0, p, valid);
			//label(format("%.3f", r.chi_sq_norm), (x, r.chi_sq_norm), S);
		}
	
		if (plotChiSqNorm)
		{
			SetPad(padSet.chi);
			DrawPoint(x, r.chi_sq_norm, 0, p, valid);
			//label(format("%.3f", r.chi_sq_norm), (x, r.chi_sq_norm), S);
		}
	
		if (plotSig)
		{
			SetPad(padSet.sig);

			if (find(pd.src, "sepm2") >= 0)
			{
				bool first90 = (find(pd.src, "sepm2-90") >= 0);
				mark m1 = (first90) ? mTD : mTU;
				mark m2 = (first90) ? mTU : mTD;
				
				DrawPoint(x, r.sig_p, 0, p, m1+2pt+p, valid);
				DrawPoint(x, r.sig, 0, p, m2+2pt+p, valid);
			} else {
				DrawPoint(x, r.sig, 0, p, valid);
				//label(format("%.3f", r.sig), (x, r.sig), N);
			}
		}
	
		if (plotDPt)
		{
			SetPad(padSet.dpt);
			for (int i : r.decisivePoints.keys)
				DrawPoint(x, r.decisivePoints[i], 0, p, false);
		}
	
		if (plotP0)
		{
			SetPad(padSet.p0); DrawPoint(x, r.p0, r.p0_e, p, valid);
		}
	
		if (plotRho)
		{
			SetPad(padSet.rho); DrawPoint(x, r.rho, r.rho_e, p, valid);
		}
	
		if (plotIntercept)
		{
			SetPad(padSet.a); DrawPoint(x, r.a, r.a_e, p, valid);
		}
	
		if (plotB)
		{
			SetPad(padSet.B); DrawPoint(x, r.B, r.B_e, p, valid);
		}
	
		real si_tot = sqrt(19.572 / (1 + r.rho^2) * r.a);
		real si_tot_e = (r.rho_e > 0 && r.a_e > 0) ? si_tot/2 * sqrt( (2*r.rho / (1 + r.rho^2) * r.rho_e)^2 + (r.a_e / r.a)^2 ) : 0;
	
		if (plotSigmaTot)
		{
			SetPad(padSet.si_tot); DrawPoint(x, si_tot, si_tot_e, p, valid);
		}

		if (plotBRMSEl)
		{
			SetPad(padSet.b_rms_el); DrawPoint(x, r.b_rms_el, 0, p, valid);
		}

		if (plotBRMSInel)
		{
			SetPad(padSet.b_rms_inel); DrawPoint(x, r.b_rms_inel, 0, p, valid);
		}

		if (plotBRMSTot)
		{
			SetPad(padSet.b_rms_tot); DrawPoint(x, r.b_rms_tot, 0, p, valid);
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

//----------------------------------------------------------------------------------------------------

currentpicture = p_legend;
AddToLegend("<{\it Phys. Rev. Lett. 111, 012001 (2013):}");
AddToLegend("mean $B^{\rm C+H}$ and $\si_{\rm tot}$", MarkerArray(mSq+10pt+ref_unc_pen, scale(1, 1/10)*(mSq+10pt+ref_pen)));

//----------------------------------------------------------------------------------------------------

void MarkExcludedColumns(real y_min, real y_max)
{
	for (int ci = 0; ci < 1; ++ci)
	{
		filldraw((ci-0.4, y_min)--(ci+0.4, y_min)--(ci+0.4, y_max)--(ci-0.4, y_max)--cycle, pattern("hatch-excl"), nullpen);
	}
}

//----------------------------------------------------------------------------------------------------

{
	real x_min = -1, x_max = columns.length;
	
	if (plotChiSqNorm_1fit)
	{
		SetPad(padSet.chi1fit);
		limits((x_min, 0), (x_max, 10), Crop);
		for (real y = 0; y <= 10; y += 1)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotChiSqNorm)
	{
		SetPad(padSet.chi);
		limits((x_min, 0), (x_max, 10), Crop);
		for (real y = 0; y <= 10; y += 1)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotSig)
	{
		SetPad(padSet.sig);
		limits((x_min, 0), (x_max, 10), Crop);
		MarkExcludedColumns(0, 10);
		for (real y = 0; y <= 10; y += 2)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);

		AddToLegend("common fit", mCi+2pt+black);
		AddToLegend("start: 90, $a$: 90", mCi+2pt+red);
		AddToLegend("start: 90, $a$: 1000", mCi+2pt+blue);
		AddToLegend("start: 1000, $a$: 90", mCi+2pt+magenta);
		AddToLegend("start: 1000, $a$: 1000", mCi+2pt+cyan2);
		AttachLegend(BuildLegend(NE, vSkip=-1mm, lineLength=5mm), NE);
	}

	if (plotDPt)
	{
		SetPad(padSet.dpt);
		limits((x_min, 0.), (x_max, 0.2), Crop);
		for (real y = 0.; y <= 0.2; y += 0.05)
			xaxis(YEquals(y, false), (fabs(y - 0.) < 1e-4) ? dashed : dotted);
	}

	if (plotP0)
	{
		SetPad(padSet.p0);
		limits((x_min, 1.4), (x_max, 1.6), Crop);
		for (real y = 1.4; y < 1.6; y += 0.02)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotRho)
	{
		SetPad(padSet.rho);
		limits((x_min, -0.05), (x_max, 0.15), Crop);
		MarkExcludedColumns(-0.05, 0.15);
		for (real y = 0.; y < 0.15; y += 0.05)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotIntercept)
	{
		SetPad(padSet.a);
		limits((x_min, 500), (x_max, 580), Crop);
		for (real y = 500; y < 580; y += 10)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotB)
	{
		SetPad(padSet.B);
		limits((x_min, 18.9), (x_max, 21.3), Crop);
		MarkExcludedColumns(18.9, 21.3);
		for (real y = 19; y < 21.2; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}
	
	if (plotSigmaTot)
	{
		SetPad(padSet.si_tot);
		limits((x_min, 98), (x_max, 108), Crop);
		MarkExcludedColumns(98, 108);
		for (real y = 98; y < 108; y += 2)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSEl)
	{
		SetPad(padSet.b_rms_el);
		limits((x_min, 0), (x_max, 3), Crop);
		for (real y = 0; y < 3; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSInel)
	{
		SetPad(padSet.b_rms_inel);
		limits((x_min, 0), (x_max, 3), Crop);
		for (real y = 0; y < 3; y += 0.5)
			xaxis(YEquals(y, false), dotted);
	}

	if (plotBRMSTot)
	{
		SetPad(padSet.b_rms_tot);
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

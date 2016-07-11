import root;
import pad_layout;
include "../analysis/plots/run_info.asy";

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string datasets[] = { "DS2a", "DS2b" };

string diagonals[] = { "45b_56t", "45t_56b" };
string dgn_labels[] = { "45b -- 56t", "45t -- 56b" };
pen dgn_pens[] = { blue, red };

string topDir = "../analysis/";

xSizeDef = 6.5cm;
ySizeDef = 4cm;

xTicksDef = LeftTicks(1., 0.5);

TGraph_errorBar = None;

transform paperTimeShift = shift(-23, 0);

//----------------------------------------------------------------------------------------------------

void DrawBeamDivergence(rObject g_vtx_rms, pen p, marker m, string label)
{
	int N = g_vtx_rms.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = { 0 };
		real ya[] = { 0 };
		g_vtx_rms.vExec("GetPoint", i, xa, ya);
		real time = xa[0];
		real vtx_rms = ya[0] / 1e3;	// in m
		real vtx_rms_unc = g_vtx_rms.rExec("GetErrorY", i) / 1e3;

		real bd = sqrt(2) * vtx_rms / 1000;
		real bd_unc = sqrt(2) * vtx_rms_unc / 1000;

		if (bd != 0)
		{
			draw(swToHours*scale(1, 1e6)*(time, bd), p, m);
			draw(swToHours*scale(1, 1e6)*((time, bd - bd_unc)--(time, bd + bd_unc)), p);
		}
	}
}

//----------------------------------------------------------------------------------------------------

void DrawMeanSensorResolution(rObject g_vtx_rms, rObject g_diffRL_th_x, pen p, marker m, string label)
{
	int N = g_vtx_rms.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = { 0 };
		real ya[] = { 0 };
		g_vtx_rms.vExec("GetPoint", i, xa, ya);
		real time = xa[0];
		real vtx_rms = ya[0] / 1e3;	// in m
		real vtx_rms_unc = g_vtx_rms.rExec("GetErrorY", i) / 1e3;
		
		g_diffRL_th_x.vExec("GetPoint", i, xa, ya);
		real diff = ya[0];
		real diff_unc = g_diffRL_th_x.rExec("GetErrorY", i);

		real bd = sqrt(2) * vtx_rms / 1000;
		real bd_unc = sqrt(2) * vtx_rms_unc / 1000;

		real rr = sqrt(diff*diff/2 - bd*bd);
		real rr_unc = (rr > 0) ? sqrt(diff*diff*diff_unc*diff_unc + 4.*bd*bd*bd_unc*bd_unc) / 2 / rr: 0.;

		real lambda_mean = 0.215;
		rr /= lambda_mean;
		rr_unc /= lambda_mean;

		if (bd != 0)
		{
			draw(swToHours*scale(1, 1e6)*(time, rr), p, m);
			draw(swToHours*scale(1, 1e6)*((time, rr-rr_unc)--(time, rr+rr_unc)), p);
		}
	}
}

//----------------------------------------------------------------------------------------------------

void DrawFinalThXResolution(rObject g_vtx_rms, rObject g_diffRL_th_x, real msr, pen p, marker m, string label)
{
	int N = g_vtx_rms.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real xa[] = { 0 };
		real ya[] = { 0 };
		g_vtx_rms.vExec("GetPoint", i, xa, ya);
		real time = xa[0];
		real vtx_rms = ya[0] / 1e3;	// in m
		real vtx_rms_unc = g_vtx_rms.rExec("GetErrorY", i) / 1e3;
		
		g_diffRL_th_x.vExec("GetPoint", i, xa, ya);
		real diff = ya[0];
		real diff_unc = g_diffRL_th_x.rExec("GetErrorY", i);

		real bd = sqrt(2) * vtx_rms / 1000;
		real bd_unc = sqrt(2) * vtx_rms_unc / 1000;

		real si_sr = msr / 111.8;

		real res = sqrt(bd*bd/2 + si_sr*si_sr);
		real res_unc = bd * bd_unc / 2 / res;

		if (bd != 0)
		{
			draw(paperTimeShift * swToHours*scale(1, 1e6)*(time, res), p, m);
			draw(paperTimeShift * swToHours*scale(1, 1e6)*((time, res-res_unc)--(time, res+res_unc)), p);
		}
	}
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

NewPad("time $\ung{h}$", "resolution in $\theta_x^*\ung{\mu rad}$");
currentpad.yTicks = RightTicks(0.05, 0.01);
DrawRunBands(paperTimeShift, 0.5, 0.7, false);
for (int dsi : datasets.keys)
{
	for (int dgni : diagonals.keys)
	{
		rObject obj_vtx_x = rGetObj(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "time dependences/gRMS_vtx_x_vs_time");
		rObject obj_diffRL_vtx_x = rGetObj(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "time dependences/gRMS_diffLR_th_x_vs_time");

		real msr = 0;
		if (diagonals[dgni] == "45b_56t") msr = 12.0e-6;
		if (diagonals[dgni] == "45t_56b") msr = 10.85e-6;

		DrawFinalThXResolution(obj_vtx_x, obj_diffRL_vtx_x, msr, dgn_pens[dgni], mCi+1pt+dgn_pens[dgni], dgn_labels[dgni]);
	}
}

limits((0, 0.5), (9.2, 0.7), Crop);
for (real y=0.5; y <= 0.7; y += 0.05)
	xaxis(YEquals(y, false), dotted);

//----------------------------------------------------------------------------------------------------
//NewRow();

NewPad("time $\ung{h}$", "resolution in $\theta_y^*\ung{\mu rad}$");
currentpad.yTicks = RightTicks(0.02, 0.01);
DrawRunBands(paperTimeShift, 0.42, 0.52, false);
for (int dsi : datasets.keys)
{
	currentpicture.legend.delete();

	for (int dgni : diagonals.keys)
	{
		draw(paperTimeShift * swToHours*scale(1, 0.5 * 1e6),
			rGetObj(topDir+datasets[dsi]+"/distributions_"+diagonals[dgni]+".root", "time dependences/gRMS_diffLR_th_y_vs_time"), "p,eb,d0",
			dgn_pens[dgni], mCi+1pt+dgn_pens[dgni], dgn_labels[dgni]);

		rObject fit = rGetObj(topDir+"beam_divergence/analyze.root", "combined/fitted");
	}
}

limits((0, 0.42), (9.2, 0.52), Crop);
for (real y = 0.42; y <= 0.52; y += 0.02)
	xaxis(YEquals(y, false), dotted);

GShipout(hSkip=5mm, margin=0mm);

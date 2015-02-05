import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesVIII");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "../analysis_combined/coulomb_analysis/";

string f_mod = topDir + "vojtech/t-distributions,pp,8000GeV.root";

string f_fit = topDir + "data/ob-3-4/merged/combined/fit:3,KL,cen,chisq,,st+sy/dsdt.root";

string models[] = {
	"block [06]", 
	"bourrely [03]", 
	"islam (lxg) [06,09]", 
	"jenkovszky [11]", 
	"petrov (2p) [02]", 
	"petrov (3p) [02]", 
};

xSizeDef = 8cm;
ySizeDef = 5cm;

//----------------------------------------------------------------------------------------------------

real p0 = pi/2 - 0.12;


real ConstantPhase(real mt)
{
	return p0;
}

real BaillyPhase(real mt)
{
	real t_d = 0.5301;

	return atan((1 - abs(mt) / t_d) * tan(p0));
}

real StandardPhase(real mt)
{
	real t0 = 0.5;
	real tau = 0.1;
	real ph = atan( (mt - t0)/tau ) - atan( -t0/tau) + p0;

	return ph;
	//return (ph > pi) ? ph - 2*pi : ph;
}

real PeripheralPhase(real mt)
{
	/*
			double xi1[] = { 1.959, 1.9896, 2.003, 2.017, 2.022, 2.588, 2.014, 2.004, 1.992        }; // 1e4
			double ka[] = { 4.499, 4.328, 4.248, 4.112, 4.031, 4.071, 3.871, 3.797, 3.726          }; // 1
			double nu[] = { 10.214, 10.586, 10.773, 11.103, 11.349, 11.914, 11.836, 12.073, 12.322 }; // GeV^{-2}
	*/


	//real xi1_v = 3.317, ka_v = 4.009, nu_v = 12.912;
	
	// var4
	real xi1_v = 2.022, ka_v = 4.031, nu_v = 11.349;

	real ze = xi1_v * 1e4 * mt^ka_v * exp(- nu_v * mt);

	return p0 - ze;
}

//----------------------------------------------------------------------------------------------------

guide ContinuousGraph(rObject obj)
{
	int N = obj.iExec("GetN");
	
	guide g;
	real y_prev = 0.;
	for (int i = 0; i < N; ++i)
	{
		real[] xa = {0};
		real[] ya = {0};
		obj.vExec("GetPoint", i, xa, ya);
		real y = ya[0];
		
		if (i > 0)
		{
			if (y - y_prev < -pi)
				y += 2pi;

			if (y - y_prev > +pi)
				y -= 2pi;
		}

		g = g--(xa[0], y);

		y_prev = y;
	}

	return g;
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\arg {\cal A}^{\rm N}(t)\ung{\pi}$");

AddToLegend("<{\it theoretical models}:");

for (int mi : models.keys) 
{
	rObject obj = rGetObj(f_mod, "full range/" + models[mi] + "/PH/phase");
	string label = obj.sExec("GetTitle");
	label = substr(label, 0, find(label, " ["));
	pen p = StdPen(mi) + dashed;
	draw(scale(1., 1/pi) * ContinuousGraph(obj), p, label);
}

//AddToLegend("<{\it parametrisation examples ($\rh$ fixed to " + format("%.2f", 1./tan(p0)) + ")}:");
AddToLegend("<{\it parametrisation examples}:");

draw(scale(1., 1/pi) * graph(ConstantPhase, 0, 1), black+1pt, "constant");
draw(scale(1., 1/pi) * graph(StandardPhase, 0, 1, 200), blue+1pt, "standard");
draw(scale(1., 1/pi) * graph(BaillyPhase, 0, 1), red+1pt, "Bailly");
draw(scale(1., 1/pi) * graph(PeripheralPhase, 0, 1), heavygreen+1pt, "peripheral");

limits((0, -1.5), (1, +1.5), Crop);
AttachLegend(BuildLegend(NW, vSkip=-0.5mm), NE);

xaxis(YEquals(0, false), dotted);

GShipout(margin=0mm);

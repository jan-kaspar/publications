import root;
import pad_layout;

string f = "/afs/cern.ch/user/j/jkaspar/software/elegent/distributions/t-distributions,pp,13000GeV.root";

string models[] = {
	"block [06]",
	"bourrely [03]",
	"dl [13]",
	"ferreira [14]",
	"godizov [14]",
	"islam (hp) [06,09]",
	"islam (lxg) [06,09]",
	"jenkovszky [11]",
	"petrov (3p) [02]",  
};

//----------------------------------------------------------------------------------------------------

void DrawEffect(string model, pen p)
{
	RootObject o_pc = RootGetObject(f, "low |t|/PC/differential cross-section", search=false);
	RootObject o_ph = RootGetObject(f, "low |t|/" + model + "/PH/differential cross-section", search=false);
	RootObject o_kl = RootGetObject(f, "low |t|/" + model + "/KL/differential cross-section", search=false);

	guide g_eff;

	int N = o_pc.iExec("GetN");
	for (int i = 0; i < N; ++i)
	{
		real a_t[] = {0};
		real a_pc[] = {0};
		//real a_ph[] = {0};
		//real a_kl[] = {0};

		o_pc.vExec("GetPoint", i, a_t, a_pc);
		//o_ph.vExec("GetPoint", i, a_t, a_ph);
		//o_kl.vExec("GetPoint", i, a_t, a_kl);

		real t = a_t[0];
		real dsdt_pc = a_pc[0];
		real dsdt_ph = o_ph.rExec("Eval", t);
		real dsdt_kl = o_kl.rExec("Eval", t);

		real eff = (dsdt_kl - dsdt_ph - dsdt_pc) / (dsdt_pc + dsdt_ph);

		g_eff = g_eff--Scale((t, eff));
	}

	draw(g_eff, p, model);
}

//----------------------------------------------------------------------------------------------------

NewPad("$|t|\ung{GeV^2}$", "$\d\si^{\rm C+N} - \d\si^{\rm C} - \d\si^{\rm N}\over \d\si^{\rm C} + \d\si^{\rm N}$", xSize=8cm);
//scale(Log, Linear);

for (int mi : models.keys)
{
	pen p = StdPen(mi + 1);
	DrawEffect(models[mi], p);
}

limits((0, -0.3), (10e-3, +0.1), Crop);

yaxis(XEquals(6e-4, false), dashed);

legendLabelPen = fontcommand("\SmallerFonts");
AttachLegend("$\sqrt s = 13\un{TeV}$", NW, NE);

GShipout(margin=1mm);

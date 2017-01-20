import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

string datasets[] = {
//	"period1_physics_margin/fill_4947",
	"period1_physics/fill_5261",
};

string arm_tags[];
string arm_labels[];

arm_tags.push("L"); arm_labels.push("sector 45");
arm_tags.push("R"); arm_labels.push("sector 56");


string alignment = "method x";

string cut_option = "with cuts";

xSizeDef = 8cm;
ySizeDef = 6cm;

real xi_min = 0.03;
real xi_max = 0.20;

TH2_palette = Gradient(blue, heavygreen, yellow, red);

//----------------------------------------------------------------------------------------------------

for (int ai : arm_tags.keys)
{
	NewPad(false);
	label("{" + replace(arm_labels[ai], "_", "\_") + "}");
}

for (int dsi : datasets.keys)
{
	NewRow();

	/*
	NewPad(false);
	string bits[] = split(replace(datasets[dsi], "_", "\_"), "/");
	label("\vbox{\SetFontSizesXX\hbox{" + bits[0] + "}\hbox{" + bits[1] + "}}");
	*/

	for (int ai : arm_tags.keys)
	{
		NewPad("$\xi^{\rm N}$", "$\xi^{\rm F}$");

		string arm = arm_tags[ai];
		string f = topDir + datasets[dsi] + "/reconstruction_test.root";
		RootObject obj = RootGetObject(f, alignment+"/"+cut_option+"/h2_xi_" + arm + "_F_vs_xi_" + arm + "_N");

		TH2_x_min = xi_min; TH2_x_max = xi_max;
		TH2_y_min = xi_min; TH2_y_max = xi_max;

		draw(obj);

		draw((xi_min, xi_min)--(xi_max, xi_max), black+2pt+dashed);
	
		limits((xi_min, xi_min), (xi_max, xi_max), Crop);
	}
}

GShipout(hSkip=1mm, vSkip=1mm, margin=1mm);

import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

string datasets[] = {
	"run_alignment/10077",
	"run_alignment/10081",

	"run_physics_margin/fill_4947",
//	"run_physics_margin/fill_4953",
//	"run_physics_margin/fill_4961",
	"run_physics_margin/fill_4964",
	
//	"run_physics_no_margin/fill_4964",
//	"run_physics_margin/fill_4976",

//	"run_physics_no_margin/fill_4985",
	"run_physics_no_margin/fill_4988",
//	"run_physics_no_margin/fill_4990",
//	"run_physics_no_margin/fill_5005",
//	"run_physics_no_margin/fill_5013",
//	"run_physics_no_margin/fill_5017",
//	"run_physics_no_margin/fill_5020",
//	"run_physics_no_margin/fill_5021",
//	"run_physics_no_margin/fill_5024",
	"run_physics_no_margin/fill_5026",
//	"run_physics_no_margin/fill_5027",
//	"run_physics_no_margin/fill_5028",
//	"run_physics_no_margin/fill_5029",
//	"run_physics_no_margin/fill_5030",
//	"run_physics_no_margin/fill_5038",
//	"run_physics_no_margin/fill_5043",
//	"run_physics_no_margin/fill_5045",
	"run_physics_no_margin/fill_5048",
//	"run_physics_no_margin/fill_5052",
};

string datasets[] = {
	"run_alignment/10077",
	"run_physics_margin/fill_4947",
};

int rp_ids[];
string rp_labels[];
pen rp_pens[];

rp_ids.push(3); rp_labels.push("L-210-fr-hr"); rp_pens.push(black);
rp_ids.push(2); rp_labels.push("L-210-nr-hr"); rp_pens.push(red);
rp_ids.push(102); rp_labels.push("R-210-nr-hr"); rp_pens.push(blue);
rp_ids.push(103); rp_labels.push("R-210-fr-hr"); rp_pens.push(heavygreen);

string alignment = "method x";

string cut_option = "with cuts";

xSizeDef = 10cm;
xTicksDef = LeftTicks(0.05, 0.01);

//----------------------------------------------------------------------------------------------------

for (int dsi : datasets.keys)
{
	NewPad(false);
	string bits[] = split(replace(datasets[dsi], "_", "\_"), "/");
	label("{\SetFontSizesXX " + bits[0] + " (" + bits[1] + ")}");
}

NewRow();

frame f_legend;

for (int dsi : datasets.keys)
{
	NewPad("$\xi$");
	//scale(Linear, Log(auto));

	for (int rpi : rp_ids.keys)
	{
		string f = topDir + datasets[dsi] + "/reconstruction_test.root";
		RootObject obj = RootGetObject(f, alignment+"/"+cut_option+"/" + format("h_xi_%u", rp_ids[rpi]));
		draw(obj, "vl", rp_pens[rpi], replace(rp_labels[rpi], "_", "\_"));
	}

	xlimits(0, 0.2, Crop);
	//ylimits(1e1, 2e5, Crop);
	
	f_legend = BuildLegend();
}

NewPad(false);
attach(f_legend);

GShipout(hSkip=1mm, vSkip=1mm, margin=1mm);

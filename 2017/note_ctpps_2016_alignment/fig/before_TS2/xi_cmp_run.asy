import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

string datasets[] = {
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

	"run_physics_no_margin/fill_5261",
//	"run_physics_no_margin/fill_5264",
	"run_physics_no_margin/fill_5265",
	"run_physics_no_margin/fill_5266",
	"run_physics_no_margin/fill_5267",

	"run_alignment/10077",
//	"run_alignment/10081",
};

string datasets[] = {
	"run_physics_margin/fill_4947",
	"run_physics_no_margin/fill_4985",
	"run_physics_no_margin/fill_5052",

	"run_physics_no_margin/fill_5261",
	"run_physics_no_margin/fill_5266",
//	"run_physics_no_margin/fill_5288",

	"run_alignment/10077",
};

int rp_ids[];
string rp_labels[];
real rp_norm_min[];
real rp_norm_max[];

rp_ids.push(3); rp_labels.push("L-210-fr-hr"); rp_norm_min.push(0.085); rp_norm_max.push(0.115);
rp_ids.push(2); rp_labels.push("L-210-nr-hr"); rp_norm_min.push(0.085); rp_norm_max.push(0.115);
rp_ids.push(102); rp_labels.push("R-210-nr-hr"); rp_norm_min.push(0.095); rp_norm_max.push(0.160);
rp_ids.push(103); rp_labels.push("R-210-fr-hr"); rp_norm_min.push(0.095); rp_norm_max.push(0.160);

string alignments[] = {
//	"none",
	"method x",
//	"method y",
};

string alignment = "method x";

string cut_option = "with cuts";

bool cropToDetails = false;

real x_min[] = {0.05, 0.05, 0.05,  0.06};
real x_max[] = {0.11, 0.11, 0.14,  0.14};
real y_min[] = {0.03, 0.03, 0.015, 0.015};
real y_max[] = {0.04, 0.04, 0.020, 0.020};


xSizeDef = 8cm;
xTicksDef = (cropToDetails) ? LeftTicks(0.02, 0.01) : LeftTicks(0.05, 0.01);

//----------------------------------------------------------------------------------------------------

real GetNormalisation(RootObject obj, real xi_min, real xi_max)
{
	RootObject x_axis = obj.oExec("GetXaxis");
	int bin_min = x_axis.iExec("FindBin", xi_min);
	int bin_max = x_axis.iExec("FindBin", xi_max);

	real S = 0.;
	for (int bin = bin_min; bin <= bin_max; ++bin)
	{
		S += obj.rExec("GetBinContent", bin);
	}

	return S;
}

//----------------------------------------------------------------------------------------------------

frame f_legend;

for (int rpi : rp_ids.keys)
{
	if (rpi == 2)
		NewRow();

	NewPad("$\xi$");

	for (int dsi : datasets.keys)
	{
		bool alignmentRun = (find(datasets[dsi], "run_alignment") != -1);

		string alignments_eff = alignment;
		if (alignmentRun)
			alignments_eff = "none";

		string f = topDir + datasets[dsi] + "/reconstruction_test.root";
		RootObject obj = RootGetObject(f, alignments_eff+"/"+cut_option+"/" + format("h_xi_%u", rp_ids[rpi]));

		real norm = GetNormalisation(obj, rp_norm_min[rpi], rp_norm_max[rpi]);

		pen p = (alignmentRun) ? black+2pt : StdPen(dsi+1);

		draw(scale(1., 1./norm), obj, "vl", p, replace(datasets[dsi], "_", "\_"));
	}

	if (cropToDetails)
		limits((x_min[rpi], y_min[rpi]), (x_max[rpi], y_max[rpi]), Crop);

	f_legend = BuildLegend();

	currentpicture.legend.delete();

	AttachLegend(rp_labels[rpi]);
}


NewPad(false);
attach(f_legend);


GShipout(hSkip=1mm, vSkip=1mm, margin=1mm);

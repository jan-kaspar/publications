import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

string datasets[] = {
	"period1_alignment/10077",

	"period1_physics_margin/fill_4947",
	"period1_physics/fill_4985",
	"period1_physics/fill_5052",

	"period1_physics/fill_5261",
	"period1_physics/fill_5287",
};

int rp_ids[];
string rp_labels[];
real rp_norm_min[];
real rp_norm_max[];

rp_ids.push(3); rp_labels.push("45-210-fr-hr"); rp_norm_min.push(0.084); rp_norm_max.push(0.114);
rp_ids.push(2); rp_labels.push("45-210-nr-hr"); rp_norm_min.push(0.083); rp_norm_max.push(0.113);
rp_ids.push(102); rp_labels.push("56-210-nr-hr"); rp_norm_min.push(0.085); rp_norm_max.push(0.140);
rp_ids.push(103); rp_labels.push("56-210-fr-hr"); rp_norm_min.push(0.085); rp_norm_max.push(0.145);

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


xSizeDef = 10cm;
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
		bool alignmentRun = (find(datasets[dsi], "_alignment") != -1);

		string alignments_eff = alignment;
		if (alignmentRun)
			alignments_eff = "none";

		string f = topDir + datasets[dsi] + "/reconstruction_test.root";
		RootObject obj = RootGetObject(f, alignments_eff+"/"+cut_option+"/" + format("h_xi_%u", rp_ids[rpi]));

		real norm = GetNormalisation(obj, rp_norm_min[rpi], rp_norm_max[rpi]);

		pen p = (alignmentRun) ? black+2pt : StdPen(dsi);

		draw(scale(1., 1./norm), obj, "vl", p, replace(datasets[dsi], "_", "\_"));
	}

	if (cropToDetails)
		limits((x_min[rpi], y_min[rpi]), (x_max[rpi], y_max[rpi]), Crop);

	f_legend = BuildLegend();

	currentpicture.legend.delete();

	AttachLegend(rp_labels[rpi]);
}


NewPad(false);
attach(shift(0, 20) * f_legend);

GShipout(hSkip=1mm, vSkip=1mm, margin=1mm);

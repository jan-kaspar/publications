import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

string datasets[] = {
	"period1_physics/fill_5261",
	"period1_physics/fill_5265",
	"period1_physics/fill_5266",
	"period1_physics/fill_5267",

	//"period1_physics/fill_5274",
	//"period1_physics/fill_5275",
	//"period1_physics/fill_5276",
	//"period1_physics/fill_5277",

	//"period1_physics/fill_5279",
	//"period1_physics/fill_5287",
	//"period1_physics/fill_5288",

	"period1_physics/fill_5043",
};

//----------------------------------------------------------------------------------------------------

real al_corr[][];

void AddAlCorrection(int fill, real corr_102, real corr_103)
{
	real a[];
	a[102] = corr_102;
	a[103] = corr_103;
	al_corr[fill] = a;
}

/*
AddAlCorrection(5261, -0.00, -0.05);
AddAlCorrection(5265, -0.05, -0.00);
AddAlCorrection(5266, -0.00, -0.05);
AddAlCorrection(5267, -0.00, -0.00);

AddAlCorrection(5274, -0.00, -0.00);
AddAlCorrection(5275, -0.05, -0.10);
AddAlCorrection(5276, -0.07, -0.03);
AddAlCorrection(5277, -0.00, -0.05);

AddAlCorrection(5279, -0.05, -0.00);
AddAlCorrection(5287, -0.05, -0.00);
AddAlCorrection(5288, -0.02, -0.05);
*/

//----------------------------------------------------------------------------------------------------

int rp_ids[];
string rp_labels[];
real rp_norm_min[];
real rp_norm_max[];

//rp_ids.push(3); rp_labels.push("45-210-fr-hr"); rp_norm_min.push(9.0); rp_norm_max.push(13.0);
//rp_ids.push(2); rp_labels.push("45-210-nr-hr"); rp_norm_min.push(9.0); rp_norm_max.push(13.0);
rp_ids.push(102); rp_labels.push("56-210-nr-hr"); rp_norm_min.push(8.5); rp_norm_max.push(12.0);
rp_ids.push(103); rp_labels.push("56-210-fr-hr"); rp_norm_min.push(8.0); rp_norm_max.push(11.5);

string alignments[] = {
//	"none",
	"method x",
//	"method y",
};

string cut_option = "without cuts";

xSizeDef = 8cm;
xTicksDef = LeftTicks(1., 0.5);

//----------------------------------------------------------------------------------------------------

// TODO: remove
real corr = 0;

real GetNormalisation(RootObject obj, real x_min, real x_max)
{
	RootObject x_axis = obj.oExec("GetXaxis");
	// TODO: remove corr
	int bin_min = x_axis.iExec("FindBin", x_min - corr);
	int bin_max = x_axis.iExec("FindBin", x_max - corr);

	real S = 0.;
	for (int bin = bin_min; bin <= bin_max; ++bin)
	{
		S += obj.rExec("GetBinContent", bin);
	}

	return S;
}

//----------------------------------------------------------------------------------------------------

//NewPad(false);
//label(cut_option);

NewRow();

//NewPad(false);
for (int rpi : rp_ids.keys)
{
	NewPad(false);
	label("{\SetFontSizesXIV " + replace(rp_labels[rpi], "_", "\_") + "}");
}

for (int ai : alignments.keys)
{
	NewRow();

	//NewPad(false);
	//label(rotate(90)*Label("{\SetFontSizesXX " + alignments[ai] + "}"));

	for (int rpi : rp_ids.keys)
	{
		NewPad("$x\ung{mm}$");

		TH1_x_min = 1;

		for (int dsi : datasets.keys)
		{
			string dataset = datasets[dsi];

			bool correct = (find(dataset, "_corr") > 0);

			string dataset_label = dataset;
			dataset = replace(dataset, "_corr", "");

			bool alignmentRun = (find(dataset, "period1_alignment") != -1);
			
			// TODO: remove
			bool bold = (find(dataset, "5043") != -1);

			string alignments_eff = alignments[ai];
			if (alignmentRun)
				alignments_eff = "none";

			string f = topDir + dataset + "/reconstruction_test.root";
			RootObject obj = RootGetObject(f, alignments_eff+"/"+cut_option+"/" + format("h_x_%u", rp_ids[rpi]));

			// TODO: do something
			{
				int rp_id = rp_ids[rpi];
	
				int fp = find(dataset, "fill_");
				int fill = -1;
				if (fp > 0)
					fill = (int) substr(dataset, fp+5, 4);
	
				correct = true;
				//correct = false;
	
				corr = 0.;
				if (correct && al_corr.initialized(fill) && al_corr[fill].initialized(rp_id))
					corr = al_corr[fill][rp_id];
			}

			real norm = GetNormalisation(obj, rp_norm_min[rpi], rp_norm_max[rpi]);

			pen p = (alignmentRun || bold) ? black+2pt : StdPen(dsi + 1);

			// TODO: remove corr
			if (norm > 0)
				draw(shift(corr, 0.) * scale(1., 1./norm), obj, "vl", p, replace(dataset_label, "_", "\_"));
		}
	
		//limits((1, 0), (15., 0.10), Crop);
		//xlimits(1, 15., Crop);
		xlimits(1, 5., Crop);
	}

	frame f_legend = BuildLegend();

	NewPad(false);
	attach(f_legend);
}


GShipout(hSkip=1mm, vSkip=1mm, margin=1mm);

import root;
import pad_layout;

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/ctpps/alignment/";

texpreamble("\SetFontSizesVIII");

string datasets[] = {
//	"period1_physics_margin/274199",
//	"period1_physics_margin/274241",
//	"period1_physics/274244",
//	"period1_physics/274388",
//	"period1_physics/274958",
//	"period1_physics/274969",
//	"period1_physics/275125",
//	"period1_physics/275310",
//	"period1_physics/275376",
//	"period1_physics/275836",

	"period1_physics_margin/fill_4947",
	"period1_physics_margin/fill_4953",
	"period1_physics_margin/fill_4961",
	"period1_physics_margin/fill_4964",
	
	"period1_physics/fill_4964",
	"period1_physics_margin/fill_4976",

	"period1_physics/fill_4985",
	"period1_physics/fill_4988",
	"period1_physics/fill_4990",
	"period1_physics/fill_5005",
	"period1_physics/fill_5013",
	"period1_physics/fill_5017",
	"period1_physics/fill_5020",
	"period1_physics/fill_5021",
	"period1_physics/fill_5024",
	"period1_physics/fill_5026",
	"period1_physics/fill_5027",
	"period1_physics/fill_5028",
	"period1_physics/fill_5029",
	"period1_physics/fill_5030",
	"period1_physics/fill_5038",
	"period1_physics/fill_5043",
	"period1_physics/fill_5045",
	"period1_physics/fill_5048",
	"period1_physics/fill_5052",

	"period1_physics/fill_5261",
	"period1_physics/fill_5264",
	"period1_physics/fill_5265",
	"period1_physics/fill_5266",
	"period1_physics/fill_5267",
	"period1_physics/fill_5274",
	"period1_physics/fill_5275",
	"period1_physics/fill_5276",
	"period1_physics/fill_5277",
	"period1_physics/fill_5279",
	"period1_physics/fill_5287",
	"period1_physics/fill_5288",
};

string ref_label[];

ref_label.push("10077");
ref_label.push("10079");
ref_label.push("10081");

string methods[];
pen method_pens[];

//methods.push("method y"); method_pens.push(blue);
methods.push("method x"); method_pens.push(red);

string rps[], rp_labels[];
real rp_shift_m[], rp_shift_no_m[];
rps.push("L_1_F"); rp_labels.push("L-210-fr-hr"); rp_shift_m.push(-3.65); rp_shift_no_m.push(-4.17);
//rps.push("L_1_N"); rp_labels.push("L-210-nr-hr"); rp_shift_m.push(-1.15); rp_shift_no_m.push(-0.00);
//rps.push("R_1_N"); rp_labels.push("R-210-nr-hr"); rp_shift_m.push(-3.32); rp_shift_no_m.push(-3.93);
//rps.push("R_1_F"); rp_labels.push("R-210-fr-hr"); rp_shift_m.push(-2.96); rp_shift_no_m.push(-3.57);

yTicksDef = RightTicks(0.2, 0.1);

xSizeDef = 10cm;
ySizeDef = 4cm;

//----------------------------------------------------------------------------------------------------

string TickLabels(real x)
{
	if (x >=0 && x < datasets.length)
	{
		string ds = datasets[(int)x];
		string bits[] = split(ds, "/");
		return replace(bits[1], "fill_", "");
	} else {
		return "";
	}
}

xTicksDef = LeftTicks(rotate(90)*Label(""), TickLabels, Step=1, step=0);

//----------------------------------------------------------------------------------------------------

/*
for (int rpi : rps.keys)
{
	NewPad(false);
	label("{\SetFontSizesXX " + replace(rps[rpi], "_", "\_") + "}");
}

NewRow();
*/

for (int rpi : rps.keys)
{
	write(rps[rpi]);

	if (rpi == 2)
		NewRow();

	NewPad("fill", "horizontal shift$\ung{mm}$");
	//scale(Linear, Linear(true));

	if (rp_shift_m[rpi] != 0)
	{
		real sh = rp_shift_m[rpi], unc = 0.1;
		real fill_min = -1, fill_max = 6;
		draw((fill_min, sh+unc)--(fill_max, sh+unc), black+dashed);
		draw((fill_min, sh)--(fill_max, sh), black+1pt);
		draw((fill_min, sh-unc)--(fill_max, sh-unc), black+dashed);
		draw((fill_max, sh-2*unc), invisible);
		draw((fill_max, sh+2*unc), invisible);
	}
	
	if (rp_shift_no_m[rpi] != 0)
	{
		real sh = rp_shift_no_m[rpi], unc = 0.1;
		real fill_min = 3, fill_max = datasets.length;
		draw((fill_min, sh+unc)--(fill_max, sh+unc), black+dashed);
		draw((fill_min, sh)--(fill_max, sh), black+1pt);
		draw((fill_min, sh-unc)--(fill_max, sh-unc), black+dashed);
		//filldraw((fill_min, sh-unc)--(fill_max, sh-unc)--(fill_max, sh+unc)--(fill_min, sh+unc)--cycle, black+opacity(0.1), nullpen);
		draw((fill_max, sh-2*unc), invisible);
		draw((fill_max, sh+2*unc), invisible);
	}

	for (int dsi : datasets.keys)
	{
		write("    " + datasets[dsi]);

		mark m = (find(datasets[dsi], "margin") != -1) ? mSq+3pt+false : mCi+2pt;

		for (int mi : methods.keys)
		{
			real S1=0, Ss=0, Su=0;

			for (int ri : ref_label.keys)
			{
				RootGetObject(topDir + datasets[dsi]+"/match.root", rps[rpi] + "/" + ref_label[ri] + "/" + methods[mi] + "/g_results");
				real ax[] = { 0. };
				real ay[] = { 0. };
				robj.vExec("GetPoint", 0, ax, ay); real bsh = ay[0];
				robj.vExec("GetPoint", 1, ax, ay); real bsh_unc = ay[0];
	
				S1 += 1;
				Ss += bsh;		
				Su += bsh_unc;		
			}
			
			real x = dsi;

			real m_sh = Ss / S1;
			real u_sh = Su / S1;

			bool pointValid = (fabs(m_sh) > 0.01);

			pen p =  method_pens[mi];

			if (pointValid)
			{
				draw((x, m_sh), m + p);
				draw((x, m_sh-u_sh)--(x, m_sh+u_sh), p);
			}
		}
	}

	xlimits(-1, datasets.length, Crop);

	//AttachLegend("{\SetFontSizesXX " + rp_labels[rpi] + "}");
}

GShipout(hSkip=5mm, vSkip=1mm);

include "../alignment/common_code.asy";
include "../alignment/statistics/station_base.asy";

xSizeDef = 3.8cm;
ySizeDef = 3.8cm;

StdFonts();

geometry="RP_V:2.7_H:3.3";
options="fixDet-extended,4pl,2units=t,overlap=f,3potsInO=t,1rotz=f";
misalignment="station12_realistic_shr_rotz_4";

file = "../alignment/statistics/simulations5/RP_V:2.7_H:3.3/fixDet-extended,4pl,2units=t,overlap=f,3potsInO=t,1rotz=f/misalignment:station12_realistic_shr_rotz_4/result_summary.root";

RPs = "120,121,122,123,124,125";
optimized = "sr";
tr_dist = "gauss_6_8,th=0.1E-3";

string[] plots = {"systematic error", "estimated uncertainty", "stat. err. / estim. unc."};
string[] tags = { "e_m", "u_m", "eR"};
real[] p_scales = { 1e3, 1e3, 1.};

int coff = 0;

//----------------------------------------------------------------------------------------------------

void MakePlots(string dirLabel, string fileNameLabel, string xLabel, real x_from, real x_to, bool xLog)
{
	xGridHintDef = 0;
	int legendRow = yGridHintDef;
	
	for (int q : quantities.keys) {
		if (find(optimized, oTags[q]) == -1)
			continue;

		for (int p : plots.keys) {
			NewPad(
				(q == 2) ? xLabel : "",
				(p == 0) ? "" : ""
			);
			scale((xLog) ? Log : Linear, Linear(true));
			string opt = "l,p,ec";

			for (int i : rps.keys) {
				string detector = (string) (10*rps[i] + detNum);
				string pth = "RPs>" + RPs + "/"+optimizeStr+">" + optimized +
					"/tr_dist>" + tr_dist + "/" + dirLabel + "/" + detector;
				string obj = pth + "/" + quantities[q] + "/" + tags[p];

				rGetObj(file, obj, error=true);
				if (robj.valid)
					draw(yscale(p_scales[p]), robj, opt, colors[i+coff]+1pt, marks[i+coff]+true+2pt+colors[i+coff],
					RPName(rps[i], "%u-%r"));
			}

			currentpad.yTicks = RightTicks(Step=y_Steps[q], step=y_steps[q]);

			xlimits(x_from, x_to);
			if (p == 2) {
				ylimits(0, 2, Crop);
				xaxis(YEquals(1, false), dotted);
				currentpad.yTicks = RightTicks(Step=0.5, step=0.1);
			} else if (p == 0) {
					ylimits(-ylimits[q]/2, ylimits[q]/2, Crop);
					xaxis(YEquals(0, false), dotted);
				} else {
					ylimits(0, ylimits[q], Crop);
				}
			
			yaxis(XEquals(1e5, false), dotted);

			if (q == 0 && p == 2)
				AttachLegend();
		}

		NewRow();
	}
}

//----------------------------------------------------------------------------------------------------

NewPad(false, 0, -1);
label("systematic error");

NewPad(false, 1, -1);
label("estimated uncertainty");

NewPad(false, 2, -1);
label("stat. error / uncertainty");

NewPad(false, -1, 0);
label(rotate(90)*Label("read-out shift\quad$(\rm\mu m)$"));

NewPad(false, -1, 1);
label(rotate(90)*Label("rotation about $z$\quad $(\rm mrad)$"));

NewPad(false, -1, 2);
label(rotate(90)*Label("read-out shift\quad$(\rm\mu m)$"));

NewPad(false, -1, 3);
label(rotate(90)*Label("rotation about $z$\quad $(\rm mrad)$"));

detNum = 3;

rps = new int[] { 120, 121, 122 };
ylimits = new real[] { 8., 0, 2.};
y_Steps = new real[] {2., 0, 0.5};
y_steps = new real[] {1., 0, 0.1};
coff = 0;
MakePlots("fcn_of_N/iteration>" + iteration, "_fcnN", "", 1e2, 1e6, true);


rps = new int[] { 123, 124, 125 };
ylimits = new real[] { 200., 0, 20.};
y_Steps = new real[] {50., 0, 5};
y_steps = new real[] {10., 0, 1};
coff = 3;
MakePlots("fcn_of_N/iteration>" + iteration, "_fcnN", "tracks analyzed", 1e2, 1e6, true);

GShipout(hSkip=1mm, vSkip=1mm);

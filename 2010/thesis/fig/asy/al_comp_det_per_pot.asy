import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();

xSizeDef = 4.5cm;
ySizeDef = 4.0cm;

string opt_dir = "../alignment/optical";
string tb_dir = "../alignment/testbeam";

string lhc_data[] = {
	"2010_08_24/2762,2763,2770,2772",
//	"2010_08_26/2896,2895,2892,2891",
	"2010_09_21/3230,3231",
//	"2010_09_28/3285,3286,3287,3288                                                                                                                                          ",
//	"2010_10_05/3336,3337",
	"2010_10_07/3359,3360,3361",
//	"2010_10_14/3457,3459,3460",
//	"2010_10_24/3609",
//	"2010_10_26/3634,3635",
	"2010_10_29-30/3723,3725,3728",
};

//---------------------------------------------------------------------------------------------------------------------

bool forceError = false;

void DrawResult(int id, real v, real e, pen p, marker m)
{
	real x = id % 10;
	if (fabs(v) > 1e-1 || (x > 1 && x < 8)) {
		draw((x, v), m);
		draw((x, v-e)--(x, v+e), p, Bars);
	} else
		if (forceError)
			draw((x, v), nullpen, mCi+false+black+2.5pt);
}

//---------------------------------------------------------------------------------------------------------------------
	
pad pShRV, pShRU, pRotZV, pRotZU;
real f_shr_e, f_rotz_e;
real f_shr = 1.;

int dp;
real v_rot_corr[], u_rot_corr[];

void DrawResults(string filename, pen p, marker m, string legend)
{
	Alignment a;
	if (ParseXML(filename, a) != 0) {
		write("  Error: ", filename);
		return;
	}

	for (int id : a.shr.keys) {
		pad pShR = (id % 2 == 0) ? pShRV : pShRU;
		pad pRotZ = (id % 2 == 0) ? pRotZV : pRotZU;

		real rot_corr[] = (id % 2 == 0) ? v_rot_corr : u_rot_corr;
		real rc = (rot_corr.initialized(dp)) ? rot_corr[dp] : 1.;

		SetPad(pShR);
		DrawResult(id, f_shr*a.shr[id], (forceError) ? f_shr_e : a.shr_e[id], p, m);
		
		SetPad(pRotZ);
		DrawResult(id, rc * a.rotz[id], (forceError) ? f_rotz_e : a.rotz_e[id], p, m);
	}

	AddToLegend(legend, p, m);
}

//---------------------------------------------------------------------------------------------------------------------

real si_ax, si_ay;

void GetTrackDivergence(string f)
{
	rGetObj(f, "common/ax_selected");
	if (robj.valid)
		si_ax = robj.rExec("GetRMS");
	rGetObj(f, "common/ay_selected");
	if (robj.valid)
		si_ay = robj.rExec("GetRMS");
}

//---------------------------------------------------------------------------------------------------------------------

real rot_lim = 5, rot_Step = 1, rot_step = 0.5;
real y_leg;
pen markupColor = white;
xTicksDef = LeftTicks(Step=1, step=0);

void DrawDP(int _dp, string constr, bool drawShR, bool drawRotZ, bool drawLegend)
{
	dp = _dp;
	int rp = dp_to_rp[dp];
	write(dp, rp);

	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("$V$ sensors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	
	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("$U$ sensors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	NewRow();
	
	if (drawShR) {
		yTicksDef = RightTicks(Step=20, step=5);
		pShRV = NewPad("", "read-out shift $\quad(\rm\mu m)$");
		pShRU = NewPad("", "");
		NewRow();
	}

	if (drawRotZ) {
		yTicksDef = RightTicks(Step=1, step=0.5);
		pRotZV = NewPad("plane number", "rotation about $z$ $\quad(\rm mrad)$");
		pRotZU = NewPad("plane number", "");
	}

	// OPTICAL DATA
	forceError = true;
	f_shr = -1.;
	f_shr_e = 7;
	f_rotz_e = 0.3;
	pen p = std_pens[1];
	v_rot_corr = v_rot_corr_opt; u_rot_corr = u_rot_corr_opt;

	DrawResults(opt_dir+"/DP"+format("%u", dp)+"/"+constr+".xml", p, mSq+p+2.5pt, "optical");
	
	// TESTBEAM DATA
	forceError = false;
	f_shr = +1.;
	p = std_pens[2];
	v_rot_corr = v_rot_corr_h8; u_rot_corr = u_rot_corr_h8;

	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/"+constr+"/full/iteration5/cumulative_results_Jan.xml", p, mTU+p+2.5pt, "H8 tests (all)");
	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/"+constr+"/even/iteration5/cumulative_results_Jan.xml", p, mTL+p+2.5pt, "H8 tests (even)");
	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/"+constr+"/odd/iteration5/cumulative_results_Jan.xml", p, mTR+p+2.5pt, "H8 tests (odd)");

	//GetTrackDivergence(tb_dir+"/DP"+format("%u", dp)+"/"+constr+"/full/iteration1/diagnostics.root");
	//AddToLegend("$\si(a_x) = " + format("%.1f", si_ax*1e3) + "$, $\si(a_y) = " + format("%.1f", si_ay*1e3) + "\ \rm mrad$");

	// LHC DATA
	string arm = (rp >= 100) ? "56" : "45";
	string unit = ((rp % 10) > 2) ? "far" : "near"; 
	string settings;
	v_rot_corr = new real[]; u_rot_corr = new real[];

	for (int d_i : lhc_data.keys) {
		string bits[] = split(lhc_data[d_i], "/");
		string dataset = bits[0];
		string task = bits[1];

		settings = "s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=f,3potsInO=t";
		p = StdPen(3+d_i);
		//DrawResults("data/"+dataset+"/"+arm+"/"+unit+"/"+settings+"/"+format("%u", rp)+".xml", p, mCi+p+2.5pt,
		//	"LHC "+ replace(dataset, "_", "\_") + " (full)");
		
		//settings = "s+sr-fix,4pl,1rotzIt=0,2units=f,overlap=f,3potsInO=f";
		settings = "s+sr-"+constr+",4pl,1rotzIt=0,2units=f,overlap=f,3potsInO=f";
		DrawResults("../alignment/lhc/"+dataset+"/tb-per-pot/"+task+"/"+format("%u", rp)+"/"+settings
			+"/iteration5/cumulative_expanded_results_Jan.xml", p, mCi+p+2.5pt,
			"LHC "+ Date(dataset));
	}
	
	if (drawShR) {
		real shr_lim = 50, shr_Step=10, shr_step=5;
		
		SetPad(pShRV);
		currentpad.yTicks = RightTicks(Step=shr_Step, step=shr_step);
		limits((-0.5, -shr_lim), (9.5, +shr_lim), Crop);
		xaxis(YEquals(0, false), dotted);
		
		SetPad(pShRU);
		currentpad.yTicks = RightTicks(Step=shr_Step, step=shr_step);
		limits((-0.5, -shr_lim), (9.5, +shr_lim), Crop);
		xaxis(YEquals(0, false), dotted);
	}

	if (drawRotZ) {
		SetPad(pRotZV);
		currentpad.yTicks = RightTicks(Step=rot_Step, step=rot_step);
		limits((-0.5, -rot_lim), (9.5, +rot_lim), Crop);
		xaxis(YEquals(0, false), dotted);
	
		SetPad(pRotZU);
		currentpad.yTicks = RightTicks(Step=rot_Step, step=rot_step);
		limits((-0.5, -rot_lim), (9.5, +rot_lim), Crop);
		xaxis(YEquals(0, false), dotted);
	}

	if (drawLegend) {
		AddToLegend("fixed planes", (marker)(mCi+false+black+2.5pt));
		frame lf = Legend(RPName(rp)+format(" (DP %u)", dp), O);	
		NewPad(false, 2, 1);
		add(lf);
		FixPad(10cm, y_leg);
	}
}

//---------------------------------------------------------------------------------------------------------------------

rot_lim = 10; rot_Step = 2; rot_step = 1; y_leg = -2.75cm;
DrawDP(2, "fix-ext", drawShR=false, drawRotZ=true, drawLegend=true);
GShipout("al_comp_det_per_pot_dp2_ext", vSkip=1mm, hSkip=1mm);

rot_lim = 1.5; rot_Step = 0.5; rot_step = 0.1; y_leg = -5.5cm;
DrawDP(1, "fix-ext2", drawShR=true, drawRotZ=true, drawLegend=true);
GShipout("al_comp_det_per_pot_dp1_ext2", vSkip=1mm, hSkip=1mm);

DrawDP(2, "fix-ext2", drawShR=true, drawRotZ=true, drawLegend=true);
GShipout("al_comp_det_per_pot_dp2_ext2", vSkip=1mm, hSkip=1mm);

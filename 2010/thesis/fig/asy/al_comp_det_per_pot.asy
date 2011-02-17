import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();

xSizeDef = 5cm;
ySizeDef = 5cm;

//---------------------------------------------------------------------------------------------------------------------

int dp_to_rp[];
dp_to_rp[1] = 23;
dp_to_rp[2] = 123;
dp_to_rp[3] = 125;
dp_to_rp[4] = 124;
dp_to_rp[5] = 120;
dp_to_rp[6] = 121;
dp_to_rp[7] = 122;
dp_to_rp[8] = 22;
dp_to_rp[9] = 24;
dp_to_rp[10] = 25;
dp_to_rp[11] = 20;
dp_to_rp[12] = 21;

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
	if (v != 0 || (x > 1 && x < 8)) {
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

		SetPad(pShR);
		DrawResult(id, f_shr*a.shr[id], (forceError) ? f_shr_e : a.shr_e[id], p, m);
		
		SetPad(pRotZ);
		DrawResult(id, a.rotz[id], (forceError) ? f_rotz_e : a.rotz_e[id], p, m);
	}

	AddToLegend(legend, p, m);
}

//---------------------------------------------------------------------------------------------------------------------

pen markupColor = paleyellow;
xTicksDef = LeftTicks(Step=1, step=0);

for (int dp = 2; dp <= 2; ++dp) {
	int rp = dp_to_rp[dp];
	write(dp, rp);

	if (dp > 1)
		NewPage();

	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("V detectors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	
	NewPad(drawAxes = false);
	picture p; 
	label(p, rotate(0)*Label("U detectors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	NewRow();
	
	yTicksDef = RightTicks(Step=20, step=5);
	pShRV = NewPad("plane number", "shift in $v\quad(\rm\mu m)$");
	pShRU = NewPad("plane number", "shift in $u\quad(\rm\mu m)$");
	NewRow();
	yTicksDef = RightTicks(Step=1, step=0.5);
	pRotZV = NewPad("plane number", "rotation around $z\quad(\rm mrad)$");
	pRotZU = NewPad("plane number", "rotation around $z\quad(\rm mrad)$");

	// OPTICAL DATA
	forceError = true;
	f_shr = -1.;
	f_shr_e = 7;
	f_rotz_e = 0.2;
	pen p = std_pens[1];
	DrawResults(opt_dir+"/DP"+format("%u", dp)+"/constrained.xml", p, mSq+p+2.5pt, "optical alignment");
	
	// TESTBEAM DATA
	forceError = false;
	f_shr = +1.;
	p = std_pens[2];
	//DrawResults(tb_dir+"/DP"+format("%u", dp)+"/full/iteration2/cumulative_results_Jan.xml", cyan, mTU+cyan+2.5pt);
	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/full/iteration5/cumulative_results_Jan.xml", p, mTU+p+2.5pt, "beam/cosmics tests 2008-2009");
	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/even/iteration5/cumulative_results_Jan.xml", p, mTL+p+2.5pt, "beam/cosmics tests (even subset)");
	DrawResults(tb_dir+"/DP"+format("%u", dp)+"/odd/iteration5/cumulative_results_Jan.xml", p, mTR+p+2.5pt, "beam/cosmics tests (odd subset)");

	// LHC DATA
	string arm = (rp >= 100) ? "56" : "45";
	string unit = ((rp % 10) > 2) ? "far" : "near"; 
	//string label = ((rp % 10) > 2) ? "-far" : ""; 
	string settings = "s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=f,3potsInO=t";

	for (int d_i : lhc_data.keys) {
		string bits[] = split(lhc_data[d_i], "/");
		string dataset = bits[0];
		string task = bits[1];

		string settings = "s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=f,3potsInO=t";
		p = StdPen(3+d_i);
		DrawResults("../alignment/lhc comparisons/data/"+dataset+"/"+arm+"/"+unit+"/"+settings
			+"/"+format("%u", rp)+".xml", p, mCi+p+2.5pt,
			"LHC "+ replace(dataset, "_", "\_") + " (full)");
		
		/*
		settings = "s+sr-fix,4pl,1rotzIt=0,2units=f,overlap=f,3potsInO=f";
		DrawResults("../lhc/"+dataset+"/tb-per-pot/"+task+"/"+format("%u", rp)+"/"+settings+"/"
			+"/iteration5/cumulative_expanded_results_Jan.xml", p, mCr+p+5.5pt,
			"LHC "+ replace(dataset, "_", "\_") + " (one pot)");
		*/
	}
	
	SetPad(pShRV);
	limits((-0.5, -70), (9.5, +70), Crop);
	xaxis(YEquals(0, false), dotted);
	SetPad(pShRU);
	limits((-0.5, -70), (9.5, +70), Crop);
	xaxis(YEquals(0, false), dotted);
	SetPad(pRotZV);
	limits((-0.5, -5), (9.5, +5), Crop);
	xaxis(YEquals(0, false), dotted);

	SetPad(pRotZU);
	limits((-0.5, -5), (9.5, +5), Crop);
	xaxis(YEquals(0, false), dotted);

	AddToLegend("fixed degrees of freedom", (marker)(mCi+false+black+2.5pt));
	frame lf = Legend("DP: "+format("%u", dp)+", RP: "+RPName(rp)+" ("+format("%u", rp)+")", O);
	
	NewPad(false, 0, 3);
	add(lf);
}

GShipout(vSkip=1mm, hSkip=1mm);

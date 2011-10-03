import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();
xSizeDef = 6.4cm;
ySizeDef = 3.5cm;

//---------------------------------------------------------------------------------------------------------------------

void DrawResult(int id, real v, real e, pen p, marker m)
{
	real x = id;
	//if (v != 0) {
		draw((x, v), m);
		draw((x, v-e)--(x, v+e), p, Bars);

	//} else
		//draw((x, v), nullpen, mCi+false+black+2.5pt);
}

//---------------------------------------------------------------------------------------------------------------------

int dataset_idx, opt_idx;

void NextDataSet()
{
	++dataset_idx;
	opt_idx = 0;
}

//---------------------------------------------------------------------------------------------------------------------
	
pad pShRU, pRotZU, pFRotZU;
pad pShRV, pRotZV, pFRotZV;
real f_shr_e, f_rotz_e;
real f_shr = 1.;

string arm, unit;
string labels[];
mark marks[];

//---------------------------------------------------------------------------------------------------------------------

void AddFits(string file)
{
	Alignment al;
	if (ParseXML(file, al) > 0)
		return;

	for (int r = 120; r < 123; ++r) {
		for (int proj = 0; proj < 2; ++proj) {
			real S1=0, Sx=0, Sxx=0, Sy=0, Sxy=0;
			for (int p = 0; p < 10; ++p) {
				bool v_proj = (proj == 0);
				bool v_plane = (p % 2 == 0);
				if (r == 122)
					v_plane = !v_plane;
				if (v_proj != v_plane)
					continue;

				int id = 10*r + p;
				real x = id;
				real y = al.shr[id];
				S1 += 1;
				Sx += x;
				Sxx += x*x;
				Sy += y;
				Sxy += x*y;
			}
			
			real det = Sxx*S1 - Sx*Sx;
			if (det == 0)
				continue;

			real a = (S1*Sxy - Sx*Sy)/det;
			real b = (Sy*Sxx - Sx*Sxy)/det;
			real x_min = r*10, x_max = r*10+9;
	
			pad p = (proj == 0) ? pShRV : pShRU;
			SetPad(p);
			draw((x_min, a*x_min+b)--(x_max, a*x_max+b), dashed);
			
			pad p = (proj == 0) ? pFRotZV : pFRotZU;
			SetPad(p);
			real rot = al.rp_rotz[r];
			draw((x_min, rot)--(x_max, rot), dashed);
			
			/*
			pad p = (proj == 0) ? pRotZV : pRotZU;
			SetPad(p);
			real rot = 0;
			draw((x_min, rot)--(x_max, rot), dashed);
			*/
		}
	}	
}

//---------------------------------------------------------------------------------------------------------------------

void AddData(string file, string label)
{
	Alignment a;
	if (ParseXML(file, a) > 0)
		return;

	labels.push(label);
	pen p = StdPen(dataset_idx-4);
	mark m = StdMark(opt_idx)+p+1.5pt;
	marks.push(m);

	for (int id : a.shr.keys) {
		if (unit == "far" && (id % 100) < 30)
			continue;
		if (unit != "far" && (id % 100) >= 30)
			continue;

		bool vDet = (id % 2) == 0;
		int rp = quotient(id, 10);
		int r = rp % 10;
		if (r == 2 || r == 3)
			vDet = !vDet;

		//write(id);
		//write("   ", vDet);

		pad pShR = (vDet) ? pShRV : pShRU;
		//pad pRotZ = (vDet) ? pRotZV : pRotZU;
		pad pFRotZ = (vDet) ? pFRotZV : pFRotZU;

		SetPad(pShR);
		DrawResult(id, f_shr*a.shr[id], a.shr_e[id], p, m);
		
		//SetPad(pRotZ);
		//DrawResult(id, a.rotz[id], a.rotz_e[id], p, m);
		
		SetPad(pFRotZ);
		DrawResult(id, a.rotz[id]+a.rp_rotz[rp], a.rotz_e[id], p, m);
	}

	++opt_idx;
}

//---------------------------------------------------------------------------------------------------------------------

void AddDataS(string dir)
{
	string label = substr(dir, 0, find(dir, "/"));
	AddData("data/"+dir+"/cumulative_factored_results_Jan.xml", label);
}

//---------------------------------------------------------------------------------------------------------------------

string legendTitle;

void AttLeg()
{
	/*
	NewPad(false, 0, 3);
	for (int li : labels.keys)
		AddToLegend(replace(labels[li], "_", "\_"), marks[li]);
	
	AttachLegend(legendTitle, 2, (0, 0), (0, 0));
	*/
}

//---------------------------------------------------------------------------------------------------------------------

int rp_min;

string xTickLabel(real x)
{
	return format("%.0f", (x % 10));
}

xTicksDef = LeftTicks(xTickLabel, Step=2, step=0);

void Finalize()
{
	real Step=100, step=20, laby = 150;
	SetPad(pShRV);
	limits((rp_min*10-0.5, -200), (rp_min*10+29.5, +200), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));
	
	SetPad(pShRU);
	limits((rp_min*10-0.5, -200), (rp_min*10+29.5, +200), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));

	/*
	Step = 1; step = 0.2; laby = -1.5;
	SetPad(pRotZV);
	limits((rp_min*10-0.5, -2), (rp_min*10+29.5, +2), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));
	
	SetPad(pRotZU);
	limits((rp_min*10-0.5, -2), (rp_min*10+29.5, +2), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));
	*/
	
	Step = 5; step = 1; laby = -10;
	SetPad(pFRotZV);
	limits((rp_min*10-0.5, -15), (rp_min*10+29.5, +15), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));
	
	SetPad(pFRotZU);
	limits((rp_min*10-0.5, -15), (rp_min*10+29.5, +15), Crop);
	currentpad.yTicks = RightTicks(Step=Step, step=step);
	yaxis(XEquals(rp_min*10+9.5, false), RightTicks("%", Step=Step, step=step));
	yaxis(XEquals(rp_min*10+19.5, false), RightTicks("%", Step=Step, step=step));
	label("\strut "+RPName(rp_min+0, "%r"), (rp_min*10+4.5, laby));
	label("\strut "+RPName(rp_min+1, "%r"), (rp_min*10+14.5, laby));
	label("\strut "+RPName(rp_min+2, "%r"), (rp_min*10+24.5, laby));

	AttLeg();
}

//---------------------------------------------------------------------------------------------------------------------


pen markupColor = white;

bool attachLegend = false;

void NewUnit(string _arm, string _unit)
{
	if (attachLegend) {
		Finalize();
		NewPage();
	}
	
	arm = _arm;
	unit = _unit;
	string label = arm+"-"+unit;

	attachLegend = true;
	legendTitle = label;
	labels.delete();
	marks.delete();
	dataset_idx = 0;
	opt_idx = 0;

	write(label);

	rp_min = (arm == "56") ? 120 : 20;
	if (unit == "far")
		rp_min += 3;

	NewPad(drawAxes = false, 0, -1);
	picture p; 
	label(p, rotate(0)*Label("$V$ sensors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	
	NewPad(drawAxes = false, 1, -1);
	picture p; 
	label(p, rotate(0)*Label("$U$ sensors"));
	attach(bbox(p, 1mm, nullpen, Fill(markupColor)));
	

	pShRV = NewPad("", "");
	pShRU = NewPad();
	NewRow();
	//pRotZV = NewPad("", "");
	//pRotZU = NewPad();
	//NewRow();
	pFRotZV = NewPad("plane number", "");
	pFRotZU = NewPad("plane number", "");
}


//----------------------------------------------------------------------------------------------------

attachLegend = false;

string source_dir = "../alignment/lhc";
string data_sets[] = {
	"2010_08_24/2762,2763,2770,2772",
	"2010_08_26/2896,2895,2892,2891",
	"2010_09_21/3230,3231",
	"2010_09_28/3285,3286,3287,3288",
	"2010_10_05/3336,3337",
	"2010_10_07/3359,3360,3361",
	"2010_10_14/3457,3459,3460",
	"2010_10_24/3609",
	"2010_10_26/3634,3635",
	"2010_10_29-30/3723,3725,3728"
};

string settings[] = {
	"s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=f,3potsInO=t",
//	"s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=t,3potsInO=t"
};

string arms[] = {
//	"45",
	"56"
};

string units[] = {
	"near",
//	"far"
};

NewPad(false, -1, 0);
label(rotate(90)*Label("read-out shift $\quad(\rm\mu m)$"));
//NewPad(false, -1, 1);
//label(rotate(90)*Label("internal rotation $\quad(\rm mrad)$"));
//NewPad(false, -1, 1);
//label(rotate(90)*Label("full rotation $\quad(\rm mrad)$"));
NewPad(false, -1, 1);
label(rotate(90)*Label("rotation about $z$ $\quad(\rm mrad)$"));

for (int a_i : arms.keys) {
	string rps = (arms[a_i] == "45") ? "20,21,22,23,24,25" : "120,121,122,123,124,125";
	
	for (int u_i : units.keys) {
		NewUnit(arms[a_i], units[u_i]);

		for (int d_i : data_sets.keys) {
			string data_set = data_sets[d_i];
			string runs = substr(data_set, rfind(data_set, "/")+1, -1);
			string data_set = substr(data_set, 0, find(data_set, "/"));
		
			NextDataSet();
			for (int s_i : settings.keys) {
				string file = source_dir+"/"+data_set+"/tb/"+runs+"/"+rps+"/"+settings[s_i]
					+"/iteration5/cumulative_factored_results_Jan.xml";
	
				write(file);
				AddData(file, data_set+", "+((s_i == 0) ? "all tracks" : "overlap tracks only"));
			
				if (d_i == 0 && s_i == 0)
					AddFits(file);
			}
		}
	}
}

Finalize();
GShipout(vSkip=1mm, hSkip=1mm);

import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();

xSizeDef = 4.5cm;
ySizeDef = 3.5cm;

yTicksDef = NoTicks();

//string q_labels[] = { "$g_x\un{\mu m}$", "$g_y\un{\mu m}$", "$h_y\un{mrad}$", "$h_x\un{mrad}$", "$\rh_z\un{mrad}$" };
string q_labels[] = { "$x\un{\mu m}$", "$y\un{\mu m}$", "$\rh_x\un{mrad}$", "$\rh_y\un{mrad}$", "$\rh_z\un{mrad}$" };
real q_range[] = { 20, 20,	0.5, 0.5,	0.5 };
real q_Steps[] = { 20, 20,	0.5, 0.5,	0.5 };
real q_steps[] = { 2, 2, 	0.1, 0.1,	0.1 };

int rps[] = {0, 1, 2, 3, 4, 5};

//----------------------------------------------------------------------------------------------------

bool newPage = false;
int date_idx;
int data_idx;
int setting_idx;
pad pads[][];
real S1[][], Sm[][];
string labels[];
mark markers[];

void NewArm(string arm)
{
	if (newPage)
		NewPage();
	newPage = true;
	
	for (int r : rps.keys) {
		NewPad(false, r, -1);
		int rp = (arm == "56") ? 120+rps[r] : 20+rps[r];
		label(Label(RPName(rp)));
	}
	
	for (int q = 0; q < q_labels.length; ++q) {
		NewPad(false, -1, q);
		label(rotate(90)*Label(q_labels[q]));
	}

	pads.delete();
	S1.delete();
	Sm.delete();
	for (int q = 0; q < q_labels.length; ++q) {
		pads.push(new pad[rps.length]);
		S1.push(new real[rps.length]);
		Sm.push(new real[rps.length]);
		for (int r = 0; r < rps.length; ++r) {
			pads[q][r] = NewPad("", "", r, q);
			S1[q][r] = 0;
			Sm[q][r] = 0;
		}
	}
	
	date_idx = 0;
	data_idx = 0;
	setting_idx = 0;
	labels.delete();
	markers.delete();
}

//----------------------------------------------------------------------------------------------------

void NewDataSet()
{
	++date_idx;
	setting_idx = 0;
}

//----------------------------------------------------------------------------------------------------

void DrawPoint(int q, int r, real v, real e, mark m)
{
	SetPad(pads[q][r]);
	real y = -data_idx-1;
	draw((v, y), m);
	draw((v-e, y)--(v+e, y), m.color, Bars);

	if (e == 0)
		e = 1;

	S1[q][r] += 1/e/e;
	Sm[q][r] += v/e/e;
}

//----------------------------------------------------------------------------------------------------

void AddData(string f, string label)
{
	write(f);
	FactorFit data[];
	if (ParseFactorLog(f, data) != 0) {
		write("    ERROR");
		return;
	}

	mark m = StdMark(setting_idx)+2pt+StdPen(date_idx-1);

	for (int rp : data.keys) {
		int r = rp % 10;

		int idx = -1;
		for (int i : rps.keys)
			if (rps[i] == r) {
				idx = i;
				break;
			}
		if (idx < 0)
			continue;

		DrawPoint(0, idx, data[rp].gx, data[rp].gx_e, m);
		DrawPoint(1, idx, data[rp].gy, data[rp].gy_e, m);
		DrawPoint(2, idx, data[rp].hy, data[rp].hy_e, m);
		DrawPoint(3, idx, data[rp].hx, data[rp].hx_e, m);
		DrawPoint(4, idx, data[rp].rotz, data[rp].rotz_e, m);
	}

	markers.push(m);
	labels.push(label);

	++setting_idx;
	++data_idx;
}

//----------------------------------------------------------------------------------------------------

void Finalize()
{
	for (int q = 0; q < q_labels.length; ++q) {
		for (int r = 0; r < rps.length; ++r) {
			SetPad(pads[q][r]);
			if (S1[q][r] > 0) {
				real mean = Sm[q][r] / S1[q][r];
				limits((mean - q_range[q], -data_idx-1), (mean + q_range[q], 0), Crop);
				yaxis(XEquals(mean, false), dashed);
				currentpad.xTicks = LeftTicks(Step=q_Steps[q], step=q_steps[q]);
			}
		}
	}

	/*
	NewPad(false, 0, 3);
	for (int i : labels.keys)
		AddToLegend(replace(labels[i], "_", "\_"), markers[i]);
	AttachLegend(O);
	*/
}

//----------------------------------------------------------------------------------------------------

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
	"s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=t,3potsInO=t"
};

string arms[] = {
//	"45",
	"56"
};

rps = new int[] { 3, 4, 5};

for (int a_i : arms.keys) {
	NewArm(arms[a_i]);
	string rps = (arms[a_i] == "45") ? "20,21,22,23,24,25" : "120,121,122,123,124,125";
	
	for (int d_i : data_sets.keys) {
		string data_set = data_sets[d_i];
		string runs = substr(data_set, rfind(data_set, "/")+1, -1);
		string data_set = substr(data_set, 0, find(data_set, "/"));
	
		NewDataSet();
		for (int s_i : settings.keys) {
			string file = "refactor_log";
			file = source_dir+"/"+data_set+"/tb/"+runs+"/"+rps+"/"+settings[s_i]+"/iteration5/"+file;

			AddData(file, data_set+", "+((s_i == 0) ? "all tracks" : "overlap tracks only"));
		}
	}
	Finalize();
}

GShipout(vSkip=1mm, hSkip=1mm);

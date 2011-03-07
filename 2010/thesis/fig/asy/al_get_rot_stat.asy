include "../alignment/common_code.asy";

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
	"45",
	"56"
};

//----------------------------------------------------------------------------------------------------

struct stat
{
	real S1=0, Sv=0, Svv=0;
	real WS1=0, WSv=0;
};

//----------------------------------------------------------------------------------------------------

stat s_rh_x[], s_rh_y[], s_rh_z[];

//----------------------------------------------------------------------------------------------------

void Add(int rp, stat stats[], real v, real w)
{
	if (w == 0) {
		write("NULL WEIGHT");
		return;
	}

	if (!stats.initialized(rp))
		stats[rp] = new stat;

	stat s = stats[rp];

	s.S1 += 1;
	s.Sv += v;
	s.Svv += v*v;

	s.WS1 += 1/w/w;
	s.WSv += v/w/w;
}

//----------------------------------------------------------------------------------------------------

real Mean(stat s, bool weighted=true)
{
	return (weighted) ? s.WSv/s.WS1 : s.Sv/s.S1;
}

//----------------------------------------------------------------------------------------------------

real MeanErr(stat s)
{
	return sqrt(1. / s.WS1);
}

//----------------------------------------------------------------------------------------------------

real Sigma(stat s)
{
	return sqrt( (s.Svv - s.Sv*s.Sv/s.S1) / s.S1 );
}

//----------------------------------------------------------------------------------------------------

void AddData(string f)
{
	write(f);
	FactorFit data[];
	if (ParseFactorLog(f, data) != 0) {
		write("    ERROR");
		return;
	}
	
	for (int rp : data.keys) {
		Add(rp, s_rh_x, data[rp].hy, data[rp].hy_e);
		Add(rp, s_rh_y, data[rp].hx, data[rp].hx_e);
		Add(rp, s_rh_z, data[rp].rotz, data[rp].rotz_e);
	}
}

//----------------------------------------------------------------------------------------------------

for (int a_i : arms.keys) {
	string rps_str = (arms[a_i] == "45") ? "20,21,22,23,24,25" : "120,121,122,123,124,125";
	
	for (int d_i : data_sets.keys) {
		string data_set = data_sets[d_i];
		string runs = substr(data_set, rfind(data_set, "/")+1, -1);
		string data_set = substr(data_set, 0, find(data_set, "/"));
	
		for (int s_i : settings.keys) {
			string file = "refactor_log";
			file = source_dir+"/"+data_set+"/tb/"+runs+"/"+rps_str+"/"+settings[s_i]+"/iteration5/"+file;

			AddData(file);
		}
	}
}

for (int rp : s_rh_x.keys) {
	string line = format("%4u", rp);
	
	line += " & " + format("%#+4.1f", Mean(s_rh_x[rp]))
//		+ " \pm " + format("%#.3f", MeanErr(s_rh_x[rp]))
		+ " & " + format("%#+4.2f", Sigma(s_rh_x[rp]));

	line += " & " + format("%#+4.1f", Mean(s_rh_y[rp]))
//		+ " \pm " + format("%#.3f", MeanErr(s_rh_y[rp]))
		+ " & " + format("%#+4.2f", Sigma(s_rh_y[rp]));

	line += " & " + format("%#+4.1f", Mean(s_rh_z[rp]))
//		+ " \pm " + format("%#.3f", MeanErr(s_rh_z[rp]))
		+ " & " + format("%#+4.2f", Sigma(s_rh_z[rp]));

	line += "\cr\ln";

	write(line);	
}

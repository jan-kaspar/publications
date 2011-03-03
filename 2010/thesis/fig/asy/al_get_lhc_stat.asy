import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();

//----------------------------------------------------------------------------------------------------

real GetNumberOfEvents(string log)
{
	real result = -1;
	file f = input(log);
	while (!eof(f)) {
		string line = f;
		if (find(line, "events selected") >= 0) {
			result = (real) (substr(line, find(line, " = ")+3));
		}
	}
	close(f);
	return result;
}

//----------------------------------------------------------------------------------------------------

real ax, ay;

void GetAngles(string root)
{
	ax = 0;
	ay = 0;

	rObject o = rGetObj(root, "common/ax_selected", error=false);
	if (o.valid)
		ax = o.rExec("GetRMS");
	rObject o = rGetObj(root, "common/ay_selected", error=false);
	if (o.valid)
		ay = o.rExec("GetRMS");
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
//	"s+sr-fin,4pl,1rotzIt=0,2units=t,overlap=t,3potsInO=t"
};

string arms[] = {
	"45",
	"56"
};

for (int d_i : data_sets.keys) {
	string data_set = data_sets[d_i];
	string runs = substr(data_set, rfind(data_set, "/")+1, -1);
	string data_set = substr(data_set, 0, find(data_set, "/"));

	string line = "\hbox{"+Date(data_set)+ "} & " + runs;

	for (int a_i : arms.keys) {
		string rps = (arms[a_i] == "45") ? "20,21,22,23,24,25" : "120,121,122,123,124,125";
	
		for (int s_i : settings.keys) {
			string log_file = source_dir+"/"+data_set+"/tb/"+runs+"/"+rps+"/"+settings[s_i]+"/iteration5/log";
			string diag_file = source_dir+"/"+data_set+"/tb/"+runs+"/"+rps+"/"+settings[s_i]+"/iteration1/diagnostics.root";

			line += " & " + format("%.1f", GetNumberOfEvents(log_file)*1e-5);

			GetAngles(diag_file);
			
			line += " & " + format("%.1f", ax*1e3);
			line += " & " + format("%.1f", ay*1e3);
		}
	}

	write(line+"\cr\ln");
}

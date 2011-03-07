import pad_layout;
import root;
include "../alignment/common_code.asy";

StdFonts();

//----------------------------------------------------------------------------------------------------

real ev_tot, ev_sel;

void GetNumberOfEvents(string log)
{
	ev_tot = -1;
	ev_sel = -1;

	file f = input(log);
	while (!eof(f)) {
		string line = f;
		if (find(line, "events total") >= 0)
			ev_tot = (real) (substr(line, find(line, " = ")+3));
		if (find(line, "events selected") >= 0)
			ev_sel = (real) (substr(line, find(line, " = ")+3));	
	}
	close(f);
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

real uv_rot;

int GetOpticalUVRot(string f)
{
	uv_rot = 0;

	Alignment a;
	if (ParseXML(f, a) > 0)
		return 1;

	real n_u=0, n_v=0, s_u=0, s_v=0;
	for (int i : a.rotz.keys) {
		if (i % 2 == 0) {
			++n_u;
			s_u += a.rotz[i];
		} else {
			++n_v;
			s_v += a.rotz[i];
		}
	}

	uv_rot = (s_u/n_u) - (s_v/n_v);

	return 0;
}

//----------------------------------------------------------------------------------------------------

string source_dir = "../alignment/testbeam";

string settings[] = {
	"fix-ext2/full",
};

for (int dp = 1; dp <= 12; ++dp) {
	int rp = dp_to_rp[dp];
	string line = "\hbox{"+format("%u", dp)+ "} & \hbox{" + RPName(rp) + "}";

	for (int s_i : settings.keys) {
		string base = source_dir+"/DP" +format("%u", dp)+"/"+settings[s_i];
		string log_file = base + "/iteration5/log";
		string diag_file = base + "/iteration1/diagnostics.root";

		GetNumberOfEvents(log_file);
		line += " & " + format("$%.E$", ev_tot);
		line += " & " + format("$%.E$", ev_sel);

		GetAngles(diag_file);
		line += " & " + format("%.1f", ax*1e3);
		line += " & " + format("%.1f", ay*1e3);

		string opt_file = "../alignment/optical/DP"+format("%u", dp)+"/full.xml";
		GetOpticalUVRot(opt_file);	
		line += " & " + format("%#.2f", uv_rot);
	}

	write(line+"\cr\ln");
}

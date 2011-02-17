import pad_layout;
import root;

StdFonts();
	
string[] geometries = {
//	"RP_V:1.2_H:0.65",
	"RP_V:2.7_H:3.3",
};

string[] thetas = {
//	"0.1E-3",
	"10E-3",
};

string rps_rp = "120";
string rps_st = "120,121,122,123,124,125";

real[] sigmas = { 0, 0.2, 0.4, 0.6, 1, 2, 3, 4, 5, 10, 20, 30, 40, 50, 500, 1000 };

string[] optimized = {
	"s",
	"sr",
	"srz"
};

real events = 1e4;

int N = 120;

//----------------------------------------------------------------------------------------------------

guide[] GetGraphs(string dir)
{
	guide[] graphs;
	
	for (int i = 0; i < N; ++i)
		graphs.push(nullpath);
	
	for (int i: sigmas.keys) {
		real sigma = sigmas[i];

		string filename = dir + "/" + string(sigma) + ".root";
		write(filename);

		real[] values;
		rObject obj = rGetObj(filename, "S_eigen_values", error=false);

		if (!obj.valid) {
			write("	error");
			continue;
		}

		int size = obj.iExec("GetNrows");
		//write("** size: ", size);
		for (int i = 0; i < size; ++i)
			values.push(obj.rExec("operator[]", i) / events);
		
		values = sort(values);
		//write(values);
	
		for (int j = 0; j < N; ++j) {
			//write(j, values[j]);
			if (j < values.length && values[j] > 0)
				graphs[j] = graphs[j]--(sigma, log10(values[j]));
		}
	}
	
	return graphs;
}

//----------------------------------------------------------------------------------------------------

void DrawSet(guide[] graphs, int sm, real mx)
{
	NewPad("$\si(\De\rh_z)\un{mrad}$", "eigenvaules of $\mat S / N_{\rm events}$");
	scale(Linear, Log);
	for (int j = 0; j < N; ++j) {
		pen p = stdPens[j % 5];
		if (j < sm)
			p += dashed;
		
		if (size(graphs[j]) > 1)
			draw(graphs[j], p, mCi+p);
	}

	real sing_limit = 1e-9;

	label("\SmallerFonts singular limit", (mx/2, log10(sing_limit)), Fill(white));
	limits((0, 1e-15), (mx, 1e+6), Crop);
	xaxis(YEquals(sing_limit, false), dotted);
}


//----------------------------------------------------------------------------------------------------

void MakeFile(string g, string t, string what, int o)
{
	string rps = (what == "rp") ? rps_rp : rps_st;
	string twoU = (what == "rp") ? "f" : "t";
	string overlap = (o != 0) ? "t" : "f";

	/*
	NewPad(false);

	NewPad(false);
	label("\vbox{\noindent\hsize6cm"
		+replace(g, "_", "\_") + "\hfil\break"
		+t+"\hfil\break"
		+rps
		+"}");
	
	NewPad(false);
	label("\vbox{\noindent\hsize6cm"
		+ " 4pl" + "\hfil\break"
		+ " 2units="+twoU + "\hfil\break"
		+ " overlap="+overlap + "\hfil\break"
		+ " 3potsInO=t" + "\hfil\break"
		+"}");
	*/

	for (int op: optimized.keys) {
		string opt = optimized[op];
		string shz = (opt == "srz") ? "20" : "0";

		int sm = 0;
		if (opt == "s") sm = 4;
		if (opt == "sr") sm = 5;
		if (opt == "srz") sm = 7;

		NewRow();

		string dir = "../alignment/eigenvalues/rho/10000/"+g+"/"+t+"/"+rps+","+opt+",4pl,2units="
			+twoU+",overlap="+overlap+",3potsInO=t";
		guide[] graphs = GetGraphs(dir);
	
		//----------
		NewPad(false);
		label(opt);
		
		DrawSet(graphs, sm, 5);
		DrawSet(graphs, sm, 1000);
	}

	//string prefix = g+"_"+t+"_"+what+"_overlap="+overlap;
	//write("shipout:" + prefix);
	//GShipout(prefix);
	GShipout();
}

//----------------------------------------------------------------------------------------------------

for (int g: geometries.keys) {
	for (int t: thetas.keys) {
		//MakeFile(geometries[g], thetas[t], "rp", 0);
		for (int o = 0; o < 1; ++o)
			MakeFile(geometries[g], thetas[t], "st", o);
	}
}

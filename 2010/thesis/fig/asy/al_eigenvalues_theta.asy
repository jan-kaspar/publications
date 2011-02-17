import pad_layout;
import root;

StdFonts();
	
string[] geometries = {
//	"RP_V:1.2_H:0.65",
	"RP_V:2.7_H:3.3",
};

string[] rho_sigmas = {
	"0",
	"1000"
};

string[] theta_sigmas = { 
	"1E-9", "1E-8", "1E-7",
	"0.001E-3", "0.004E-3", "0.01E-3", "0.04E-3",
	"0.1E-3", "0.4E-3", "1E-3", "4E-3", "10E-3", "40E-3", "100E-3"
};

string[] optimized = {
//	"s",
	"sr",
//	"srz"
};

string options[] = {
	"extFit=f",
	"extFit=t"
};

real events = 1e3;

int N = 120;

//----------------------------------------------------------------------------------------------------

guide[] GetGraphs(string dir)
{
	guide[] graphs;
	
	for (int i = 0; i < N; ++i)
		graphs.push(nullpath);
	
	for (int i: theta_sigmas.keys) {
		real sigma = (real) theta_sigmas[i];

		string filename = dir + "/th=" + theta_sigmas[i] + "/task_data.root";
		write(filename);

		real[] values;
		rObject obj = rGetObj(filename, "Jan_data/S_eigen_values", error=false);

		if (!obj.valid) {
			write("	error");
			continue;
		}

		int size = obj.iExec("GetNrows");
		//write("** size: ", size);
		for (int i = 0; i < size; ++i)
			values.push(abs(obj.rExec("operator[]", i) / events));
		
		values = sort(values);
		//write(values);
	
		for (int j = 0; j < N; ++j) {
			//write(j, values[j]);
			if (j < values.length && values[j] > 0)
				graphs[j] = graphs[j]--(log10(sigma), log10(values[j]));
		}
	}
	
	return graphs;
}

//----------------------------------------------------------------------------------------------------

void DrawSet(guide[] graphs, int sm, real mx)
{
	NewPad("$\si(\th)\un{mrad}$", "eigenvaules of $\mat S / N_{\rm events}$");
	scale(Log, Log);
	for (int j = 0; j < N; ++j) {
		pen p = stdPens[j % 5];
		if (j < sm)
			p += dashed;
		
		if (size(graphs[j]) > 1)
			draw(graphs[j], p, mCi+p);
	}

	real sing_limit = 1e-9;

	label("\SmallerFonts singular limit", (-5, log10(sing_limit)), Fill(white));
	limits((1e-9, 1e-15), (1e-1, 1e+6), Crop);
	xaxis(YEquals(sing_limit, false), dotted);
}


//----------------------------------------------------------------------------------------------------

bool newPage = false;

void MakeFile(string o, string g, string rho)
{
	if (newPage)
		NewRow();
	newPage = true;

	string rps = "120,121,122,123,124,125";
	string twoU = "t";
	string overlap = "f";

	NewPad(false);

	NewPad(false);
	label("\vbox{\noindent\hsize6cm"
		+replace(g, "_", "\_") + "\hfil\break "
		+"$\rh=$"+rho+"\hfil\break "
		+o+"\hfil\break "
		+rps
		+"}");
	
	NewPad(false);
	label("\vbox{\noindent\hsize6cm"
		+ " 4pl" + "\hfil\break"
		+ " 2units="+twoU + "\hfil\break"
		+ " overlap="+overlap + "\hfil\break"
		+ " 3potsInO=t" + "\hfil\break"
		+"}");

	for (int op: optimized.keys) {
		string opt = optimized[op];
		string shz = (opt == "srz") ? "20" : "0";

		int sm = 0;
		if (opt == "s") sm = 4;
		if (opt == "sr") sm = 5;
		if (rho == "0")
			sm += 1;

		//NewRow();

		string label = "../alignment/eigenvalues/theta/"+o+"/"+g+"/rho="+rho+"/"+rps+","+opt+",4pl,2units="+twoU+",overlap="
			+overlap+",3potsInO=t";
		guide[] graphs = GetGraphs(label);
	
		//----------
		NewPad(false);
		label(opt);
		
		DrawSet(graphs, sm, 0.01);
		//DrawSet(graphs, sm, 50);
		//DrawSet(graphs, sm, 10);
	}

	/*
	string prefix = o+"_rho="+rho+"_overlap="+overlap;
	//prefix = "out";
	write("shipout:" + prefix);
	GShipout(prefix);
	*/
}

//----------------------------------------------------------------------------------------------------

for (int o: options.keys) {
	for (int g: geometries.keys) {
		for (int r: rho_sigmas.keys) {
			MakeFile(options[o], geometries[g], rho_sigmas[r]);
		}
	}
}

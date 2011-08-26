import pad_layout;
import root;

StdFonts();

xSizeDef = 5.5cm;
ySizeDef = 5.5cm;
	
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

string ref_lab[], ref_val[];

int LoadReference(string filename)
{
	file f = input(filename, false);
	if (error(f))
		return 1;

	while (!eof(f)) {
		string line = f;
		string bits[] = split(line, "{");

		if (bits.length != 3 || bits[0] != "\makecom")
			continue;
		
		ref_lab.push(replace(bits[1], "}", ""));
		ref_val.push(replace(bits[2], "}", ""));
	}
	
	return 0;
}

string Ref(string lab)
{
	for (int i : ref_lab.keys) {
		if (ref_lab[i] == lab)
			return ref_val[i];
	}

	return "?"+lab+"?";
}

LoadReference("../../thesis.ref");

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
			values.push(abs(obj.rExec("operator[]", i)) / events);
		
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

void DrawSet(guide[] graphs, int sm, real mx, bool first, bool last)
{
	NewPad((last) ? "$\si_\rh \un{mrad}$" : "", "$|\la_{\rm N}|$");
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

	if (first) {
		label("two groups $\longrightarrow$ three and more groups", (mx/2, 6), -2S);
	}
}


//----------------------------------------------------------------------------------------------------

void MakeFile(string g, string t, string what, int o)
{
	string rps = (what == "rp") ? rps_rp : rps_st;
	string twoU = (what == "rp") ? "f" : "t";
	string overlap = (o != 0) ? "t" : "f";

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
	
		DrawSet(graphs, sm, 5, (opt == "s"), (opt == "srz"));

		if (op == 0) {
			label("\vtop{\hbox{\bf shitfs in the read-out direction}}", (5, 6), S+3E);
			label("$\}$ four singular modes ("+Ref("eq:al sm shr sol")+")", (5, -12.5), 3E);
		}
		
		if (op == 1) {
			label("\vtop{\hbox{\bf shitfs in the read-out direction}\hbox{\bf and rotations}}", (5, 6), S+3E);
			label("singular mode ("+Ref("eq:al sm rotz sol")+") with $\De\rh$ different for $U$ and $V$", (5, -1.5), 3E);
			label("$\Big\rbrace$ \raise2pt\vbox to0pt{\vss\hbox{singular modes ("+Ref("eq:al sm shr sol")+") and}"+
				"\hbox{singular mode ("+Ref("eq:al sm rotz sol")+") with $\De\rh$ equal for $U$ and $V$}\vss}", (5, -11.5), 3E);
		}
		
		if (op == 2) {
			label("\vtop{\hbox{\bf shitfs in the read-out direction,}\hbox{\bf rotations and $z$-shifts}}", (5, 6), S+3E);
			label("singular mode ("+Ref("eq:al sm rotz sol")+") with $\De\rh$ different for $U$ and $V$", (5, -1), 3E);
			label("\vbox{\hbox{singular modes ("+Ref("eq:al sm shz sol 2g")+") with $\al$ and $\be$}\hbox{different for $U$ and $V$}}", (5, -6.5), 3E);
			label("$\Bigg\rbrace$ \raise4pt\vbox to0pt{\vss\hbox{singular modes ("+Ref("eq:al sm shr sol")+"),}"+
				"\hbox{singular mode ("+Ref("eq:al sm rotz sol")+") with $\De\rh$ equal for $U$ and $V$}"+
				"\hbox{and singular modes ("+Ref("eq:al sm shz sol 3g")+")}\vss}", (5, -12.5), 3E);
		}
	}
}

//----------------------------------------------------------------------------------------------------

/*
NewPad(false, 2, 1);
label(rotate(90)*Label("sh. r-o."));

NewPad(false, 2, 2);
label(rotate(90)*Label("sh. r-o. and rot. z"));

NewPad(false, 2, 3);
label(rotate(90)*Label("sh. r-o., rot. z and sh. z"));
*/

for (int g: geometries.keys) {
	for (int t: thetas.keys) {
		//MakeFile(geometries[g], thetas[t], "rp", 0);
		for (int o = 0; o < 1; ++o)
			MakeFile(geometries[g], thetas[t], "st", o);
	}
}

GShipout(hSkip=1mm, vSkip=1mm, O);

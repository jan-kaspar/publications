include "../alignment/common_code.asy";
import pad_layout;

xSizeDef = 6cm;
ySizeDef = 6cm;

StdFonts();

real pitches[] = { 1, 33, 66, 100, 133, 166, 200 };

int rps[] = { 120 };
int dets[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
//int dets[] = { 2, 3, 8, 9 };

string base_dir = "../alignment/systematical errors/pitch";

int j = 0;

void MakePage(string dir, string file1, string file2)
{
	write("* ", dir);

	guide r_graphs[], ru_graphs[], rb_graphs[];
	guide s_graphs[], su_graphs[], sb_graphs[];
	for (int rp_i : rps.keys) {
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			s_graphs[id] = nullpath;
			su_graphs[id] = nullpath;
			sb_graphs[id] = nullpath;
			r_graphs[id] = nullpath;
			ru_graphs[id] = nullpath;
			rb_graphs[id] = nullpath;
		}
	}
	
	for (int r_i : pitches.keys) {
		real pitch = pitches[r_i];
	
		write("   ", pitch);
	
		Alignment a_real, a_ideal;
		int res_r = ParseXML(base_dir+"/"+dir+"/" + format("%.0f", pitch) + "E-3/"+file1, a_real);
		int res_i = ParseXML(base_dir+"/"+dir+"/" + format("%.0f", pitch) + "E-3/"+file2, a_ideal);
		if (res_r > 0 || res_i > 0) {
			write("ERROR");
			continue;
		}
	
		for (int rp_i : rps.keys) {
			for (int d_i : dets.keys) {
				int id = rps[rp_i]*10 + dets[d_i];
				s_graphs[id] = s_graphs[id]--((pitch), a_real.shr[id] - a_ideal.shr[id]);
				real e = a_real.shr_e[id];
				su_graphs[id] = su_graphs[id]--((pitch), a_real.shr[id] + e - a_ideal.shr[id]);
				sb_graphs[id] = sb_graphs[id]--((pitch), a_real.shr[id] - e - a_ideal.shr[id]);

				real e = a_real.rotz_e[id];
				r_graphs[id] = r_graphs[id]--((pitch), a_real.rotz[id] - a_ideal.rotz[id]);
				ru_graphs[id] = ru_graphs[id]--((pitch), a_real.rotz[id] + e - a_ideal.rotz[id]);
				rb_graphs[id] = rb_graphs[id]--((pitch), a_real.rotz[id] - e - a_ideal.rotz[id]);
			}
		}
	}

	/*
	NewPad(false, j, -1);
	label(replace(dir, "_", "\_"));

	NewPad(false, 1, -2);
	label("\vbox{\hsize8cm\noindent "
		+replace(file1, "_", "\_")
		+ "\hfill\break-\hfill\break "
		+replace(file2, "_", "\_")
		+"}");
	*/		
	
	for (int rp_i : rps.keys) {
		xTicksDef = LeftTicks(Step=50, step=10);
		
		NewPad("pitch $\un{\mu m}$", "shift syst. error $\un{\mu m}$", j, 1);
		currentpad.yTicks = RightTicks(Step=1, step=0.2);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			pen p = StdPen(i);
			draw(s_graphs[id], p, mCi+2pt+p);
			filldraw(su_graphs[id]--reverse(sb_graphs[id])--cycle, p+opacity(0.3), nullpen);
			++i;
		}
		limits((0, -5), (200, +5), Crop);
		yaxis(XEquals(66, false), dashed);
		xaxis(YEquals(0, false), dashed);
	
		NewPad("pitch $\un{\mu m}$", "rotation syst. error $\un{mrad}$", j, 2);
		currentpad.yTicks = RightTicks(Step=0.1, step=0.02);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			pen p = StdPen(i);
			draw(r_graphs[id], p, mCi+2pt+p);
			filldraw(ru_graphs[id]--reverse(rb_graphs[id])--cycle, p+opacity(0.3), nullpen);
			++i;
		}
		limits((0, -0.5), (200, +0.5), Crop);
		yaxis(XEquals(66, false), dashed);
		xaxis(YEquals(0, false), dashed);
		
		++j;
	}
}

//----------------------------------------------------------------------------------------------------

string simulations[] = {
	"station12_realistic_shr_rotz_4/theta=0.1E-3,dscr=0.5,seed=2,ConstError",
	"station12_realistic_shr_rotz_4/theta=0.1E-3,dscr=0.5,seed=2",
};

NewPad(false, 0, -1);
label("non-reduced uncertainties");

NewPad(false, 1, -1);
label("reduced uncertainties");

for (int s_i : simulations.keys) {
	MakePage(simulations[s_i], "it3_expanded_results_Jan.xml", "precise3_expanded_results_Jan.xml");
}

GShipout(hSkip=1mm, vSkip=1mm);

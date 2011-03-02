include "../alignment/common_code.asy";
import pad_layout;

StdFonts();

string thetas[] = {};

int rps[] = { 120 };
int dets[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

string base_dir = "../alignment/systematical errors/overconstraints";

int rep_min = 1, rep_max = 20;

ySizeDef = 4cm;

//----------------------------------------------------------------------------------------------------

void DrawGraphSet(guide graphs[], int rp_i)
{
	scale(Log, Linear);
	for (int d_i : dets.keys) {
		int id = rps[rp_i]*10 + dets[d_i];
		pen p = StdPen(quotient(d_i+8, 2));
		if (dets[d_i] % 2 == 0)
			p += dashed;
		draw(graphs[id], p, mCi+1pt+p);
	}
}

//----------------------------------------------------------------------------------------------------

void MakePage(string dir, string file_r, string file_i)
{
	write("* ", dir);
	
	guide N_graphs[];
	guide s_m_graphs[], s_v_graphs[];
	guide r_m_graphs[], r_v_graphs[];
	for (int rp_i : rps.keys) {
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];

			N_graphs[id] = nullpath;

			s_m_graphs[id] = nullpath;
			s_v_graphs[id] = nullpath;

			r_m_graphs[id] = nullpath;
			r_v_graphs[id] = nullpath;
		}
	}
	
	for (int t_i : thetas.keys) {
		real theta = ((real) thetas[t_i]) * 1e-3;
		write("  th=", theta);
	
		// read in alignments for all repetitions
		Alignment a_real[], a_ideal[];	
		for (int rep = rep_min; rep <= rep_max; ++rep) {
			Alignment a_r, a_i;

			string thS = "/theta=" + thetas[t_i] + "/";

			int res_r = ParseXML(base_dir+"/"+dir+ thS + format("%u", rep)+"/"+file_r, a_r);
			int res_i = ParseXML(base_dir+"/"+dir+ thS + format("%u", rep)+"/"+file_i, a_i);

			if (res_r == 0 && res_i == 0) {
				a_real[rep] = a_r;
				a_ideal[rep] = a_i;
			} else
				write("ERROR in repetition ", rep);
		}

		for (int rp_i : rps.keys) {
			for (int d_i : dets.keys) {
				int id = rps[rp_i]*10 + dets[d_i];

				real S1=0, sSv=0, sSvv=0;
				real rSv=0, rSvv=0;
				for (int rep : a_real.keys) {
					S1 += 1;

					//write("id ", id);
					//write("    ", a_real[rep].shr[id]);

					real v = a_real[rep].shr[id] - a_ideal[rep].shr[id];
					sSv += v; sSvv += v*v;
					
					real v = a_real[rep].rotz[id] - a_ideal[rep].rotz[id];
					rSv += v; rSvv += v*v;
				}

				if (S1 < 2)
					continue;

				real sM = sSv/S1, sV = (sSvv - sSv*sSv/S1) / (S1-1);
				real rM = rSv/S1, rV = (rSvv - rSv*rSv/S1) / (S1-1);
				real x = log10(theta*1e3);
	
				N_graphs[id] = N_graphs[id]--(x, S1);
				
				s_m_graphs[id] = s_m_graphs[id]--(x, sM);
				s_v_graphs[id] = s_v_graphs[id]--(x, sV);
				
				r_m_graphs[id] = r_m_graphs[id]--(x, rM);
				r_v_graphs[id] = r_v_graphs[id]--(x, rV);
			}
		}
	}
	
	int r = 0;
	for (int rp_i : rps.keys) {
		//NewPad(false, -2, r);
		//label(RPName(rps[rp_i]));
		
		//NewPad("$\si(\vec a)\un{mrad}$", "$N$", -1, r);
		//DrawGraphSet(N_graphs, rp_i);
		//ylimits(0, 30);

		NewPad(false, -1, r);
		label(rotate(90)*Label("read-out shift $\un{\mu m}$"));
		
		NewPad(false, -1, r+1);
		label(rotate(90)*Label("rotation about $z\un{mrad}$"));

		NewPad(false, 0, r-1);
		label("systematical error");

		NewPad(false, 1, r-1);
		label("statistical error");

		yTicksDef = RightTicks(Step=1, step=0.2);
		NewPad(0, r);
		DrawGraphSet(s_m_graphs, rp_i);
		ylimits(-3, +3);
		yaxis(XEquals(1e-4, false), dotted);
		
		NewPad(1, r);
		DrawGraphSet(s_v_graphs, rp_i);
		ylimits(0, +6);
		yaxis(XEquals(1e-4, false), dotted);
		
		yTicksDef = RightTicks(Step=0.1, step=0.02);
		NewPad("$\si(\vec a)\un{rad}$", "", 0, r+1);
		DrawGraphSet(r_m_graphs, rp_i);
		ylimits(-0.4, +0.4);
		yaxis(XEquals(1e-4, false), dotted);
		
		NewPad("$\si(\vec a)\un{rad}$", "", 1, r+1);
		DrawGraphSet(r_v_graphs, rp_i);
		ylimits(0, +0.8);
		yaxis(XEquals(1e-4, false), dotted);

		++r;
	}
}

//----------------------------------------------------------------------------------------------------

thetas = new string[] { "0.001E-3", "0.004E-3", "0.01E-3", "0.04E-3", "0.1E-3", "0.4E-3", "1E-3",
	"4E-3", "10E-3" };

MakePage("fn_rot=10E-3", "precise3_expanded_results_Jan.xml", "precise1_expanded_results_Ideal.xml");

GShipout(hSkip=1mm, vSkip=1mm);

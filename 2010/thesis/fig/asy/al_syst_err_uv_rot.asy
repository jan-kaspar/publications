include "../alignment/common_code.asy";
import pad_layout;

real rhos[] = { 0, 1, 4, 10, 40, 100, 200, 300, 400, 500 };
//real rhos[] = { 0, 1, 4, 10 };

int ids[] = { 1200, 1210, 1220, 1230, 1240, 1250 };

int rps[] = { 120, 121, 122, 123, 124, 125 };
int dets[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

string base_dir = "../alignment/systematical errors/u_v_rotation";

void MakePage(string dir, string file1, string file2)
{
	write("* ", dir);

	guide r_graphs[], s_graphs[];
	for (int rp_i : rps.keys) {
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			s_graphs[id] = nullpath;
			r_graphs[id] = nullpath;
		}
	}
	
	for (int r_i : rhos.keys) {
		real rho = rhos[r_i];
	
		write("   ", rho);
	
		Alignment a_real, a_ideal;
		ParseXML(base_dir+"/"+dir+"/" + format("%.0f", rho) + "/"+file1, a_real);
		ParseXML(base_dir+"/"+dir+"/" + format("%.0f", rho) + "/"+file2, a_ideal);
	
		for (int rp_i : rps.keys) {
			for (int d_i : dets.keys) {
				int id = rps[rp_i]*10 + dets[d_i];
				s_graphs[id] = s_graphs[id]--(rho, a_real.shr[id] - a_ideal.shr[id]);
				r_graphs[id] = r_graphs[id]--(rho, a_real.rotz[id] - a_ideal.rotz[id]);
			}
		}
	}

	NewPad(false, 0, -1);
	label(dir);

	NewPad(false, 1, -1);
	label("\vbox{\hsize8cm\noindent "
		+replace(file1, "_", "\_")
		+ "\hfill\break-\hfill\break "
		+replace(file2, "_", "\_")
		+"}");		
	
	int j = 0;
	for (int rp_i : rps.keys) {
		NewPad("$\De_{U-V} \rh \un{mrad}$", "shift syst. error $\un{\mu m}$", j, 0);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			draw(s_graphs[id], stdPens[quotient(i, 2)] + ((i % 2 == 1) ? dashed : solid));
			++i;
		}
	
		NewPad("$\De_{U-V} \rh \un{mrad}$", "rotation syst. error $\un{mrad}$", j, 1);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			draw(r_graphs[id], stdPens[quotient(i, 2)] + ((i % 2 == 1) ? dashed : solid));
			++i;
		}
	
		//ylimits(-2, +2, Crop);
		//yaxis(XEquals(4, false), dashed);
		AttachLegend(RPName(rps[rp_i]), NE, NE);	

		++j;
	}
}

//----------------------------------------------------------------------------------------------------

MakePage("theta=0E-3", "it3_expanded_results_Jan.xml", "precise3_expanded_results_Jan.xml");

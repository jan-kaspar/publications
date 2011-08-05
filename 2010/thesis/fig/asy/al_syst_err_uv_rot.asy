include "../alignment/common_code.asy";
import pad_layout;

xSizeDef = 5.9cm;
ySizeDef = 4.9cm;

StdFonts();

real rhos[] = { 0, 25, 50, 75, 100, 125, 150, 175, 200 };

int rps[] = { 120 };
int dets[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

string base_dir = "../alignment/systematical errors/u_v_rotation";

//----------------------------------------------------------------------------------------------------

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

	/*
	NewPad(false, 0, -1);
	label(dir);

	NewPad(false, 1, -1);
	label("\vbox{\hsize8cm\noindent "
		+replace(file1, "_", "\_")
		+ "\hfill\break-\hfill\break "
		+replace(file2, "_", "\_")
		+"}");
	*/

	xTicksDef = LeftTicks(Step=50, step=10);
	
	int j = 0;
	for (int rp_i : rps.keys) {
		NewPad("$\De_{U-V} \rh \un{mrad}$", "shift syst.~error $\un{\mu m}$", 0, j);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			pen p = StdPen(quotient(i, 2));
			if (i % 2 == 0)
				p = p + dashed;
			draw(s_graphs[id], p, mCi+p);
			++i;
		}
		limits((0, -0.2), (200, +0.2), Crop);
	
		NewPad("$\De_{U-V} \rh \un{mrad}$", "rotation syst.~error $z$ $\un{mrad}$", 1, j);
		int i = 0;
		for (int d_i : dets.keys) {
			int id = rps[rp_i]*10 + dets[d_i];
			pen p = StdPen(quotient(i, 2));
			if (i % 2 == 0)
				p = p + dashed;
			draw(r_graphs[id], p, mCi+p);
			++i;
		}
		limits((0, -0.1), (200, +0.1), Crop);
	

		++j;
	}
}

//----------------------------------------------------------------------------------------------------

/*
MakePage("theta=0E-3", "precise3_expanded_results_Ideal.xml", "precise3_expanded_results_Jan.xml");
NewPage();
MakePage("theta=10E-3", "precise3_expanded_results_Ideal.xml", "precise3_expanded_results_Jan.xml");
NewPage();
*/

MakePage("theta=0.1E-3", "it3_expanded_results_Jan.xml", "precise3_expanded_results_Jan.xml");
//NewPage();
//MakePage("theta=10E-3", "it3_expanded_results_Jan.xml", "precise3_expanded_results_Jan.xml");

GShipout(hSkip=1mm, vSkip=1mm);

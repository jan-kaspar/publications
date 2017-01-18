
//---------------------------------------------------------------------------------------------------------------------

string RPName(int rp)
{
	string a = (quotient(rp, 100) >= 1) ? "56" : "45";
	string s = (quotient(rp, 10) % 10 == 2) ? "220" : "210";
	string u = ((rp % 10) > 2) ? "far" : "near";
	int R = rp % 10;
	string r = "";
	if (R == 0 || R == 4) r = "top";
	if (R == 1 || R == 5) r = "bot";
	if (R == 2 || R == 3) r = "hor";
	
	return a+"-"+s+"-"+u+"-"+r;
}

//---------------------------------------------------------------------------------------------------------------------

struct Alignment
{
	real shr[], shr_e[], rotz[], rotz_e[], shz[], shz_e[];
	real rp_shx[], rp_shx_e[];
	real rp_shy[], rp_shy_e[];
	real rp_rotz[], rp_rotz_e[];
};

//---------------------------------------------------------------------------------------------------------------------

int ParseXML(string filename, Alignment a)
{
	a.shr.delete();
	a.shr_e.delete();
	a.rotz.delete();
	a.rotz_e.delete();
	
	a.rp_shx.delete();
	a.rp_shx_e.delete();
	a.rp_shy.delete();
	a.rp_shy_e.delete();
	a.rp_rotz.delete();
	a.rp_rotz_e.delete();

	file f = input(filename, false);
	if (error(f))
		return 1;

	while (!eof(f))
	{
		string line = f;
		string[] bits = split(line, "\"");
		//write(line);

		bool det_node = (find(line, "<det") >= 0);
		bool rp_node = (find(line, "<rp") >= 0);
		if (!det_node && !rp_node)
			continue;

		int id = -1;
		real sh_r = 0, sh_r_e = 0, rot_z = 0, rot_z_e = 0;
		real sh_x = 0, sh_x_e = 0, sh_y = 0, sh_y_e = 0;
		real sh_z = 0, sh_z_e = 0;

		for (int j = 0; j < bits.length; ++j)
		{
			//write("> ", bits[j]);
			if (find(bits[j], "id=") >= 0) id = (int) bits[++j];
			if (find(bits[j], "sh_r=") >= 0) sh_r = (real) bits[++j];
			if (find(bits[j], "sh_r_e=") >= 0) sh_r_e = (real) bits[++j];
			if (find(bits[j], "sh_x=") >= 0) sh_x = (real) bits[++j];
			if (find(bits[j], "sh_x_e=") >= 0) sh_x_e = (real) bits[++j];
			if (find(bits[j], "sh_y=") >= 0) sh_y = (real) bits[++j];
			if (find(bits[j], "sh_y_e=") >= 0) sh_y_e = (real) bits[++j];
			if (find(bits[j], "sh_z=") >= 0) sh_z = (real) bits[++j];
			if (find(bits[j], "sh_z_e=") >= 0) sh_z_e = (real) bits[++j];
			if (find(bits[j], "rot_z=") >= 0) rot_z = (real) bits[++j];
			if (find(bits[j], "rot_z_e=") >= 0) rot_z_e = (real) bits[++j];
		}
	
		if (id < 0)
			continue;

		if (det_node)
		{
			a.shr[id] = sh_r;
			a.shr_e[id] = sh_r_e;
			a.rotz[id] = rot_z;
			a.rotz_e[id] = rot_z_e;
			a.shz[id] = sh_z;
			a.shz_e[id] = sh_z_e;
		} else {
			a.rp_shx[id] = sh_x;
			a.rp_shx_e[id] = sh_x_e;
			a.rp_shy[id] = sh_y;
			a.rp_shy_e[id] = sh_y_e;
			a.rp_rotz[id] = rot_z;
			a.rp_rotz_e[id] = rot_z_e;
		}
	}
	
	return 0;
}

//----------------------------------------------------------------------------------------------------

real GetQuantity(Alignment a, string qn, int key)
{
	if (qn == "shr") return a.shr[key];
	if (qn == "shr_e") return a.shr_e[key];
	if (qn == "rotz") return a.rotz[key];
	if (qn == "rotz_e") return a.rotz_e[key];

	if (qn == "rp_shx") return a.rp_shx[key];
	if (qn == "rp_shx_e") return a.rp_shx_e[key];

	if (qn == "rp_shy") return a.rp_shy[key];
	if (qn == "rp_shy_e") return a.rp_shy_e[key];

	if (qn == "rp_rotz") return a.rp_rotz[key];
	if (qn == "rp_rotz_e") return a.rp_rotz_e[key];

	return 13;
}

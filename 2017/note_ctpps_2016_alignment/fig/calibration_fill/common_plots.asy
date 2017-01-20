import pad_layout;
include "common_code.asy";

//----------------------------------------------------------------------------------------------------

string base_dir = "/afs/cern.ch/work/j/jkaspar/software/offline/704/user-new/alignment/ctpps_2016_afterTS2/";

drawGridDef = true;

xSizeDef = 7cm;

bool attach_legend = true;
real legend_y_offset = 0;

//----------------------------------------------------------------------------------------------------

string quantities[];

int units[];
string unit_names[];

int excludedRPs[];

string groups[];

string quantities[];
string quantity_labels[];

string inputs[];

//----------------------------------------------------------------------------------------------------

Alignment alignments[];

void LoadAlignments()
{
	alignments.delete();
	
	for (int ini : inputs.keys)
	{
		string f = base_dir + inputs[ini] + "/cumulative_factored_results_Jan.xml";
	
		//f = replace(f, "<rp_str>", rp_str);
		//f = replace(f, "<sector>", sector);
	
		Alignment a;
		int r = ParseXML(f, a);
		if (r != 0)
		{
			write("ERROR: can't parse " + f + ".");
			continue;
		}
	
		alignments[ini] = a;
	}
}

//----------------------------------------------------------------------------------------------------

void MakePlotsPerRP()
{
	for (int qi : quantities.keys)
	{
		//NewPage();

		string quantity = quantities[qi];
		write("* " + quantity);
	
		// plot header
		if (qi == 0)
		{
			//NewPad(false);
			//label("{\SetFontSizesXX\it " + replace(quantities[qi], "_", "\_") + "}");
			
			for (int uniti : units.keys)
			{
				NewPad(false);
				label("{\SetFontSizesXX " + unit_names[uniti] + "}");
			}
		}
		
		// plot results
		for (string group : groups)
		{
			NewRow();
		
			//NewPad(false);
			//label("{\SetFontSizesXX " + group + "}");
			
		
			for (int unit : units)
			{
				int st = quotient(unit, 10);
				int arm = quotient(st, 10);
				int uidx = unit % 10;
		
				int rp = st * 10;
				if (group == "top" && uidx == 0) rp += 0;
				if (group == "bot" && uidx == 0) rp += 1;
				if (group == "hor" && uidx == 0) rp += 2;
				if (group == "hor" && uidx == 1) rp += 3;
				if (group == "top" && uidx == 1) rp += 4;
				if (group == "bot" && uidx == 1) rp += 5;
		
				NewPad("", quantity_labels[qi]);
				scale(Linear, Linear(false));
	
				bool rpExcluded = false;
				for (int erp : excludedRPs)
				{
					if (erp == rp)
					{
						rpExcluded = true;
						break;
					}
				}

				if (rpExcluded)
					continue;

				for (int ai : alignments.keys)
				{
					pen p = StdPen(ai);
					mark m = mCi;
	
					//if (!alignments[ai].rp_shx.initialized(rp))
					//	continue;
		
					real qv = GetQuantity(alignments[ai], quantity, rp);
					real qu = GetQuantity(alignments[ai], quantity+"_e", rp);
			
					draw((ai, qv-qu)--(ai, qv+qu), p);
					draw((ai, qv), m+3pt+(p+1.5pt));	
				}
		
				xlimits(-0.5, inputs.length - 0.5, Crop);
			}
		}
	
		if (attach_legend)
		{
			NewPad(false);
		
			for (int ini : inputs.keys)
			{
				string bits[] = split(inputs[ini], "/");
				string label = replace(bits[1], "_", "\_");
				AddToLegend(label, StdPen(ini));
			}
		
			AttachLegend(shift(0, legend_y_offset)*BuildLegend());
		}
	}
}

//----------------------------------------------------------------------------------------------------

void MakePlotsPerPlane()
{
	for (int qi : quantities.keys)
	{
		//NewPage();

		string quantity = quantities[qi];
		write("* " + quantity);
	
		/*
		if (quantity == "shr")
		{
			yTicksDef = RightTicks(100., 50.);
		}
	
		if (quantity == "rotz")
		{
			// TODO
			yTicksDef = RightTicks(0.5, 0.1);
			//yTicksDef = RightTicks(5., 1.);
		}
		*/
	
		// plot header
		if (qi == 0)
		{
			//NewPad(false);
			//label("{\SetFontSizesXX\it " + replace(quantities[qi], "_", "\_") + "}");
			
			for (int uniti : units.keys)
			{
				NewPad(false);
				label("{\SetFontSizesXX " + unit_names[uniti] + "}");
			}
		}
		
		// plot results
		for (string group : groups)
		{
			NewRow();
		
			//NewPad(false);
			//label("{\SetFontSizesXX " + group + "}");	
		
			for (int unit : units)
			{
				int st = quotient(unit, 10);
				int arm = quotient(st, 10);
				int uidx = unit % 10;
		
				int rp = st * 10;
				if (group == "top" && uidx == 0) rp += 0;
				if (group == "bot" && uidx == 0) rp += 1;
				if (group == "hor" && uidx == 0) rp += 2;
				if (group == "hor" && uidx == 1) rp += 3;
				if (group == "top" && uidx == 1) rp += 4;
				if (group == "bot" && uidx == 1) rp += 5;
		
				NewPad("", quantity_labels[qi]);
				scale(Linear, Linear(false));

				bool rpExcluded = false;
				for (int erp : excludedRPs)
				{
					if (erp == rp)
					{
						rpExcluded = true;
						break;
					}
				}

				if (rpExcluded)
					continue;
	
				for (int pl = 0; pl < 10; ++pl)
				{
					int det = 10*rp + pl;
				
					mark m = (pl % 2 == 0) ? mCr : mCi+false;
				
					for (int ai : alignments.keys)
					{
						pen p = StdPen(ai);
			
						if (!alignments[ai].shr.initialized(det))
							continue;
			
						real qv = GetQuantity(alignments[ai], quantity, det);
						real qu = GetQuantity(alignments[ai], quantity+"_e", det);
				
						draw((pl, qv-qu)--(pl, qv+qu), p);
						draw((pl, qv), m+3pt+(p+1.5pt));
					}
				}
	
				/*
				if (quantity == "shr")
					limits((0, -200), (9, +200), Crop);
			
				// TODO
				if (quantity == "rotz")
					limits((0, -1.5), (9, +1.5), Crop);
				*/
			}
		}
	
		//--------------------
	
		if (attach_legend)
		{
			NewPad(false);
		
			AddToLegend("V plane", mCr+3pt+(black+1.5pt));
			AddToLegend("U plane", mCi+false+3pt+(black+1.5pt));
		
			for (int ini : inputs.keys)
			{
				string bits[] = split(inputs[ini], "/");
				string label = replace(bits[1], "_", "\_");
				AddToLegend(label, StdPen(ini));
			}
		
			AttachLegend(shift(0, legend_y_offset)*BuildLegend());
		}
	}
}

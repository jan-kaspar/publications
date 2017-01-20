include "common_plots.asy";

//----------------------------------------------------------------------------------------------------

units.push(100); unit_names.push("R, 210, near");
units.push(101); unit_names.push("R, 210, far");

excludedRPs = new int[] { 100 };

groups = new string[] { "hor" };

quantities.push("rp_shx"); quantity_labels.push("shift in $x\ung{\mu m}$");
quantities.push("rp_shy"); quantity_labels.push("shift in $y\ung{\mu m}$");
quantities.push("rp_rotz"); quantity_labels.push("rotation about $z\ung{mrad}$");

// before TS2, new
base_dir = "/afs/cern.ch/work/j/jkaspar/software/offline/704/user-new/alignment/ctpps_2016_beforeTS2/";
string options = "s+sr-fin,3pl,1rotzIt=0,units=2,overlap=f,3potsInO=t,eMuMvRot=f/iteration3";
inputs = new string[] {
	"tb,round1/10077/101,102,103,104,105/"+options,
//	"tb,round1/10079/101,102,103,104,105/"+options,
	"tb,round1/10080/101,102,103,104,105/"+options,
	"tb,round1/10081/101,102,103,104,105/"+options,
//	"tb,round1/10082/101,102,103,104,105/"+options,
};

//----------------------------------------------------------------------------------------------------

xSizeDef = 4cm;
ySizeDef = 4cm;

LoadAlignments();
MakePlotsPerRP();

GShipout(hSkip=1mm, vSkip=1mm);

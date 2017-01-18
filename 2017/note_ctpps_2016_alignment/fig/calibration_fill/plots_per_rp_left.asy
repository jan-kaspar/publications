include "common_plots.asy";

//----------------------------------------------------------------------------------------------------

units.push(1); unit_names.push("45-210-fr-hr");
units.push(0); unit_names.push("45-210-nr-hr");

//excludedRPs = new int[] { 100, 102 };

//groups = new string[] { "top", "hor", "bot" };
groups = new string[] { "hor" };

quantities.push("rp_shx"); quantity_labels.push("shift in $x\ung{\mu m}$");
quantities.push("rp_shy"); quantity_labels.push("shift in $y\ung{\mu m}$");
quantities.push("rp_rotz"); quantity_labels.push("rotation about $z\ung{mrad}$");

string options = "s+sr-fin,3pl,1rotzIt=0,units=2,overlap=f,3potsInO=t,eMuMvRot=f/iteration5";
inputs = new string[] {
	"tb,round1/10322/0,1,2,3,4,5-excl44/"+options,
	"tb,round1/10324/0,1,2,3,4,5-excl44/"+options,
//	"tb,round1/10325/0,1,2,3,4,5-excl44/"+options,
	"tb,round1/10326/0,1,2,3,4,5-excl44/"+options,
	"tb,round1/10328/0,1,2,3,4,5-excl44/"+options,
//	"tb,round1/10329/0,1,2,3,4,5-excl44/"+options,
//	"tb,round1/10331/0,1,2,3,4,5-excl44/"+options,
	"tb,round1/10332/0,1,2,3,4,5-excl44/"+options,
};

//----------------------------------------------------------------------------------------------------

ySizeDef = 4cm;

LoadAlignments();
MakePlotsPerRP();

GShipout(vSkip=1mm);

include "common_plots.asy";

//----------------------------------------------------------------------------------------------------

units.push(1); unit_names.push("45-210-fr-hr");
units.push(0); unit_names.push("45-210-nr-hr");

//excludedRPs = new int[] { 100, 102 };

//groups = new string[] { "top", "hor", "bot" };
groups = new string[] { "hor" };

quantities.push("shr"); quantity_labels.push("shift in read-out direction $\ung{\mu m}$");
quantities.push("rotz"); quantity_labels.push("rotation about $z\ung{mrad}$");

// before TS2, old
/*
base_dir = "/afs/cern.ch/work/j/jkaspar/software/offline/704/user/alignment/lhc/2016_04_20_fill4828/";
string options = "/s+sr-fin,3pl,1rotzIt=0,units=1,overlap=f,3potsInO=f/iteration5";
inputs = new string[] {
	"tb,round1/10077_EVB11_1/0,1,2,3,4,5/" + options,
	"tb,round1/10079_EVB11_1/0,1,2,3,4,5/" + options,
	"tb,round1/10080_EVB11_1/0,1,2,3,4,5/" + options,
	"tb,round1/10081_EVB11_1/0,1,2,3,4,5/" + options,
//	"tb,round1/10082_EVB11_1/0,1,2,3,4,5/" + options,
};
*/

// before TS2, new
base_dir = "/afs/cern.ch/work/j/jkaspar/software/offline/704/user-new/alignment/ctpps_2016_beforeTS2/";
string options = "s+sr-fin,3pl,1rotzIt=0,units=2,overlap=f,3potsInO=t,eMuMvRot=f/iteration4";
inputs = new string[] {
	"tb,round1/10077/0,1,2,3,4,5-excl44,50,51,52,53/"+options,
//	"tb,round1/10079/0,1,2,3,4,5-excl44,50,51,52,53/"+options,
	"tb,round1/10080/0,1,2,3,4,5-excl44,50,51,52,53/"+options,
	"tb,round1/10081/0,1,2,3,4,5-excl44,50,51,52,53/"+options,
//	"tb,round1/10082/0,1,2,3,4,5-excl44,50,51,52,53/"+options,
};

// after TS2
/*
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
*/

//----------------------------------------------------------------------------------------------------

xSizeDef = 8cm;
ySizeDef = 5cm;

legend_y_offset = 50;

LoadAlignments();
MakePlotsPerPlane();

GShipout(vSkip=1mm);

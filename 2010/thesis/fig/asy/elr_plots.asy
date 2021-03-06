import root;
import pad_layout;

StdFonts();
ySizeDef = 4cm;

string dir = "../elastic_reco_val";

//----------------------------------------------------------------------------------------------------

string file = dir + "/ElRecoVal_7000GeV_1535_4E3.root";

NewPad("ndf");
draw(rGetObj(file, "statistics/global/ndf_x_global"), "vl,ec", blue, "$x$ projection");
draw(rGetObj(file, "statistics/global/ndf_y_global"), "vl,ec", red, "$y$ projection");
limits((-0.5, 0), (6.5, 5e4), Crop);
AttachLegend(NW, NW);

GShipout("elr_1535_ndf");

NewPad("road size$\ung{\mu rad}$");
rGetObj(file, "road-size/rs_x"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, "vl,ec", blue, "$x$ projection");
rGetObj(file, "road-size/rs_y"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, "vl,ec", red, "$y$ projection");
limits((0, 0), (3, 15e3), Crop);
AttachLegend();

GShipout("elr_1535_rs");

NewPad("$\De\th_x^*,\ \De\th_y^*\ung{\mu rad}$");
currentpad.yTicks = RightTicks(Step=500, step=100);
rGetObj(file, "theta/reco global vs. original/th_x_rgo_diff"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, "vl,ec", blue, "$\De\th_x^*$");
label("RMS = "+format("$%.2f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-1.05, 2250), blue);
rGetObj(file, "theta/reco global vs. original/th_y_rgo_diff"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, "vl,ec", red, "$\De\th_y^*$");
label("RMS = "+format("$%.2f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-1.05, 2000), red);
limits((-2, 0), (+2, 2.5e3), Crop);
AttachLegend();

GShipout("elr_1535_dth");

NewPad("$\De x^*,\ \De y^*\ung{mm}$");
rGetObj(file, "vertex/reco global vs. smeared/vtx_x_rs_diff"); robj.vExec("Rebin", 4); draw(xscale(1e3), robj, "vl,ec", blue, "$\De x^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-5, 1.8e4), blue);
rGetObj(file, "vertex/reco global vs. smeared/vtx_y_rs_diff"); robj.vExec("Rebin", 4); draw(xscale(1e3), robj, "vl,ec", red, "$\De y^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-5, 1.6e4), red);
limits((-10, 0), (+10, 2e4), Crop);
AttachLegend();

GShipout("elr_1535_dvtx");

TGraph_errorBarPen = black+0.2pt;
NewPad("$|t|\ung{GeV^2}$", "$\si(t)/t\ung{\%}$");
TF1_lowLimit = 1e-3;
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 8), Crop);
AttachLegend();

GShipout("elr_1535_res_t");

//----------------------------------------------------------------------------------------------------

string file = dir + "/ElRecoVal_7000GeV_90_4E3.root";

NewPad("ndf");
draw(rGetObj(file, "statistics/global/ndf_x_global"), "vl,ec", blue, "$x$ projection");
draw(rGetObj(file, "statistics/global/ndf_y_global"), "vl,ec", red, "$y$ projection");
limits((-0.5, 0), (6.5, 3e4), Crop);
AttachLegend();

GShipout("elr_90_ndf");

NewPad("road size$\ung{\mu rad}$");
rGetObj(file, "road-size/rs_x"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, "vl,ec", blue, "$x$ projection");
rGetObj(file, "road-size/rs_y"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, "vl,ec", red, "$y$ projection");
limits((0, 0), (15, 2e3), Crop);
AttachLegend();

GShipout("elr_90_rs");

NewPad("$\De\th_x^*,\ \De\th_y^*\ung{\mu rad}$");
currentpad.yTicks = RightTicks(Step=300, step=100);
rGetObj(file, "theta/reco global vs. original/th_x_rgo_diff"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, "vl,ec", blue, "$\De\th_x^*$");
label("RMS = "+format("$%.1f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-7, 1620), blue);
rGetObj(file, "theta/reco global vs. original/th_y_rgo_diff"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, "vl,ec", red, "$\De\th_y^*$");
label("RMS = "+format("$%.1f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-7, 1470), red);
limits((-15, 0), (+15, 1.8e3), Crop);
AttachLegend();

GShipout("elr_90_dth");

NewPad("$\De x^*,\ \De y^*\ung{\mu m}$");
rGetObj(file, "vertex/reco global vs. smeared/vtx_x_rs_diff"); robj.vExec("Rebin", 1); draw(xscale(1e6), robj, "vl,ec", blue, "$\De x^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu m$", (-15, 4500), blue);
rGetObj(file, "vertex/reco global vs. smeared/vtx_y_rs_diff"); //robj.vExec("Rebin", 1); draw(xscale(1e3), robj, "vl,ec", red, "$\De y^*$");
AddToLegend("$\De y^*$", red);
label("RMS = "+format("$%#.1f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-15, 4000), red);
limits((-30, 0), (+30, 5000), Crop);
AttachLegend();

GShipout("elr_90_dvtx");

TGraph_errorBarPen = black+0.2pt;
NewPad("$|t|\ung{GeV^2}$", "$\si(t)/t\ung{\%}$");
TGraph_highLimit = 0.4;
TGraph_skipPoints.push(0);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 20), Crop);
AttachLegend();

GShipout("elr_90_res_t");

//----------------------------------------------------------------------------------------------------

TGraph_errorBarPen = black+0.2pt;

string file = dir + "/ElRecoVal_7000GeV_1535_4E3.root";
NewPad("$|t|\ung{GeV^2}$", "$\si(t)/t\ung{\%}$");
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 4), Crop);
AttachLegend("$\be^* = 1535\,\rm m$");

string file = dir + "/ElRecoVal_7000GeV_90_4E3.root";
NewPad("$|t|\ung{GeV^2}$", "$\si(t)/t\ung{\%}$");
TGraph_highLimit = 0.4;
TGraph_skipPoints.push(0);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 20), Crop);
AttachLegend("$\be^* = 90\,\rm m$");

GShipout("elr_res_t_sum");

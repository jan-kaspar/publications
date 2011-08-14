import root;
import pad_layout;

StdFonts();
ySizeDef = 4cm;

string dir = "../elastic_reco_val";

string data[] = { "7000_1535_4E3", "7000_90_4E3" };

//----------------------------------------------------------------------------------------------------

string file = dir + "/ElRecoVal_7000_1535_4E3.root";

NewPad("ndf");
draw(rGetObj(file, "statistics/global/ndf_x_global"), blue, "$x$ projection");
draw(rGetObj(file, "statistics/global/ndf_y_global"), red, "$y$ projection");
limits((-0.5, 0), (6.5, 4e4), Crop);
AttachLegend(NW, NW);

GShipout("elr_1535_ndf");

NewPad("road size$\un{\mu rad}$");
rGetObj(file, "road-size/rs_x"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, blue, "$x$ projection");
rGetObj(file, "road-size/rs_y"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, red, "$y$ projection");
limits((0, 0), (3, 15e3), Crop);
AttachLegend();

GShipout("elr_1535_rs");

NewPad("$\De\th_x^*,\ \De\th_y^*\un{\mu rad}$");
rGetObj(file, "theta/reco global vs. original/th_x_rgo_diff"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, blue, "$\De\th_x^*$");
label("RMS = "+format("$%.2f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-1.05, 2250), blue);
rGetObj(file, "theta/reco global vs. original/th_y_rgo_diff"); robj.vExec("Rebin", 2); draw(xscale(1e6), robj, red, "$\De\th_y^*$");
label("RMS = "+format("$%.2f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-1.05, 2000), red);
limits((-2, 0), (+2, 2.5e3), Crop);
AttachLegend();

GShipout("elr_1535_dth");

NewPad("$\De x^*,\ \De y^*\un{mm}$");
rGetObj(file, "vertex/reco global vs. original/vtx_x_ro_diff"); robj.vExec("Rebin", 4); draw(xscale(1e3), robj, blue, "$\De x^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-5, 1.37e4), blue);
rGetObj(file, "vertex/reco global vs. original/vtx_y_ro_diff"); robj.vExec("Rebin", 4); draw(xscale(1e3), robj, red, "$\De y^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-5, 1.25e4), red);
limits((-10, 0), (+10, 1.5e4), Crop);
AttachLegend();

GShipout("elr_1535_dvtx");

TGraph_errorBarPen = black+0.2pt;
NewPad("$|t|\un{GeV^2}$", "$\si(t)/t\un{\%}$");
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 8), Crop);
AttachLegend();

GShipout("elr_1535_res_t");

//----------------------------------------------------------------------------------------------------

string file = dir + "/ElRecoVal_7000_90_4E3.root";

NewPad("ndf");
draw(rGetObj(file, "statistics/global/ndf_x_global"), blue, "$x$ projection");
draw(rGetObj(file, "statistics/global/ndf_y_global"), red, "$y$ projection");
limits((-0.5, 0), (6.5, 3e4), Crop);
AttachLegend();

GShipout("elr_90_ndf");

NewPad("road size$\un{\mu rad}$");
rGetObj(file, "road-size/rs_x"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, blue, "$x$ projection");
rGetObj(file, "road-size/rs_y"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, red, "$y$ projection");
limits((0, 0), (15, 2e3), Crop);
AttachLegend();

GShipout("elr_90_rs");

NewPad("$\De\th_x^*,\ \De\th_y^*\un{\mu rad}$");
rGetObj(file, "theta/reco global vs. original/th_x_rgo_diff"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, blue, "$\De\th_x^*$");
label("RMS = "+format("$%.1f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-7, 1620), blue);
rGetObj(file, "theta/reco global vs. original/th_y_rgo_diff"); robj.vExec("Rebin", 4); draw(xscale(1e6), robj, red, "$\De\th_y^*$");
label("RMS = "+format("$%.1f$", robj.rExec("GetRMS")*1e6)+"$\ \rm\mu rad$", (-7, 1470), red);
limits((-15, 0), (+15, 1.8e3), Crop);
AttachLegend();

GShipout("elr_90_dth");

NewPad("$\De x^*,\ \De y^*\un{mm}$");
rGetObj(file, "vertex/reco global vs. original/vtx_x_ro_diff"); robj.vExec("Rebin", 1); draw(xscale(1e3), robj, blue, "$\De x^*$");
label("RMS = "+format("$%#.2f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-0.52, 1370), blue);
rGetObj(file, "vertex/reco global vs. original/vtx_y_ro_diff"); //robj.vExec("Rebin", 1); draw(xscale(1e3), robj, red, "$\De y^*$");
AddToLegend("$\De y^*$", red);
label("RMS = "+format("$%#.1f$", robj.rExec("GetRMS")*1e3)+"$\ \rm mm$", (-0.52, 1250), red);
limits((-1, 0), (+1, 1500), Crop);
AttachLegend();

GShipout("elr_90_dvtx");

TGraph_errorBarPen = black+0.2pt;
NewPad("$|t|\un{GeV^2}$", "$\si(t)/t\un{\%}$");
TGraph_highLimit = 0.4;
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution"), "p,sebc", black, mCi+black+1pt);
draw(yscale(100), rGetObj(file, "t/reco global vs. original/t_rgo_res/resolution|user"), "", heavygreen+1pt);
AddToLegend(format("$%.1E\ {\rm GeV}/\sqrt{|t|}$", robj.rExec("GetParameter", 0)), heavygreen+1pt);
limits((0, 0), (0.5, 20), Crop);
AttachLegend();

GShipout("elr_90_res_t");

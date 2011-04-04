import root;
import pad_layout;

string file = "../root/output_run_32300000_event_111_0.root";

NewPad("$z\un{mm}$", "$v\un{mm}$");
rObject obj = rGetObj(file, "RP/sector 45/station 220/nr_bt/rp_45_220_nr_bt : actual track - v projection");
draw(obj.oExec("Get", "vHitsAll"), "p,ieb", mCr+2pt);
draw(obj.oExec("Get", ";1"), "l", red);
limits((-22, -20), (22, 20));

NewPad("$z\un{mm}$", "$u\un{mm}$");
rObject obj = rGetObj(file, "RP/sector 45/station 220/nr_hr/rp_45_220_nr_hr : actual track - u projection");
draw(obj.oExec("Get", "uHitsAll"), "p,ieb", mCr+2pt);
draw(obj.oExec("Get", ";1"), "l", red);
draw(obj.oExec("Get", ";2"), "l", red);
draw(obj.oExec("Get", ";3"), "l", red);
draw(obj.oExec("Get", ";4"), "l", red);
draw(obj.oExec("Get", ";5"), "l", red);
draw(obj.oExec("Get", ";6"), "l", red);
draw(obj.oExec("Get", ";7"), "l", red);
draw(obj.oExec("Get", ";8"), "l", red);
draw(obj.oExec("Get", ";9"), "l", red);
limits((-22, -20), (22, 20));

GShipout(hSkip=5mm);

import root;
import pad_layout;

texpreamble("\SelectNimbusCMFonts\LoadFonts\SetFontSizesX");
texpreamble("\def\ung#1{\quad[{\rm#1}]}");

string topDir = "/afs/cern.ch/work/j/jkaspar/analyses/elastic/4000GeV,beta1000";

string f = topDir + "/tabulation/tabulate.root";

TGraph_errorBar = None;

drawGridDef = true;

pen p_full_band = (olive*0.5 + yellow*0.7) + opacity(0.7);
pen p_anal_band = brown*0.5 + yellow*0.5;
//pen p_anal_band = heavygreen;
//add("hatch", hatch(1.3mm, NE, p_anal_band+1pt));

//----------------------------------------------------------------------------------------------------

void DrawBand(rObject bc, rObject unc, pen p)
{
	int N = bc.iExec("GetN");

	guide g;
	guide g_u, g_b;

	for (int i = 0; i < N; ++i)
	{
		real ta[] = {0.};
		real sa[] = {0.};
		real ua[] = {0.};

		bc.vExec("GetPoint", i, ta, sa);
		unc.vExec("GetPoint", i, ta, ua);

		g_u = g_u -- Scale((ta[0], sa[0] + ua[0]));
		g_b = g_b -- Scale((ta[0], sa[0] - ua[0]));
	}

	g_b = reverse(g_b);
	filldraw(g_u--g_b--cycle, p, nullpen);
}

//----------------------------------------------------------------------------------------------------

picture inset = new picture;
currentpicture = inset;

unitsize(5000mm, 0.055mm);

//currentpad.xTicks = LeftTicks(0.005, 0.001);
//currentpad.yTicks = RightTicks(100., 20.);

DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_all"), p_full_band);
DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_anal_all"), p_anal_band);
draw(rGetObj(f, "g_data"), "p", black, mCi+1pt);

limits((0, 4e2), (0.01, 1e3), Crop);

xaxis(BottomTop, LeftTicks(0.005, 0.001).GetTicks());
yaxis(LeftRight, RightTicks(100., 20.).GetTicks());


//----------------------------------------------------------------------------------------------------

//pad_collection.delete();

NewPad("$|t|\ung{GeV^2}$", "$\d\si / \d t \ung{mb/GeV^2}$", 15cm, 7cm);
scale(Linear, Log);
currentpad.xTicks = LeftTicks(0.05, 0.01);
//currentpad.yTicks = RightTicks(100., 20.);

attach(bbox(inset, 1mm, nullpen, FillDraw(white)), (0.125, 1.3));

DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_all"), p_full_band);
DrawBand(rGetObj(f, "g_band_cen"), rGetObj(f, "g_unc_anal_all"), p_anal_band);
draw(rGetObj(f, "g_data"), "p", black, mCi+1pt);

AddToLegend("data", mCi+1pt);
AddToLegend("statistical uncertainty", (scale(0.0001, 1.)*mPl)+5pt);

AddToLegend("full systematic uncertainty band", mSq+6pt+p_full_band);
AddToLegend("systematic uncertainty band", mSq+6pt+p_anal_band);
AddToLegend("without normalisation");

limits((0, 1e1), (0.2, 1e3), Crop);

frame fL = BuildLegend(lineLength=5mm, ymargin=0mm, SW);
AttachLegend(shift(10, 10) * fL, SW);

GShipout(margin=0mm, hSkip=3mm);

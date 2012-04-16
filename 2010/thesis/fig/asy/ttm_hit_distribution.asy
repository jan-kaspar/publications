import root;
import pad_layout;

StdFonts();

xSizeDef = 6cm*3/5;
ySizeDef = 6cm;

//----------------------------------------------------------------------------------------------------

real edge = 3.6101*10;
real cutEdge = 2.22721 / sqrt(2)*10;

path Det0 = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
path Det = shift(0, -cutEdge/sqrt(2)) * rotate(45) * Det0;

void DrawDets(real o)
{
	draw(shift(0, o)*Det, black+1pt);
	draw(shift(0, -o)*rotate(180)*Det, black+1pt);
	limits((-30, -50), (+30, 50), Crop);
}

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$", "$y\ung{mm}$");
TGraph_reducePoints = 10;
string file = "../root/hitDistributions_1535.root";
pen hitPen = red + 0.5pt;
draw(rGetObj(file, "unit_123|det_124"), "p", hitPen);
draw(rGetObj(file, "unit_123|det_125"), "p", hitPen);

DrawDets(1.35);
filldraw(ellipse((0, 0), 0.3, 0.85), gray, nullpen);

AttachLegend("$\be^*=1535\un{m}$");

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$");
TGraph_reducePoints = 1;
string file = "../root/hitDistributions_90.root";
pen hitPen = blue + 0.5pt;
draw(rGetObj(file, "unit_123|det_124"), "p", hitPen);
draw(rGetObj(file, "unit_123|det_125"), "p", hitPen);

DrawDets(6.4);
filldraw(ellipse((0, 0), 3.99, 5.9), gray, nullpen);

AttachLegend("$\be^*=90\un{m}$");

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$");
TGraph_reducePoints = 1;
string file = "../root/hitDistributions_2.root";
pen hitPen = heavygreen + 0.5pt;
draw(rGetObj(file, "unit_123|det_124"), "p", hitPen);
draw(rGetObj(file, "unit_123|det_125"), "p", hitPen);

DrawDets(3.3);
filldraw(ellipse((0, 0), 1.1, 2.8), gray, nullpen);

AttachLegend("$\be^*=2\un{m}$");

GShipout(hSkip=1mm);

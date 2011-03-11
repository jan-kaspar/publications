import root;
import pad_layout;

string base_dir = "../alignment/lhc_old/2010_09_21_vsym2/profiles";

StdFonts();

//xSizeDef = 3.7cm;
//ySizeDef = 3.7cm;

//----------------------------------------------------------------------------------------------------

void DrawFit(real a, real b, pen p=green)
{
	real x_min = -10, x_max = +10;
	draw((x_min, a*x_min + b)--(x_max, a*x_max + b), p+1pt);
}

real l = 10, dl = 2;
real pointSize = l/30;

//----------------------------------------------------------------------------------------------------

void Limit()
{
	pen gP = gray+dotted;
	for (real v = -l; v <= +l; v += dl) {
		draw((-l, v)--(+l, v), gP);
		draw((v, -l)--(v, +l), gP);
	}
	limits((-l, -l), (+l, +l), Crop);
}

//----------------------------------------------------------------------------------------------------

string file = base_dir+"/3230,3231/after_tb/profiles.root";
TGraph_reducePoints = 10;
useDefaultLabel = false;
bool drawHits = true;

NewPad("$x\un{mm}$", "$y\un{mm}$");
if (drawHits)
	draw(rGetObj(file, "station fits/Unit 20/hit map"), "p");
// 20+21
DrawFit(a = -2.459927e+01, b = -8.651014e-01, red);
// 22
DrawFit(a = 9.839900e-03, b = -2.954584e-01, blue);
// vertOfVert 20+21
//DrawFit(a = -3.016066e-01, b = 3.851482e-02, heavygreen);

Limit();
AttachLegend("45 near");



/*
NewPad("$x\un{mm}$", "$y\un{mm}$");
if (drawHits)
	draw(rGetObj(file, "station fits/Unit 21/hit map"), "p");
// 24+25
DrawFit(a = -3.297797e+01, b = -2.083811e+00, red);
// 23
DrawFit(a = 2.709457e-02, b = -2.935633e-01, blue);
// vertOfVert 24+25
//DrawFit(a = -2.678524e-01, b = 1.087967e-01, heavygreen);

filldraw(scale(pointSize)*unitcircle, magenta, white);
Limit();
AddToLegend("45 far");
AttachLegend();


NewRow();
*/


NewPad("$x\un{mm}$", "$y\un{mm}$");
if (drawHits)
	draw(rGetObj(file, "station fits/Unit 120/hit map"), "p");
// 120+121
DrawFit(a = 2.462253e+01, b = -1.031655e+01, red);
// 122
DrawFit(a = 1.920159e-01, b = 4.638875e-01, blue);
// vertOfVert 120+121
//DrawFit(1.843455e-01, b = -1.115744e-01, heavygreen);
Limit();
AttachLegend("56 near");


/*
NewPad("$x\un{mm}$", "$y\un{mm}$");
if (drawHits)
	draw(rGetObj(file, "station fits/Unit 121/hit map"), "p");
// 124+125
DrawFit(a = 3.015691e+01, b = -3.082663e+01, red);
// 123
DrawFit(1.217788e-01, b = 8.634250e-01, blue);
// vertOfVert 124+125
//DrawFit(2.176551e-01, b = -3.031959e-01, heavygreen);
filldraw(scale(pointSize)*unitcircle, magenta, white);
Limit();
AddToLegend("56 far");
AttachLegend();
*/

GShipout(hSkip=1mm);

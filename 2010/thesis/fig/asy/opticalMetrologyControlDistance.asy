import root;
import pad_layout;

StdFonts();

real th = 49.136;

NewPad("control distance deviation$\un{\mu m}$", "", 8cm, 5cm);
draw(xscale(1e3)*shift(-th, 0), rGetObj("../root/OpticalMetrologyControlDistance.root", "cdH"), "L", blue+1pt);
limits((-5, 0), (5, 40), Crop);
AttachLegend(NW, NW);

yaxis(XEquals(0, false), dashed);

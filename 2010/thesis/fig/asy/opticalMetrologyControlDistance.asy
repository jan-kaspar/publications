import root;
import pad_layout;

fonts10();

real th = 49.136;

NewPad("control distance deviation$\un{\mu m}$", "");
draw(xscale(1e3)*shift(-th, 0), rGetObj("../root/OpticalMetrologyControlDistance.root", "cdH"), blue+1pt);

limits((-5, 0), (5, 40), Crop);

yaxis(XEquals(0, false), dashed);

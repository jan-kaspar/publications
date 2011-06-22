import feynman;

unitsize(0.4mm);
StdFonts();

// set default line width to 0.8bp
//currentpen = linewidth(0.8);

// scale all other defaults of the feynman module appropriately
fmdefaults();

// disable middle arrows
//currentarrow = MidArrow;

// define vertex and external points

pair ti = (0, 70);
pair bi = (0, 0);
pair tl = (20, 50);
pair bl = (20, 20);
pair tr = (60, 40);
pair br = (60, 30);
pair to = tr + (20, 30);
pair bo = br + (20, -30);

drawFermion(ti--tl--tr--to);
drawFermion(bi--bl--br--bo);

drawVertex(tl);
drawVertex(bl);

pair z = (60, 35);
drawVertexO(z, 10);
label("$F^{\rm H}$", z);

drawPhoton(bl--tl);

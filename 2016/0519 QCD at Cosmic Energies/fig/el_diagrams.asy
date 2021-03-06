import feynman;

unitsize(0.4mm);
StdFonts();
fmdefaults();

real c = 0;

// ----- A -----

c = 0;

pair ti = (c-20, 50);
pair bi = (c-20, 0);
pair tm = (c, 40);
pair bm = (c, 10);
pair to = (c+20, 50);
pair bo = (c+20, 0);

drawVertex(tm);
drawVertex(bm);

drawFermion(ti--tm);
drawFermion(tm--to);
drawFermion(bi--bm);
drawFermion(bm--bo);

drawPhoton(bm--tm);

shipout("el_diagram_C");


// ----- B -----

currentpicture = new picture;
c = 0;

pair ti = (c-20, 50);
pair bi = (c-20, 0);
pair m = (c, 25);
pair to = (c+20, 50);
pair bo = (c+20, 0);

drawFermion(ti--m);
drawFermion(m--to);
drawFermion(bi--m);
drawFermion(m--bo);

drawVertexO(m, 10);
label("$F^{\rm H}$", m);

shipout("el_diagram_H");

// ----- C -----

currentpicture = new picture;
c = 0;

pair ti = (c-40, 50);
pair bi = (c-40, 0);
pair tl = (c-20, 40);
pair bl = (c-20, 10);
pair tr = (c+20, 30);
pair br = (c+20, 20);
pair to = (c+40, 50);
pair bo = (c+40, 0);
pair z = (c+20, 25);

drawFermion(ti--tl);
drawFermion(tl--tr);
drawFermion(tr--to);
drawFermion(bi--bl);
drawFermion(bl--br);
drawFermion(br--bo);

drawVertex(tl);
drawVertex(bl);

drawVertexO(z, 10);
label("$F^{\rm H}$", z);

drawPhoton(bl--tl);

shipout("el_diagram_C_H");

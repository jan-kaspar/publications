import feynman;

unitsize(0.4mm);
StdFonts();
fmdefaults();

//overpaint = false;
doublelinespacing = 0.5;
linemargin = 0;
photonratio = 10;

real c = 0;


//----------------------- A ---------------------------

c = 0;

pair ti = (c-40, 50);
pair bi = (c-40, 0);

pair tl = (c-20, 40);
pair bl = (c-20, 10);

pair t1 = (c+10, 40);
pair b1 = (c+10, 10);

pair t2 = (c+20, 40);
pair b2 = (c+20, 10);

pair t3 = (c+30, 40);
pair b3 = (c+30, 10);

pair tr = (c+40, 40);
pair br = (c+40, 10);

pair to = (c+60, 50);
pair bo = (c+60, 0);

drawFermion(ti--tl); drawFermion(bi--bl);
drawFermion(tl--t1); drawFermion(bl--b1);
drawFermion(tr--to); drawFermion(br--bo);

draw(t1--t2); draw(t2--t3, dotted); draw(t3--tr);
draw(b1--b2); draw(b2--b3, dotted); draw(b3--br);

drawVertex(tl); drawVertex(bl);
drawVertex(t1); drawVertex(b1);
drawVertex(tr); drawVertex(br);

drawPhoton(bl--tl);
drawPhoton(b1--t1);
drawPhoton(br--tr);

label("A", (c+10, -10));

//----------------------- B ---------------------------

c += 120;
transform tr = shift(c, 5) * scale(0.65);

pair l = tr*(-20, 50);
pair r = tr*(20, 50);
pair b = tr*(0, 40);
pair t = tr*(0, 60);
pair le = tr*(-40, 60);
pair re = tr*(40, 60);
pair be = tr*(0, 0);

drawFermion(le--l);
drawFermion(l--b);
drawFermion(b--r);
drawFermion(r--re);

drawPhoton(b--be);
drawPhoton(l..t..r);

drawVertex(b);
drawVertex(r);
drawVertex(l);

label("B", (c, -10));

//----------------------- C ---------------------------

c += 50;

transform tr = shift(c-5, 5) * scale(0.5);

pair te = tr*(0, 80);
pair t = tr*(0, 60);
pair r = tr*(20, 40);
pair b = tr*(0, 20);
pair be = tr*(0, 0);

drawFermion(te--t);
drawFermion(t--b);
drawFermion(b--be);

drawPhoton(t..r..b);

drawVertex(b);
drawVertex(t);

label("C", (c, -10));

//----------------------- D ---------------------------

c += 50;

transform tr = shift(c, 5) * scale(0.5);

pair te = tr*(0, 80);
pair t = tr*(0, 55);
pair r = tr*(15, 40);
pair l = tr*(-15, 40);
pair b = tr*(0, 25);
pair be = tr*(0, 0);

drawFermion(t..r..b);
drawFermion(b..l..t);

drawPhoton(te--t, 2, 6);
drawPhoton(b--be, 2, 6);

drawVertex(b);
drawVertex(t);

label("D", (c, -10));

//----------------------- E ---------------------------

c += 50;
transform tr = shift(c, 5) * scale(0.65);

pair l = tr*(-20, 50);
pair r = tr*(20, 50);
pair b = tr*(0, 40);
pair t = tr*(0, 60);
pair le = tr*(-40, 60);
pair re = tr*(40, 60);
pair be = tr*(0, 0);

drawFermion(le--b);
drawDoubleLine(b--re, MidArrow(FillDraw(black, black)));

drawPhoton(b--be);
drawVertexO(b);

label("E", (c, -10));

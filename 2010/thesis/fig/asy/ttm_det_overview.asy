unitsize(1cm);
StdFonts();

picture mp = currentpicture;

//--------------------

picture cmsp = new picture;
unitsize(1cm);
currentpicture = cmsp;
label(Label("\pdfximage width15cm{../external/totem_cms_bw.png}\pdfrefximage\pdflastximage"));

layer();

filldraw((-18, -29)--(-18, -45)--(-71, -45)--(-71, -34)--cycle, red, red);
filldraw((+38, -45)--(+45, -45)--(+45, -50)--(+38, -50)--cycle, red, red);

//--------------------

picture accp = new picture;
currentpicture = accp;
label("\pdfximage width13.5cm{../external/RP_stations.pdf}\pdfrefximage\pdflastximage");

draw(Label("beam 1", 0.5, 2*N), (6.9, 0.52)--(8.1, 0.52), EndArrow);
draw(Label("beam 2", 0.5, 2*S), (6.9, 0.06)--(8.1, 0.06), BeginArrow);

//--------------------

currentpicture = mp;
frame cmsf = shift(-0.5cm, 4.5cm)*scale(0.8)*bbox(cmsp);
add(cmsf);
add(accp);

pair lb = min(cmsf), rb = (max(cmsf).x, min(cmsf).y);

layer();

filldraw((-5.1, 0.1)--(-5.1, 0.42)--(-5.62, 0.42)--(-5.62, 0.1)--cycle, white, black);

pair mp = (-4.5, 1.2);

//dot(mp);

draw(lb/1cm..(-6, 1)..{0, -1}(-5.62, 0.42), dashed);
draw(rb/1cm{-1, -0.2}..{-1, -0.2}mp..{0, -1}(-5.1, 0.42), dashed);

label("RP", (1.35, 0.8), red);
label("RP", (5.75, 0.8), red);

label("IP5", (-5.36, 0.7), red);

label("T1", (-1.7, 2.8), red);
label("T2", (0.7, 2.8), red);

label("sector 56 $\rightarrow$", (-5.36, -0.8), E, black);
label("$\leftarrow$ sector 45", (-5.36, -0.8), W, black);

draw(Label("\SmallerFonts $9\,\rm m$", 0.5, N), (-6.3, 2.5)--(-1.7, 2.5), EndArrow(4));
draw(Label("\SmallerFonts $13.5\,\rm m$", 0.5, S), (-6.3, 2.3)--(0.7, 2.3), EndArrow(4));

label("detail at IP5", (5.5, 7.1), SW);


shipout(bbox(2mm, nullpen));

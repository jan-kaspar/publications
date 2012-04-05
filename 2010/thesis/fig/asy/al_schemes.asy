fonts8();

real h1 = 2, h2 = 0.3, w1 = 1, w2 = 1.8, g = 0.3;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
real eD = (edge - cutEdge) / sqrt(2);

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
path Det = scale(0.2) * shift(0, 1.4) * rotate(45) * shift(-edge/2, -edge/2) * Det0Shape;


currentpicture = new picture;
unitsize(1cm);

filldraw((-w1, 0)--(+w1, 0)--(+w1, h1)--(-w1, h1)--cycle, lightgray, black);
filldraw((-w2, h1)--(+w2, h1)--(+w2, h1+h2)--(-w2, h1+h2)--cycle, lightgray, black);

draw(Label("gap", 0.5, E), (0, 0)--(0, g), blue);

filldraw(shift(0, g)*Det, red, black+0.3pt);

shipout("al_rp_scheme", bbox(2mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

real bw = 0.8, bh = 0.8, bs = 0.1;
real gp = 1.5;
real dz = 7;
real al = 0.7;

picture rp = currentpicture = new picture;

filldraw((-w1, 0)--(+w1, 0)--(+w1, h1)--(-w1, h1)--cycle, lightgray, black);
filldraw((-w2, h1)--(+w2, h1)--(+w2, h1+h2)--(-w2, h1+h2)--cycle, lightgray, black);
filldraw(shift(0, g)*Det, red, black+0.3pt);

picture beam = currentpicture = new picture;

filldraw((-bw, -bh)--(+bw, -bh)..(+bw+bs, 0)..(+bw, +bh)--(-bw, +bh)..(-bw-bs, 0)..cycle, paleblue, nullpen);

picture coll = currentpicture = new picture;

filldraw((-w2, 0)--(+w2, 0)--(+w2, h2)--(-w2, h2)--cycle, black, nullpen);

currentpicture = new picture;
unitsize(1cm);

add(shift(0*dz, bw)*coll);
add(shift(0*dz, 0)*beam);
add(shift(0*dz, -bw)*yscale(-1)*coll);

draw((0.5*dz-al, 0)--(0.5*dz+al, 0), EndArrow);

add(shift(1*dz, gp)*rp);
add(shift(1*dz, 0)*beam);
add(shift(1*dz, -gp)*yscale(-1)*rp);

draw((1.5*dz-al, 0)--(1.5*dz+al, 0), EndArrow);

add(shift(2*dz, bw)*rp);
add(shift(2*dz, 0)*beam);
add(shift(2*dz, -gp)*yscale(-1)*rp);

draw((2.5*dz-al, 0)--(2.5*dz+al, 0), EndArrow);

add(shift(3*dz, bw)*rp);
add(shift(3*dz, 0)*beam);
add(shift(3*dz, -bw)*yscale(-1)*rp);

shipout("al_collim_scheme", bbox(2mm, Fill(white)));

unitsize(1mm);

texpreamble("\SetFontSizesXVI");

real h = 20, w = 100;
real zn = 70, zf = 90;
real rp_dist = 3, rp_h = 10, rp_w = 2, h_sh = 5;


filldraw((zn, rp_dist)--(zn+rp_w, rp_dist)--(zn+rp_w, rp_dist+rp_h)--(zn, rp_dist+rp_h)--cycle, black, black);
filldraw((zf, rp_dist)--(zf+rp_w, rp_dist)--(zf+rp_w, rp_dist+rp_h)--(zf, rp_dist+rp_h)--cycle, black, black);

filldraw((zn+h_sh, -rp_h/2)--(zn+rp_w+h_sh, -rp_h/2)--(zn+rp_w+h_sh, +rp_h/2)--(zn+h_sh, +rp_h/2)--cycle, lightgray, lightgray);
filldraw((zf-h_sh, -rp_h/2)--(zf+rp_w-h_sh, -rp_h/2)--(zf+rp_w-h_sh, +rp_h/2)--(zf-h_sh, +rp_h/2)--cycle, lightgray, lightgray);

filldraw((zn, -rp_dist)--(zn+rp_w, -rp_dist)--(zn+rp_w, -rp_dist-rp_h)--(zn, -rp_dist-rp_h)--cycle, black, black);
filldraw((zf, -rp_dist)--(zf+rp_w, -rp_dist)--(zf+rp_w, -rp_dist-rp_h)--(zf, -rp_dist-rp_h)--cycle, black, black);

filldraw((-zn, rp_dist)--(-zn-rp_w, rp_dist)--(-zn-rp_w, rp_dist+rp_h)--(-zn, rp_dist+rp_h)--cycle, black, black);
filldraw((-zf, rp_dist)--(-zf-rp_w, rp_dist)--(-zf-rp_w, rp_dist+rp_h)--(-zf, rp_dist+rp_h)--cycle, black, black);

filldraw((-zn-h_sh, -rp_h/2)--(-zn-rp_w-h_sh, -rp_h/2)--(-zn-rp_w-h_sh, +rp_h/2)--(-zn-h_sh, +rp_h/2)--cycle, lightgray, lightgray);
filldraw((-zf+h_sh, -rp_h/2)--(-zf-rp_w+h_sh, -rp_h/2)--(-zf-rp_w+h_sh, +rp_h/2)--(-zf+h_sh, +rp_h/2)--cycle, lightgray, lightgray);

filldraw((-zn, -rp_dist)--(-zn-rp_w, -rp_dist)--(-zn-rp_w, -rp_dist-rp_h)--(-zn, -rp_dist-rp_h)--cycle, black, black);
filldraw((-zf, -rp_dist)--(-zf-rp_w, -rp_dist)--(-zf-rp_w, -rp_dist-rp_h)--(-zf, -rp_dist-rp_h)--cycle, black, black);

draw(Label("beam axis", 1, E), (-w, 0)--(+w, 0), EndArrow);
draw(Label("$y$", 1, N), (0, -h)--(0, +h), EndArrow);

//label("beam axis", (-w, 0), W, white);


label("top RPs $\rightarrow$", (-w, rp_dist+rp_h/2), W);
label("bottom RPs $\rightarrow$", (-w, -rp_dist-rp_h/2), W);

label("\strut far", (-zf-rp_w/2, -rp_dist-rp_h), S);
label("\strut near", (-zn-rp_w/2, -rp_dist-rp_h), S);

real yst = 2, th = 6;

draw((0, yst)--(-w, -Tan(th)*w + yst), blue+2pt, EndArrow(10));
draw((0, yst)--(w, Tan(th)*w + yst), red+2pt, EndArrow(10));
draw((0, yst)--(w/2, yst), dashed);

dot((0, 0), heavygreen+5pt);
label("\cGr IP5", (0, 0), SW);

label("$y^*$", (0, yst), NW, black);
draw(Label("$\th_y^*$", black, UnFill), arc((0, yst), w*0.48, 0, th));
/*
label("proton transport (optics)", ((zn+zf)/2, rp_dist+rp_h), 6*N);
label("$y_{\rm hit} = L_y\, \th_y^* + v_y\, y^*$", ((zn+zf)/2, rp_dist+rp_h), N, blue);
*/

label("\cGr\bf Left: RP station at -220 m", (-(zn+zf)/2, +rp_dist+rp_h), 6*N);
label("\cGr\bf Right: RP station at +220 m", ((zn+zf)/2, +rp_dist+rp_h), 6*N);

label("\vbox{%
\hbox{four-momentum transfer squared: $t$}%
\hbox{scattering angle: $\th^* \simeq \sqrt t / p$}%
\hbox{azimuthal angle: $\ph^*$}%
\hbox{horizontal angle: $\th_x^* = \th^* \cos \ph^*$}%
\hbox{vertical angle: $\th_y^* = \th^* \sin \ph^*$}%
}", (-w, -30), 3*SE);

shipout(bbox(1mm, Fill(white)));

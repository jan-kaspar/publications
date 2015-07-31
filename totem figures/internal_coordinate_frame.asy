unitsize(1cm);

StdFonts();

//----------------------------------------------------------------------------------------------------

picture Det0;

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 75;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;

// strips
real delta = (edge - margin_v_b - margin_v_e) / (strips - 1);
for (int i = 0; i < strips; ++i) {
	draw(Det0, (margin_u, margin_v_b + i*delta)--(edge-margin_u, margin_v_b + i*delta), black+0.1pt);
}

// clip shape and draw boundary
clip(Det0, Det0Shape);
draw(Det0, Det0Shape, black + 2);

//----------------------------------------------------------------------------------------------------

picture Lab;

// axes
real cLen = 3;
draw(Lab, (0, 0)--(cLen, 0), EndArrow);
draw(Lab, (0, 0)--(0, cLen), EndArrow);
label(Lab, "u", (cLen, 0), E);
label(Lab, "v", (0, cLen), N);

real dist = 3;
draw(Lab, (-dist, edge/2-margin_v_e)--(-dist, -edge/2*1.3), EndArrow);
draw(Lab, (-dist-0.1, edge/2-margin_v_e)--(-dist+0.1, edge/2-margin_v_e));

draw(Lab, (-dist+0.0, edge/2-margin_v_e)--(-edge/2 - 0.2, edge/2-margin_v_e), Dotted);
draw(Lab, (-dist+0.0, -edge/2+margin_v_b)--(-edge/2 + cutEdge - 0.2 - margin_v_b, -edge/2+margin_v_b), Dotted);

label(Lab, rotate(-90.) * Label("strips", W), (-dist, -edge/2*1.3 - 0.8));
label(Lab, rotate(-90.) * Label("$0$"), (-dist-0.5, edge/2-margin_v_e));
label(Lab, rotate(-90.) * Label("(first)"), (-dist-1.0, edge/2-margin_v_e));
label(Lab, rotate(-90.) * Label("$511$"), (-dist-0.5, -edge/2+margin_v_b));
label(Lab, rotate(-90.) * Label("(last)"), (-dist-1.0, -edge/2+margin_v_b));


//----------------------------------------------------------------------------------------------------

add(rotate(45) * shift(-edge/2, -edge/2) * Det0);
add(rotate(45) * Lab);

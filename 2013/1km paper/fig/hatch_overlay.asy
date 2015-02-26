import patterns;

//add("hatch-excl", hatch(2.7mm, NE, black));
add("hatch-excl", hatch(8mm, NE, black));

real w = 74mm, h = 15.5mm;

filldraw((0, 0)--(w, 0)--(w, h)--(0, h)--cycle, pattern("hatch-excl"), nullpen);
//filldraw((0, 0)--(w, 0)--(w, h)--(0, h)--cycle, black + opacity(0.3), nullpen);

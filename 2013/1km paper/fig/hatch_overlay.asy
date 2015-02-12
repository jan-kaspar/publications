import patterns;

add("hatch-excl", hatch(2.7mm, NE, black));

real w = 60mm, h = 12mm;

filldraw((0, 0)--(w, 0)--(w, h)--(0, h)--cycle, pattern("hatch-excl"), nullpen);

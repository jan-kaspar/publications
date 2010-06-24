unitsize(0.3mm);


real s = 100;
real gap = 10;

draw((0, 0)--(512 - gap, 0), black+1pt, Bars);
label("511", (512 - gap, 0), SW);


for (int i = 0; i < 4; ++i) {
	draw((i*128, s)--((i+1)*128 - gap, s), black+1pt, Bars);
	label("0", (i*128, s), SE);
	label("127", ((i+1)*128 - gap, s), SW);
	draw((i*128, 0)--(i*128, s), dotted);
	label((string)(i*128), (i*128, 0), SE);
	label("VFAT " + (string)(i), (i*128 + (128 - gap) / 2, s), N);
}

shipout(bbox(2mm, nullpen));

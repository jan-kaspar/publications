real cx = 35mm, cy = 12mm;

label("Ideal", (-0.5cx, 0cy), W);
label("Measured", (-0.5cx, -1cy), W);
label("Real", (-0.5cx, -2cy), W);
label("Misaligned", (-0.5cx, -3cy), W);

label("Compact View", (0cx, 1cy));
label("(logical tree)", (0cx, 0.7cy));

label("DetGeomDesc", (1cx, 1cy));
label("(expanded tree)", (1cx, 0.7cy));

label("TotemRPGeometry", (2cx, 1cy));

pen dotPen = black+8pt;
dot((0cx, 0cy), dotPen);
dot((0cx, -1cy), dotPen);

dot((1cx, -1cy), dotPen);
dot((1cx, -2cy), dotPen);
dot((1cx, -3cy), dotPen);

dot((2cx, -1cy), dotPen);
dot((2cx, -2cy), dotPen);
dot((2cx, -3cy), dotPen);

draw(Label("Measured aligments", 0.5, E), (0cx, 0cy)--(0cx, -1cy), red, EndArrow);

draw(Label("Real aligments", 0.5, E), (1cx, -1cy)--(1cx, -2cy), red, EndArrow);
draw(Label("Misaligned aligments", 1.5, W), (1cx, -1cy)..(0.9cx, -2cy)..(1cx, -3cy), red, EndArrow);

draw((0cx, -1cy)--(1cx, -1cy), blue, EndArrow);
draw((1cx, -1cy)--(2cx, -1cy), blue, EndArrow);
draw((1cx, -2cy)--(2cx, -2cy), blue, EndArrow);
draw((1cx, -3cy)--(2cx, -3cy), blue, EndArrow);

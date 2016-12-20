real cx = 35mm, cy = 12mm;

label("Ideal", (-0.5cx, 0cy), W);
label("Real", (-0.5cx, -2cy), W);
label("Misaligned", (-0.5cx, -3cy), W);

label("Compact View", (0cx, 1cy));
label("(logical tree)", (0cx, 0.7cy));

label("DetGeomDesc", (1cx, 1cy));
label("(expanded tree)", (1cx, 0.7cy));

label("TotemRPGeometry", (2cx, 1cy));

pen dotPen = black+8pt;
dot((0cx, 0cy), dotPen);
dot((0cx, -2cy), dotPen);
dot((0cx, -3cy), dotPen);

dot((1cx, -2cy), dotPen);
dot((1cx, -3cy), dotPen);

dot((2cx, -2cy), dotPen);
dot((2cx, -3cy), dotPen);

draw(Label("Real aligments", 0.5, E), (0cx, 0cy)--(0cx, -2cy), red, EndArrow);

draw(Label("Misaligned aligments", 1.7, E), (0cx, -0cy)..(-0.1cx, -1.5cy)..(0cx, -3cy), red, EndArrow);

draw((0cx, -2cy)--(1cx, -2cy), blue, EndArrow);
draw((1cx, -2cy)--(2cx, -2cy), blue, EndArrow);

draw((0cx, -3cy)--(1cx, -3cy), blue, EndArrow);
draw((1cx, -3cy)--(2cx, -3cy), blue, EndArrow);

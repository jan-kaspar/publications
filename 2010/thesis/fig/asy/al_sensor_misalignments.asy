//----------------------------------------------------------------------------------------------------

real edge = 3.6101;
real cutEdge = 2.22721 / sqrt(2);
int strips = 11;
real margin_v_e = 0.2;
real margin_v_b = 0.4;
real margin_u = 0.1;

path Det0Shape = (cutEdge, 0)--(edge, 0)--(edge, edge)--(0, edge)--(0, cutEdge)--cycle;
path det = rotate(45) * shift(-edge/2, -edge/2) * Det0Shape;

//----------------------------------------------------------------------------------------------------

real al = 3, de_rho = 20;

unitsize(1cm);

draw(det, dashed);
draw(rotate(de_rho)*det, black+1pt);
dot((0, 0));
draw((0, 0)--(0, al), dotted);
draw((0, 0)--(-al*Sin(de_rho), al*Cos(de_rho)), dotted);

draw(Label("$\De\rh$"), arc((0, 0), al/2, 90, 90+de_rho), red, EndArrow);

pair O = (6, 0);

real dx = -0.3, dy = 1;

draw(shift(O)*det, dashed);
dot(O);
draw(shift(O+(dx, dy))*det, black+1pt);
dot(O+(dx, dy));

draw(Label("$\De\vec c$", 0.5, W), O--(O+(dx, dy)), blue, EndArrow);

pair P = O + (dx, dy);
pair d = (-Cos(45), Sin(45));
pair ds = d.x * dx + d.y * dy;

draw(Label("$\vec d$", 1, NW), P--(P + al*d), EndArrow);
draw(P--(P - 1.5*d), dotted);
draw(Label("$\De s = \vec d \cdot \De \vec c $", 0.5, NE, UnFill), P--(P - ds*d), red, BeginArrow);

import pad_layout;

NewPad(false, false);

unitsize(1cm);

real dx = 1, h = 4, dy = 0.4, ss = 0.05;
real a = 0.27, b = 1, x_min = -dx, x_max = 5dx;
real a_min = -10, a_max = 10;

pen colors[] = { black, red, blue, heavygreen, magenta, cyan };

draw((x_min, a*x_min + b)--(x_max, a*x_max + b), black+1pt);

real x_data[], y_data[];
x_data[0] = -1; y_data[0] = round(0.75h / dy);


draw(((x_data[0]+2)*dx, y_data[0]*dy), mCi+colors[0]+2pt);

int i = 1;
for (real x = 0; x <= 4*dx; x += dx) {
	draw((x, 0)--(x, h));

	for (real y = 0; y <= h; y += dy) {
		draw((x, y)--(x+ss, y));
	}

	real y = a*x + b;
	y = dy * round(y / dy);

	draw((x, y), mCi+colors[i]+2pt);

	x_data[i] = (x - 2)/dx;
	y_data[i] = y / dy;

	++i;
}


NewPad("$a/a_0$", "$b/P$");

//filldraw(shift(a/dy*dx, (b+a*2*dx)/dy)*scale(1.4, 2.1)*unitcircle, black+opacity(0.3), black);
filldraw(shift(a/dy*dx, (b+a*2*dx)/dy)*((-1.5, 2)--(-1.5, -2)--(1.5, -2)--(1.5, 2)--cycle), black+opacity(0.3), black);

for (int i : x_data.keys) {
	draw((a_min, -x_data[i]*a_min + y_data[i])--(a_max, -x_data[i]*a_max + y_data[i]), colors[i]);
}

for (int i : x_data.keys)
	for (int j : x_data.keys)
		if (j > i && x_data[i] != x_data[j]) {
			real a = (y_data[i] - y_data[j]) / (x_data[i] - x_data[j]);
			real b = y_data[i] - a*x_data[i];
			
			draw((a, b), mCi+black);
		}

limits((-10, -10), (10, 20), Crop);

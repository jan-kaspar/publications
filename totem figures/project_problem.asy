import three;

projection[] projections;

// completely wrong
projections.push(perspective(3*(-7, 4.5, 9), up=Y));

// better, but still not quite OK
projections.push(perspective(3*(-7, 4.5, 9), up=Y, autoadjust=true, center=false));

// looks OK
projections.push(orthographic((-1.5, 0.4, 1), (0, 1, 0)));

frame final;

for (int i : projections.keys) {
	currentpicture = new picture;
	unitsize(1cm);
	currentprojection = projections[i];
	
	draw((0, 0, -5)--(0, 0, 20), red);
	for (real z = 0; z <= 15; z += 5) {
		draw((0, 0, z)--(0, 1, z), blue, EndArrow3);
		label(project(Label("text"), X, Y, (0, 1, z)), green);
	}

	add(final, currentpicture.fit(), (0, -i*300));
}

currentpicture = new picture;
attach(final);

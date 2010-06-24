import graph;

size(10cm, 10cm, IgnoreAspect);

real t1_min = 3.1, t1_max = 4.7;
real t2_min = 5.3, t2_max = 6.5;
real cms_max = 3.;

filldraw((t1_min, -pi)--(t1_min, +pi)--(t1_max, +pi)--(t1_max, -pi)--cycle, paleblue, black);
filldraw((t2_min, -pi)--(t2_min, +pi)--(t2_max, +pi)--(t2_max, -pi)--cycle, palegreen, black);
filldraw((9, -pi){0.2, 1}..{0, 1}(9.5, -pi/2){0, 1}..{-0.2, 1}(9, 0){1, -0.1}..tension 1.2 ..{0, -0.5}(13, -pi/2){0, -1}..tension 1.2 ..{-1, -0.1}cycle, palered, black);
filldraw((9, +pi){0.2, -1}..{0, -1}(9.5, +pi/2){0, -1}..{-0.2, -1}(9, 0){1, 0.1}..tension 1.2 ..{0, 0.5}(13, +pi/2){0, 1}..tension 1.2 ..{-1, 0.1}cycle, palered, black);
draw((0, -pi)--(0, +pi)--(cms_max, +pi)--(cms_max, -pi)--cycle, black+dashed);

label("T1", ((t1_min + t1_max)/2, 0));
label("T2", ((t2_min + t2_max)/2, 0));
label("RP", (11, pi/2));
label("RP", (11, -pi/2));
label("CMS", (cms_max/2, 0), gray);

xlimits(0, 13);

xaxis(Label("pseudorapidity\quad$\eta = -\log\tan {\th\over 2}$", 1), Bottom, LeftTicks);
yaxis(Label("azimuthal angle\quad$\ph$", 1), Left, RightTicks);
xaxis("", Top, NoTicks);
yaxis(Label("\vbox{\hsize6.5cm\noindent RP acceptance optics dependent\hfil\break $\rightarrow$ see later}", lightred), Right, NoTicks);

for (int i = 0; i > -6; --i) {
	real eta = -log(tan(pow10(i)/2));
	real length = 0.2;
	draw((eta, pi)--(eta, pi-length));
	string lab = "$10^{" + (string)i + "}$";
	label(lab, (eta, pi), N);
}

label("scattering angle\quad$\th\un{rad}$", (13, pi+0.5), NW);

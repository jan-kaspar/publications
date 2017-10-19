all: B_vs_s B_vs_t si_el_fit

B_vs_s : B_vs_s.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		B_vs_s.cc -o B_vs_s

B_vs_t : B_vs_t.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		B_vs_t.cc -o B_vs_t

si_el_fit : si_el_fit.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		si_el_fit.cc -o si_el_fit

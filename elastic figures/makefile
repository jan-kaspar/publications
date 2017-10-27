all: B_vs_s_fit B_vs_t si_el_fit build_uncertainty_bands

B_vs_s_fit : B_vs_s_fit.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		B_vs_s_fit.cc -o B_vs_s_fit

B_vs_t : B_vs_t.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		B_vs_t.cc -o B_vs_t

si_el_fit : si_el_fit.cc stat.h
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		si_el_fit.cc -o si_el_fit

build_uncertainty_bands : build_uncertainty_bands.cc stat.h
	g++ `root-config --libs` -lMinuit `root-config --cflags` \
		build_uncertainty_bands.cc -o build_uncertainty_bands

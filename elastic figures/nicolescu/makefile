all: model_2007 model_2017

model_2007: model_2007.cc
	g++ --std=c++11 -Wall `root-config --libs` -lMinuit `root-config --cflags` \
		model_2007.cc -o model_2007

model_2017: model_2017.cc
	g++ --std=c++11 -Wall `root-config --libs` -lMinuit `root-config --cflags` \
		model_2017.cc -o model_2017

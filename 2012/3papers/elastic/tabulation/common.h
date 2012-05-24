#include "TF1.h"
#include "TRandom2.h"

#include <cmath>
#include <vector>

using namespace std;

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

double Solve(TF1* f, double v, double a, double b, unsigned int N = 10000)
{
	double d = (b - a) / N;
	double x = a;
	double diff_min = 1E100;
	double x_min = 0.;
	for (unsigned int i = 0; i < N; i++, x += d) {
		double diff = f->Eval(x) - v;
		if (fabs(diff) < diff_min) {
			x_min = x;
			diff_min = fabs(diff);
		}
	}

	return x_min;
}

//----------------------------------------------------------------------------------------------------

double SolveNewton(TF1* f, double v, double a, double b, unsigned int N = 100)
{
	double mu = 1E-3;
	double ep = (b - a) * mu;

	double x = (b + a) / 2.;
	for (unsigned int i = 0; i < N; i++) {
		double fx = f->Eval(x);
		double d = (f->Eval(x + ep) - fx ) / ep;
		x = x - (fx - v) / d;
	}

	return x;
}

//----------------------------------------------------------------------------------------------------

TH1D *test = new TH1D("test", "", 100, 0., 0.);

void SolveUncertainty(TF1* f, double a, double b, double &rep, double &mean, double &stddev, bool fillTest = false, unsigned int repetitions = 1000)
{
	double S1 = 0, Sc = 0, Scc = 0;
	for (unsigned int ri = 0; ri < repetitions; ri++) {
		// make function with errors
		TF1 fe(*f);

		for (int pi = 0; pi < fe.GetNpar(); pi++) {
			fe.SetParameter(pi, fe.GetParameter(pi) + gRandom->Gaus() * fe.GetParError(pi));
		}

		double f_mean = fe.Integral(a, b) / (b - a);

		// find the control point
		double cp = SolveNewton(&fe, f_mean, a, b);
		
		double cp_ref = Solve(&fe, f_mean, a, b, 100), cp_ref_unc = (b-a)/100.;

		// remove outliers
		if (cp != cp)
			continue;

		if (cp < a || cp > b)
			continue;

		if (fabs(cp - cp_ref) > cp_ref_unc)
			continue;

		if (fillTest)
			test->Fill(cp);

		// statistics
		S1++;
		Sc += cp;
		Scc += cp*cp;
	}

	rep = S1;
	mean = Sc/S1;
	double var = (Scc - Sc*Sc/S1) / S1;
	stddev = (var > 0.) ? sqrt(var) : 0.;
}

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

signed int before = 3, after = 2, digits = 2;

void PrintTuple(const vector<double> &num)
{
	/*
	printf("* ");
	for (unsigned int i = 0; i < num.size(); i++) {
		printf("%.2E, ", num[i]);
	}
	printf("\n");
	*/

	signed int be_max = before, af_max = after, dec_max = 0;
	for (unsigned int i = 0; i < num.size(); i++) {
		signed int o = floor(log10(num[i]));
		signed int ol = o - digits + 1;
		
		//printf("\t:: %i, %i\n", o, ol);

		be_max = max(be_max, o+1);
		af_max = max(af_max, -ol);
		dec_max = max(dec_max, -ol);
	}

	//printf("\tbe=%i, af=%i, dec=%i\n", be_max, af_max, dec_max);

	char buf[10];
	sprintf(buf, "%%.%if", dec_max);

	for (unsigned int i = 0; i < num.size(); i++) {
		if (i > 0)
			printf(" & ");

		printf("$");
		
		signed int o = floor(log10(num[i]));
		//signed int ol = o - digits + 1;
		
		for (signed int j = 0; j < be_max - max(0, o) - 1; j++)
			printf("S");

		printf(buf, num[i]);

		if (dec_max == 0)
			printf(".");
		
		for (signed int j = 0; j < af_max - dec_max ; j++)
			printf("S");

		printf("$");
	}
}

//----------------------------------------------------------------------------------------------------

void PrintTuple(double v, double e1=-1, double e2=-1, double e3=-1)
{
	vector<double> num;
	num.push_back(v);
	if (e1 > 0.)
		num.push_back(e1);
	if (e2 > 0.)
		num.push_back(e2);
	if (e3 > 0.)
		num.push_back(e3);

	PrintTuple(num);
}

//----------------------------------------------------------------------------------------------------

struct BinData
{
	double cp, cp_e;
	double v, v_stat_e, v_syst_e;

	BinData(double _cp=0, double _cp_e=0, double _v=0, double _vste=0, double _vsye=0) :
		 cp(_cp), cp_e(_cp_e), v(_v), v_stat_e(_vste), v_syst_e(_vsye) {}
};

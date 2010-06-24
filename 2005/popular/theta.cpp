Double_t W, m;

Double_t print_t(Double_t th)
{
		// degrees to rad conversion
		Double_t th_rad = th * 3.141593 / 180;
		Double_t p_sq = (W*W - 4 * m*m) / 4;
		Double_t t = 2 * p_sq * (1 - cos(th_rad));
		printf("th = %f\t|t| = %f\tp = %f\n", th, t, sqrt(p_sq));
} 

void theta()
{
m = 0.938;	// GeV
W = 53;

/*print_t(0.5E-2);
print_t(0.75E-2);
print_t(1E-2);
print_t(1.25E-2);
print_t(1.5E-2); */

print_t(0.5);
print_t(1);
print_t(1.5);
print_t(2);
print_t(3);
print_t(4);
}

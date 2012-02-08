import root;
import pad_layout;

StdFonts();

xSizeDef = 4cm;
ySizeDef = 4cm;

string dir = "../background";

//----------------------------------------------------------------------------------------------------

string f = dir+"/bckg_45b_56t.root";

string x_lab[] = {
	"$\th_x^{\rm R} \un{\mu rad}$",
	"$\th_y^{*\rm R} \un{\mu rad}$",
	"$x_{\rm F}^{\rm R}\un{mm}$",
	"$x_{\rm F}^{\rm L}\un{mm}$",
	"$y_{\rm F}^{\rm R} + y_{\rm N}^{\rm R} \un{mm}$",
	"$y_{\rm F}^{\rm L} + y_{\rm N}^{\rm L} \un{mm}$"
};

string y_lab[] = {
	"$\th_x^{\rm L} \un{\mu rad}$",
	"$\th_y^{*\rm L} \un{\mu rad}$",
	"$\th_x^{\rm R} \un{\mu rad}$",
	"$\th_x^{\rm L} \un{\mu rad}$",
	"$y_{\rm F}^{\rm R} - y_{\rm N}^{\rm R} \un{mm}$",
	"$y_{\rm F}^{\rm L} - y_{\rm N}^{\rm L} \un{mm}$"
};


real x_scale[] = { 1e6, 1e6, 1, 1, 1, 1};
real y_scale[] = { 1e6, 1e6, 1e6, 1e6, 1, 1};

// cut is |a*p_a + b*p_b - c| < n*si
// plots: p_a on horizontal and p_b on vertical axis

real a[] = { -7.04547e-01 , -6.97510e-01 , -1.84508e-04 , -2.80017e-04 , 9.016e-3, 4.852e-3};
real b[] = { -7.09656e-01 , -7.16574e-01 , +9.99999e-01 , +9.99999e-01 , -7.07049e-1, -7.07090e-1 };
real c[] = { +2.79616e-06, +1.18720e-05, -3.38128e-05, -3.62602e-05, +1.61861e-02, -5.63749e-02 };
real si[] = { 2.4e-5*0.325, 2.4e-5, 3.33860e-05, 3.54507e-05, 1.42454e-02, 1.32129e-02 };
real all[] = { -1.5e-4, 1.5e-4, -2, -2, 6, -20};
real aul[] = { 1.5e-4, 5e-4, 2, 2, 20, -6 };
real bll[] = { -1.5e-4, -5e-4, -1.5e-4, -1.5e-4, -0.1 , -0.2};
real bul[] = { 1.5e-4, -1.5e-4, 1.5e-4, 1.5e-4	, +0.3, +0.2};

TH2_palette = Gradient(white, blue, heavygreen, red);

for (int i = 0; i < 6; ++i) {
	write("* ", i);

	if ((i % 2) == 0)
		NewRow();

	transform tr = scale(x_scale[i], y_scale[i]);
	
	NewPad(x_lab[i], y_lab[i], axesAbove=true);
	scale(Linear, Linear, Log);
	draw(tr, rGetObj(f, "sp"+format("%u", i+1)), "p");

	draw(tr*((all[i], (-a[i]*all[i] + 3si[i] + c[i]) / b[i])--(aul[i], (-a[i]*aul[i] + 3si[i] + c[i]) / b[i])), black+1pt);
	draw(tr*((all[i], (-a[i]*all[i] + 0si[i] + c[i]) / b[i])--(aul[i], (-a[i]*aul[i] + 0si[i] + c[i]) / b[i])), black+1pt+dotted);
	draw(tr*((all[i], (-a[i]*all[i] - 3si[i] + c[i]) / b[i])--(aul[i], (-a[i]*aul[i] - 3si[i] + c[i]) / b[i])), black+1pt);

	limits(tr*(all[i], bll[i]), tr*(aul[i], bul[i]), Crop);

	AttachLegend("cut "+format("%u", i+1));
}

GShipout(hSkip=5mm, vSkip=2mm);

/*

//----------------------------------------------------------------------------------------------------

string f = dir+"/bckg_45t_56b.root";

!! NEEDS UPDATE !!

string y_lab[] = { "$\th_x^R$", "$\th_y^{*R}$", "$x_F^R\un{mm}$", "$x_F^L\un{mm}$", "$y_F^R\un{mm}$", "$y_F^L\un{mm}$" };
string x_lab[] = { "$\th_x^L$", "$\th_y^{*L}$", "$\th_x^R$", "$\th_x^L$", "$y_N^R\un{mm}$", "$y_N^L\un{mm}$" };

real a[] = { -7.04547e-01 , -6.97510e-01 , -3.83597e-04 , -2.80017e-04 , -6.98033e-01 , -7.02238e-01 };
real b[] = { -7.09656e-01 , -7.16574e-01 , -9.99999e-01 , +9.99999e-01 , +7.16065e-01 , +7.11941e-01 };
real c[] = { +2.79616e-06, +1.18720e-05, -5.76763e-05, -3.62602e-05, +1.61861e-02, -5.63749e-02 };
real si[] = { 2.4e-5*0.325, 2.4e-5, 6.88152e-05, 3.54507e-05, 1.42454e-02, 1.32129e-02 };


real a[] = { -7.09324e-01 , -7.10084e-01 , -2.70076e-04 , -2.77379e-04 , -7.01656e-01 , -6.99685e-01 };
real b[] = { -7.04881e-01 , -7.04116e-01 , +9.99999e-01 , -9.99999e-01 , +7.12515e-01 , +7.14450e-01 };
real c[] = { -6.81434e-06, -1.16077e-05, +3.69936e-05, +5.27273e-05, -5.18657e-02, -3.07259e-04 };
real si[] = { 2.4e-5*0.325, 2.4e-5, 3.33860e-05, 3.59451e-05, 1.38554e-02, 1.28446e-02 };
real ll[] = {-1.5e-4, 1.5e-4, -1.5e-4, -1.5e-4, 3, -10};
real ul[] = {1.5e-4, 5e-4, 1.5e-4, 1.5e-4, 10, -3};
	
for (int i = 0; i < 6; ++i) {
	if (i == 3)
		NewRow();
	
	NewPad(x_lab[i], y_lab[i]);
	draw(rGetObj(f, "sp"+format("%u", i+1)), "p,i");

	draw((ll[i], (-b[i]*ll[i] + 3si[i] + c[i]) / a[i])--(ul[i], (-b[i]*ul[i] + 3si[i] + c[i]) / a[i]), black+1pt);
	draw((ll[i], (-b[i]*ll[i] - 3si[i] + c[i]) / a[i])--(ul[i], (-b[i]*ul[i] - 3si[i] + c[i]) / a[i]), black+1pt);

	draw((ll[i], (-b[i]*ll[i] + 2si[i] + c[i]) / a[i])--(ul[i], (-b[i]*ul[i] + 2si[i] + c[i]) / a[i]), black+dashed+1pt);
	draw((ll[i], (-b[i]*ll[i] - 2si[i] + c[i]) / a[i])--(ul[i], (-b[i]*ul[i] - 2si[i] + c[i]) / a[i]), black+dashed+1pt);
	xlimits(ll[i], ul[i], Crop);

	AttachLegend("cut "+format("%u", i+1));
}
*/

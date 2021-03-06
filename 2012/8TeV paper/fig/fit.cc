TGraphErrors *g = new TGraphErrors;

void AddPoint(double W, double si, double err)
{
	if (W < 10)
		return;

	double x = log(W*W);

	int idx = g->GetN();
	g->SetPoint(idx, x, si);
	g->SetPointError(idx, 0., err);
}

void fit()
{
	g = new TGraphErrors();

	AddPoint(1.88278E+00, 9.37E+01, 2E+01);
	AddPoint(1.891481E+00, 8.9E+01, 1.5E+01);
	AddPoint(1.898907E+00, 8E+01, 1E+01);
	AddPoint(1.900703E+00, 7.47E+01, 1.9E+00);
	AddPoint(1.901376E+00, 8.65E+01, 1.6E+01);
	AddPoint(1.90549E+00, 7.57E+01, 1.9E+00);
	AddPoint(1.907633E+00, 7.76E+01, 3.3E+00);
	AddPoint(1.909595E+00, 7.31E+01, 1.8E+00);
	AddPoint(1.913381E+00, 7.11E+01, 1.7E+00);
	AddPoint(1.916766E+00, 6.8E+01, 1.7E+00);                                                                                                                    
	AddPoint(1.917835E+00, 7.11E+01, 2.8E+00);                                                                                                                   
	AddPoint(1.920078E+00, 6.55E+01, 1.6E+00);                                                                                                                   
	AddPoint(1.921013E+00, 6.6E+01, 6E+00);                                                                                                                      
	AddPoint(1.923091E+00, 6.64E+01, 1.6E+00);                                                                                                                   
	AddPoint(1.925795E+00, 6.87E+01, 2.5E+00);                                                                                                                   
	AddPoint(1.925978E+00, 6.36E+01, 1.5E+00);
	AddPoint(1.928722E+00, 6.48E+01, 1.5E+00);
	AddPoint(1.928934E+00, 6.6E+01, 1.7E+01);
	AddPoint(1.930757E+00, 6.2E+01, 2.2E+00);
	AddPoint(1.931526E+00, 6.48E+01, 1.5E+00);
	AddPoint(1.933944E+00, 6.37E+01, 1.5E+00);
	AddPoint(1.936403E+00, 6.42E+01, 1.4E+00);
	AddPoint(1.937693E+00, 6.26E+01, 2.3E+00);
	AddPoint(1.937989E+00, 6.57E+01, 1.7E+01);
	AddPoint(1.938902E+00, 6.07E+01, 1.4E+00);
	AddPoint(1.941208E+00, 5.65E+01, 1.3E+00);
	AddPoint(1.941902E+00, 7.2E+01, 1E+01);
	AddPoint(1.943546E+00, 5.9E+01, 1.4E+00);
	AddPoint(1.943737E+00, 5.95E+01, 2.1E+00);
	AddPoint(1.94528E+00, 7.7E+01, 1.7E+01);
	AddPoint(1.945677E+00, 5.55E+01, 1.3E+00);
	AddPoint(1.947691E+00, 5.2E+01, 6E+00);
	AddPoint(1.947834E+00, 5.49E+01, 1.3E+00);
	AddPoint(1.950014E+00, 5.17E+01, 1.5E+00);
	AddPoint(1.950532E+00, 6.35E+01, 2.2E+00);
	AddPoint(1.956486E+00, 6.13E+01, 2E+00);
	AddPoint(1.959099E+00, 5.6E+01, 1.4E+01);
	AddPoint(1.962089E+00, 5.73E+01, 1.8E+00);
	AddPoint(1.972582E+00, 6.4E+01, 8E+00);
	AddPoint(1.986516E+00, 5.34E+01, 2.1E+00);
	AddPoint(1.988216E+00, 5.12E+01, 1.6E+00);
	AddPoint(1.995284E+00, 4.5E+01, 5E+00);
	AddPoint(2.004666E+00, 5E+01, 6.5E+00);
	AddPoint(2.006624E+00, 4.73E+01, 5E-01);
	AddPoint(2.015537E+00, 4.93E+01, 2E+00);
	AddPoint(2.036243E+00, 4.9E+01, 6E+00);
	AddPoint(2.036936E+00, 4.72E+01, 1.9E+00);
	AddPoint(2.078526E+00, 4.45E+01, 1.8E+00);
	AddPoint(2.111767E+00, 4.42E+01, 1.8E+00);
	AddPoint(2.118517E+00, 4.38E+01, 8E-01);
	AddPoint(2.126846E+00, 4.2E+01, 5E+00);
	AddPoint(2.128696E+00, 4.38E+01, 1.8E+00);
	AddPoint(2.159568E+00, 4.33E+01, 1.3E+00);
	AddPoint(2.159568E+00, 4.21E+01, 1.7E+00);
	AddPoint(2.163025E+00, 4.32E+01, 3.5E+00);
	AddPoint(2.183856E+00, 4.15E+01, 1.2E+00);
	AddPoint(2.183856E+00, 4.13E+01, 1.7E+00);
	AddPoint(2.190831E+00, 4.33E+01, 3E+00);
	AddPoint(2.194323E+00, 4.13E+01, 4E-01);
	AddPoint(2.198858E+00, 4.2E+01, 4E+00);
	AddPoint(2.204819E+00, 4.01E+01, 1.6E+00);
	AddPoint(2.204819E+00, 4.22E+01, 1.2E+00);
	AddPoint(2.229398E+00, 4.18E+01, 1.2E+00);
	AddPoint(2.229398E+00, 3.87E+01, 1.6E+00);
	AddPoint(2.247813E+00, 3.8E+01, 4E+00);
	AddPoint(2.254069E+00, 3.75E+01, 1.5E+00);
	AddPoint(2.257598E+00, 3.94E+01, 1.3E+00);
	AddPoint(2.261129E+00, 3.93E+01, 8E-01);
	AddPoint(2.268192E+00, 3.85E+01, 3E+00);
	AddPoint(2.289398E+00, 3.76E+01, 1.5E+00);
	AddPoint(2.296469E+00, 3.72E+01, 3E+00);
	AddPoint(2.302253E+00, 3.3E+01, 3E+00);
	AddPoint(2.307075E+00, 3.81E+01, 1.2E+00);
	AddPoint(2.323348E+00, 3.3E+01, 2E+00);
	AddPoint(2.328281E+00, 3.7E+01, 1.5E+00);
	AddPoint(2.350648E+00, 3E+01, 2E+00);
	AddPoint(2.360047E+00, 3.61E+01, 1.2E+00);
	AddPoint(2.363572E+00, 3.57E+01, 1.4E+00);
	AddPoint(2.381179E+00, 3.52E+01, 1.4E+00);
	AddPoint(2.398751E+00, 3.39E+01, 1.4E+00);
	AddPoint(2.412781E+00, 3.54E+01, 1.2E+00);
	AddPoint(2.422205E+00, 2.8E+01, 2E+00);
	AddPoint(2.433775E+00, 3.24E+01, 1.3E+00);
	AddPoint(2.47208E+00, 3.18E+01, 1.3E+00);
	AddPoint(2.482482E+00, 3.08E+01, 1.2E+00);
	AddPoint(2.510121E+00, 3.04E+01, 1.2E+00);
	AddPoint(2.54103E+00, 2.9E+01, 1.896207E+00);
	AddPoint(2.54103E+00, 2.9E+01, 1.896207E+00);
	AddPoint(2.544452E+00, 2.98E+01, 1.2E+00);
	AddPoint(2.578528E+00, 2.86E+01, 1.1E+00);
	AddPoint(2.585312E+00, 2.74E+01, 1.1E+00);
	AddPoint(2.635845E+00, 2.59E+01, 1E+00);
	AddPoint(2.665867E+00, 2.56E+01, 6E-01);
	AddPoint(2.685756E+00, 2.56E+01, 1E+00);
	AddPoint(2.697126E+00, 2.5E+01, 4E+00);
	AddPoint(2.735034E+00, 2.45E+01, 1E+00);
	AddPoint(2.767532E+00, 2.37E+01, 1.377935E+00);
	AddPoint(2.857032E+00, 2.19E+01, 1.1E+00);
	AddPoint(2.956674E+00, 2.09E+01, 8E-01);
	AddPoint(2.971995E+00, 2.06E+01, 1.220236E+00);
	AddPoint(3.077434E+00, 1.975E+01, 7.3E-01);
	AddPoint(3.362614E+00, 1.6E+01, 9.484725E-01);
	AddPoint(3.549778E+00, 1.63E+01, 6E-01);
	AddPoint(3.549778E+00, 1.59E+01, 4E-01);
	AddPoint(3.627227E+00, 1.56E+01, 1.014582E+00);
	AddPoint(3.850713E+00, 1.47E+01, 1.5E+00);
	AddPoint(3.860359E+00, 1.42E+01, 1.2E+00);
	AddPoint(3.922479E+00, 1.379E+01, 1.214665E+00);
	AddPoint(3.946154E+00, 1.365E+01, 5.6E-01);
	AddPoint(4.108031E+00, 1.288E+01, 6.517177E-01);
	AddPoint(4.108031E+00, 1.27E+01, 1.450138E+00);
	AddPoint(4.285773E+00, 1.233E+01, 4E-01);
	AddPoint(4.307467E+00, 1.389E+01, 7.777083E-01);
	AddPoint(4.359176E+00, 1.175E+01, 2.3E-01);
	AddPoint(4.539661E+00, 1.46E+01, 3.379778E+00);
	AddPoint(4.93436E+00, 1.134E+01, 6E-01);
	AddPoint(4.93436E+00, 1.159E+01, 7.098734E-01);
	AddPoint(4.93436E+00, 1.159E+01, 4.1E-01);
	AddPoint(5.642422E+00, 9.4E+00, 5.107837E-01);
	AddPoint(5.642422E+00, 9.1E+00, 1.038316E+00);
	AddPoint(7.005874E+00, 8.67E+00, 5.573222E-01);
	AddPoint(7.875491E+00, 8.68E+00, 2.4E-01);
	AddPoint(7.875491E+00, 8.21E+00, 1E-01);
	AddPoint(8.776705E+00, 7.17E+00, 4.975661E-01);
	AddPoint(9.671628E+00, 7.81E+00, 2.4E-01);
	AddPoint(9.777741E+00, 8.2E+00, 4E-01);
	AddPoint(1.153821E+01, 7.3E+00, 4.7E-01);
	AddPoint(1.153821E+01, 6.4E+00, 1E+00);
	AddPoint(1.37631E+01, 7.39E+00, 3.6E-01);
	AddPoint(1.37631E+01, 7.8E+00, 6E-01);
	AddPoint(1.626291E+01, 7.52E+00, 6E-01);
	AddPoint(1.81703E+01, 7.12E+00, 5.2E-01);
	AddPoint(3.04E+01, 7.16E+00, 4.445503E-01);
	AddPoint(5.26E+01, 7.44E+00, 4.369963E-01);
	AddPoint(5.28E+01, 7.89E+00, 2.027348E-01);
	AddPoint(6.23E+01, 7.46E+00, 4.375415E-01);
	AddPoint(5.459935E+02, 1.287E+01, 3E-01);
	AddPoint(5.470065E+02, 1.33E+01, 6.145641E-01);
	AddPoint(1.80001E+03, 1.579E+01, 8.7E-01);
	AddPoint(1.80001E+03, 1.97E+01, 8.5E-01);
	AddPoint(1.80001E+03, 1.66E+01, 1.6E+00);
	AddPoint(2.032594E+00, 2.32E+01, 5.132797E-01);
	AddPoint(2.075043E+00, 2.4E+01, 1E+00);
	AddPoint(2.081808E+00, 2.58E+01, 5.163729E-01);
	AddPoint(2.084964E+00, 2.4E+01, 5.2E+00);
	AddPoint(2.093946E+00, 2.2E+01, 2E+00);
	AddPoint(2.118856E+00, 2.58E+01, 5.163729E-01);
	AddPoint(2.124278E+00, 2.4E+01, 5E+00);
	AddPoint(2.138285E+00, 2.52E+01, 8E-01);
	AddPoint(2.151409E+00, 2.5E+01, 5.385165E+00);
	AddPoint(2.154392E+00, 2.53E+01, 5.157541E-01);
	AddPoint(2.160259E+00, 2.42E+01, 1.6E+00);
	AddPoint(2.177383E+00, 2.51E+01, 8E-01);
	AddPoint(2.180434E+00, 2.3E+01, 2E+00);
	AddPoint(2.181767E+00, 2.47E+01, 1E+00);
	AddPoint(2.191878E+00, 2.46E+01, 5.149068E-01);
	AddPoint(2.227287E+00, 2.43E+01, 6.121783E-01);
	AddPoint(2.241122E+00, 2.1E+01, 4.651881E+00);
	AddPoint(2.245306E+00, 2.4E+01, 3E+00);
	AddPoint(2.265013E+00, 2.41E+01, 5.143153E-01);
	AddPoint(2.299297E+00, 2.6E+01, 3E+00);
	AddPoint(2.311201E+00, 2.68E+01, 2.3E+00);
	AddPoint(2.311201E+00, 2.48E+01, 9E-01);
	AddPoint(2.320154E+00, 2.47E+01, 5.150265E-01);
	AddPoint(2.321214E+00, 2.82E+01, 2.1E+00);
	AddPoint(2.323348E+00, 1.9E+01, 4.841487E+00);
	AddPoint(2.354758E+00, 2.27E+01, 5.127204E-01);
	AddPoint(2.390321E+00, 2.25E+01, 5.125E-01);
	AddPoint(2.426784E+00, 2.21E+01, 5.120647E-01);
	AddPoint(2.499774E+00, 2.22E+01, 3.4E+00);
	AddPoint(2.509718E+00, 1.986E+01, 6.85E-01);
	AddPoint(2.702253E+00, 1.63E+01, 1.151291E+00);
	AddPoint(2.704073E+00, 1.921E+01, 5.598486E-01);
	AddPoint(2.767532E+00, 1.72E+01, 9.815009E-01);
	AddPoint(2.779362E+00, 1.7E+01, 3.937321E+00);
	AddPoint(2.971995E+00, 1.52E+01, 8.542037E-01);
	AddPoint(2.978178E+00, 1.532E+01, 7.6E-01);
	AddPoint(3.077434E+00, 1.35E+01, 3E-01);
	AddPoint(3.121682E+00, 1.16E+01, 2.6E+00);
	AddPoint(3.30735E+00, 1.44E+01, 1.301544E+00);
	AddPoint(3.362614E+00, 1.27E+01, 7.127861E-01);
	AddPoint(3.431936E+00, 1E+01, 2.5E+00);
	AddPoint(3.502538E+00, 1.199E+01, 2.5E-01);
	AddPoint(3.618254E+00, 1E+01, 2.1E+00);
	AddPoint(3.627227E+00, 1.15E+01, 6.794115E-01);
	AddPoint(3.777617E+00, 1.147E+01, 3.3E-01);
	AddPoint(3.826472E+00, 1.179E+01, 2.2E-01);
	AddPoint(3.826496E+00, 1.06E+01, 7.054367E-01);
	AddPoint(3.855539E+00, 1.14E+01, 5E-01);
	AddPoint(3.880996E+00, 8E+00, 2.332381E+00);
	AddPoint(3.893065E+00, 9.7E+00, 1E+00);
	AddPoint(3.893065E+00, 9.8E+00, 9E-01);
	AddPoint(4.130655E+00, 1.08E+01, 4E-01);
	AddPoint(4.219973E+00, 8.74E+00, 4E-01);
	AddPoint(4.285773E+00, 1.171E+01, 2.2E-01);
	AddPoint(4.285773E+00, 9.8E+00, 3E-01);
	AddPoint(4.307489E+00, 1.01E+01, 6.123416E-01);
	AddPoint(4.329098E+00, 1.084E+01, 3.2E-01);
	AddPoint(4.352765E+00, 1.08E+01, 8E-01);
	AddPoint(4.412683E+00, 8.6E+00, 8E-01);
	AddPoint(4.517772E+00, 1E+01, 3E+00);
	AddPoint(4.519037E+00, 1.02E+01, 1.609627E+00);
	AddPoint(4.541718E+00, 1.02E+01, 6E-01);
	AddPoint(4.701454E+00, 1.104E+01, 2.2E-01);
	AddPoint(4.721295E+00, 9.9E+00, 6.083274E-01);
	AddPoint(4.93436E+00, 9.87E+00, 2.3E-01);
	AddPoint(4.93436E+00, 9.85E+00, 2E-01);
	AddPoint(4.953282E+00, 1.04E+01, 1.7E+00);
	AddPoint(5.083784E+00, 1.089E+01, 3E-01);
	AddPoint(5.156891E+00, 8.87E+00, 4.248284E-01);
	AddPoint(5.4396E+00, 1.048E+01, 3.2E-01);
	AddPoint(5.458292E+00, 1.1E+01, 4E+00);
	AddPoint(5.473921E+00, 8.13E+00, 3E-01);
	AddPoint(5.491002E+00, 9.7E+00, 1.538514E+00);
	AddPoint(5.558805E+00, 9.2E+00, 1.4E+00);
	AddPoint(5.558805E+00, 8.75E+00, 4.21769E-01);
	AddPoint(5.675526E+00, 9.36E+00, 4.9E-01);
	AddPoint(5.75746E+00, 9.74E+00, 3.7E-01);
	AddPoint(6.058773E+00, 1.02E+01, 1.8E+00);
	AddPoint(6.104997E+00, 8.59E+00, 3.453845E-01);
	AddPoint(6.120328E+00, 8.7E+00, 5E-01);
	AddPoint(6.150875E+00, 9.4E+00, 1.3E+00);
	AddPoint(6.211522E+00, 9.64E+00, 4.4E-01);
	AddPoint(6.271585E+00, 9E+00, 1.439618E+00);
	AddPoint(6.477441E+00, 8E+00, 1.6E+00);
	AddPoint(6.520711E+00, 8.15E+00, 3.27059E-01);
	AddPoint(6.77455E+00, 8.3E+00, 9.5E-01);
	AddPoint(6.843396E+00, 8.3E+00, 2E-01);
	AddPoint(6.911558E+00, 8.8E+00, 3E-01);
	AddPoint(6.92511E+00, 8.02E+00, 3.230983E-01);
	AddPoint(7.138457E+00, 9.8E+00, 2.2E+00);
	AddPoint(7.307228E+00, 7.96E+00, 3.164142E-01);
	AddPoint(7.584309E+00, 8.2E+00, 1.368539E+00);
	AddPoint(7.621314E+00, 7.7E+00, 2E-01);
	AddPoint(7.682594E+00, 7.87E+00, 3.089866E-01);
	AddPoint(8.017124E+00, 7.66E+00, 3.024527E-01);
	AddPoint(8.349507E+00, 7.7E+00, 2.910846E-01);
	AddPoint(8.549325E+00, 7.6E+00, 2.84176E-01);
	AddPoint(8.829981E+00, 7.52E+00, 2.852617E-01);
	AddPoint(9.305836E+00, 7.4E+00, 2.813912E-01);
	AddPoint(9.777741E+00, 7.61E+00, 2.9E-01);
	AddPoint(9.777741E+00, 7E+00, 2E-01);
	AddPoint(9.777741E+00, 7.56E+00, 1.2E-01);
	AddPoint(9.835138E+00, 7.48E+00, 2.879917E-01);
	AddPoint(9.977188E+00, 7.33E+00, 2.832277E-01);
	AddPoint(1.019116E+01, 7.23E+00, 2.759245E-01);
	AddPoint(1.042775E+01, 7.21E+00, 2.714416E-01);
	AddPoint(1.051733E+01, 7.49E+00, 8E-02);
	AddPoint(1.069424E+01, 6.6E+00, 7E-01);
	AddPoint(1.071178E+01, 7.25E+00, 2.727436E-01);
	AddPoint(1.0997E+01, 6.89E+00, 2.573972E-01);
	AddPoint(1.121662E+01, 7.07E+00, 2.633088E-01);
	AddPoint(1.147298E+01, 6.86E+00, 2.564137E-01);
	AddPoint(1.152194E+01, 6.86E+00, 2.600923E-01);
	AddPoint(1.153821E+01, 7.41E+00, 3.1E-01);
	AddPoint(1.153821E+01, 7.1E+00, 2E-01);
	AddPoint(1.37631E+01, 7.07E+00, 3.5E-01);
	AddPoint(1.37631E+01, 7.08E+00, 9E-02);
	AddPoint(1.389877E+01, 6.9E+00, 1E+00);
	AddPoint(1.626291E+01, 7E+00, 2.8E-01);
	AddPoint(1.666186E+01, 6.85E+00, 2.4E-01);
	AddPoint(1.682995E+01, 6.97E+00, 1.1E-01);
	AddPoint(1.81703E+01, 7.06E+00, 2.8E-01);
	AddPoint(1.941836E+01, 6.87E+00, 1.3E-01);
	AddPoint(1.941836E+01, 6.95E+00, 8E-02);
	AddPoint(1.965847E+01, 6.92E+00, 4.4E-01);
	AddPoint(1.965847E+01, 6.92E+00, 4.4E-01);
	AddPoint(2.170021E+01, 6.78E+00, 2.3E-01);
	AddPoint(2.35E+01, 6.7E+00, 3E-01);
	AddPoint(2.35E+01, 6.82E+00, 8E-02);
	AddPoint(2.35E+01, 6.8E+00, 3.598898E-01);
	AddPoint(2.35E+01, 6.81E+00, 3.321171E-01);
	AddPoint(2.376395E+01, 7.29E+00, 1.6E-01);
	AddPoint(2.376395E+01, 7.89E+00, 5.2E-01);
	AddPoint(2.388211E+01, 7.2E+00, 4E-01);
	AddPoint(3.04E+01, 6.8E+00, 6E-01);
	AddPoint(3.06E+01, 6.9E+00, 4E-01);
	AddPoint(3.06E+01, 7.39E+00, 8E-02);
	AddPoint(3.06E+01, 7E+00, 3.613876E-01);
	AddPoint(3.06E+01, 6.75E+00, 3.190611E-01);
	AddPoint(4.49E+01, 7.45E+00, 8E-02);
	AddPoint(4.49E+01, 7.5E+00, 4.242641E-01);
	AddPoint(5.28E+01, 7.79E+00, 1.696882E-01);
	AddPoint(5.28E+01, 7.56E+00, 8E-02);
	AddPoint(5.28E+01, 7.6E+00, 4.217262E-01);
	AddPoint(5.28E+01, 7.17E+00, 3.005898E-01);
	AddPoint(6.23E+01, 7.51E+00, 3.554436E-01);
	AddPoint(6.25E+01, 7.77E+00, 1E-01);


	AddPoint(7e3, 25.1, 4.3);
	AddPoint(8e3, 27.0, 4.8);

	TCanvas *c = new TCanvas();
	c->SetLogx(0);
	g->Draw("ap");
}

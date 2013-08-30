real l = 2, zl = 0.4;

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label("$\SetFontSizesXIV\displaystyle \si_{\rm tot}$", (0, 0.05));

pair d = (0, 1);
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl elastic observables only:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot}^2 = {16\pi\over 1+\cRe\rh^2\cBlack}\ {1\over {\cal\cRe L\cBlack}}\ \left. \cRe\d N_{\rm el}\over \d t \right|_{0}\cBlack$}
}", v, d);
draw(Label("\vbox{
%\hbox{June (EPL96): $\displaystyle\si_{\rm tot} = (98.3 \pm 2.0)\un{mb}$}
%\hbox{October: $\displaystyle\si_{\rm tot} = (98.6 \pm 2.3)\un{mb}$}
}", 0.5, E), v--zv, EndArrow);

pair d = (-Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl $\rh$-independent:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = \cRe{1\over {\cal L}}\cBlack\ (\cRe N_{\rm el}\cBlack + \cRe N_{\rm inel}\cBlack)$}
%\kern2mm
%\hbox{$\displaystyle \si_{\rm tot} = (99.1 \pm 4.4)\un{mb}$}
}", v, d);
draw(v--zv, EndArrow);


pair d = (+Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl luminosity-independent:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = {16\pi\over 1+\cRe\rh^2\cBlack}\ {\cRe \d N_{\rm el}/ \d t|_{0}\cBlack \over\cRe N_{\rm el}\cBlack + \cRe N_{\rm inel}\cBlack}$}
%\kern2mm
%\hbox{$\displaystyle \si_{\rm tot} = (98.1 \pm 2.4)\un{mb}$}
\kern3mm
\hbox{$\displaystyle \cGreen{\cal L}\cBlack = {1+\cRe\rh^2\cBlack\over 16\pi}\ { (\cRe N_{\rm el}\cBlack + \cRe N_{\rm inel}\cBlack)^2 \over {\cRe \d N_{\rm el}/ \d t|_{0}\cBlack}}$}
}", v, d);
draw(v--zv, EndArrow);

shipout("tot_cs_methods", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label("$\SetFontSizesXIV\displaystyle \si_{\rm tot}$", (0, 0.05));

pair d = (0, 1);
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl elastic observables only:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot}^2 = {16\pi\over 1+\cBlack\rh^2\cBlack}\ {1\over {\cal\cBlack L\cBlack}}\ \left. \cBlack\d N_{\rm el}\over \d t \right|_{0}\cBlack$}
\kern2mm
\hbox{\cGr$\displaystyle\si_{\rm tot} = (98.6 \pm 2.3)\un{mb}$\cBlack}
}", v, d);
draw(v--zv, EndArrow);

pair d = (-Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl $\rh$-independent:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = \cBlack{1\over {\cal L}}\cBlack\ (\cBlack N_{\rm el}\cBlack + \cBlack N_{\rm inel}\cBlack)$}
\kern2mm
\hbox{\cGr$\displaystyle \si_{\rm tot} = (99.1 \pm 4.4)\un{mb}$\cBlack}
}", v, S+0.2W);
draw(v--zv, EndArrow);


pair d = (+Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl luminosity-independent:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = {16\pi\over 1+\cBlack\rh^2\cBlack}\ {\cBlack \d N_{\rm el}/ \d t|_{0}\cBlack \over\cBlack N_{\rm el}\cBlack + \cBlack N_{\rm inel}\cBlack}$}
\kern2mm
\hbox{\cGr$\displaystyle \si_{\rm tot} = (98.1 \pm 2.4)\un{mb}$\cBlack}
}", v, S+0.2E);
draw(v--zv, EndArrow);

shipout("tot_cs_methods_res7", bbox(1mm, Fill(white)));

//----------------------------------------------------------------------------------------------------

currentpicture = new picture;
unitsize(1cm);

label("$\SetFontSizesXIV\displaystyle \si_{\rm tot}$", (0, 0.05));

pair d = (0, 1);
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cGray elastic observables only:\cGray}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot}^2 = {16\pi\over 1+\cGray\rh^2\cGray}\ {1\over {\cal\cGray L\cGray}}\ \left. \cGray\d N_{\rm el}\over \d t \right|_{0}\cGray$}
\kern2mm
\hbox{\cWhite$\displaystyle\si_{\rm tot} = (98.6 \pm 2.3)\un{mb}$\cGray}
}", v, d);
draw(v--zv, gray, EndArrow);

pair d = (-Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cGray $\rh$-independent:\cGray}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = \cGray{1\over {\cal L}}\cGray\ (\cGray N_{\rm el}\cGray + \cGray N_{\rm inel}\cGray)$}
%\kern2mm
%\hbox{\cGray$\displaystyle \si_{\rm tot} = (99.1 \pm 4.4)\un{mb}$\cGray}
}", v, S+0.2W);
draw(v--zv, gray, EndArrow);


pair d = (+Cos(30), -Sin(30));
pair v = l*d, zv = zl*d;
label("\vbox{
\hbox{\it\cBl luminosity-independent:\cBlack}
\kern2mm
\hbox{$\displaystyle \si_{\rm tot} = {16\pi\over 1+\cBlack\rh^2\cBlack}\ {\cBlack \d N_{\rm el}/ \d t|_{0}\cBlack \over\cBlack N_{\rm el}\cBlack + \cBlack N_{\rm inel}\cBlack}$}
\kern2mm
\hbox{\cGr$\displaystyle \si_{\rm tot} = (101.7 \pm 2.9)\un{mb}$\cBlack}
}", v, S+0.2E);
draw(v--zv, EndArrow);

shipout("tot_cs_methods_res8", bbox(1mm, Fill(white)));

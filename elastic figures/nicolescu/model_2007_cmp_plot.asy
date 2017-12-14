import root;
import pad_layout;

xSizeDef = 10cm;
ySizeDef = 8cm;

//----------------------------------------------------------------------------------------------------

NewPad();
scale(Log, Linear);

//dot(Scale((20, 39))--Scale((100, 47))--Scale((200, 52))--Scale((1e3, 68)), black);

dot(Scale((500, 62.8))--Scale((14e3, 123.32)), blue);

draw(RootGetObject("model_2007.root", "g_si_tot_pp_vs_s"), "def", blue+dashed);
draw(RootGetObject("model_2007.root", "g_si_tot_pap_vs_s"), "def", red+dashed);

limits((1e0, 0), (1e7, 150), Crop);


//----------------------------------------------------------------------------------------------------

NewPad(axesAbove = true);
scale(Log, Linear);

label(shift(128, -20)*scale(0.655, 0.524)*Label("\IncludeGraphics{model_2007_original.pdf}"));

layer();

dot(Scale((7e3, 0.116827))--Scale((8e3,  0.114232))--Scale((13e3, 0.104750)), blue);

//draw(RootGetObject("model_2007_full.root", "g_rho_pp_vs_s"), "def", gray);
//draw(RootGetObject("model_2007_full.root", "g_rho_pap_vs_s"), "def", gray);

draw(RootGetObject("model_2007.root", "g_rho_pp_vs_s"), "def", blue+dashed);
draw(RootGetObject("model_2007.root", "g_rho_pap_vs_s"), "def", red+dashed);

limits((1e0, -0.4), (1e7, 0.3), Crop);

//----------------------------------------------------------------------------------------------------

NewPad(axesAbove = true);
scale(Log, Linear);

label(shift(128, -8)*scale(0.655, 0.524)*Label("\IncludeGraphics{model_2007_de_rho_original.pdf}"));

layer();

draw(RootGetObject("model_2007.root", "g_de_rho_vs_s"), "def", black+dashed);

limits((1e0, -0.1), (1e7, 0.3));

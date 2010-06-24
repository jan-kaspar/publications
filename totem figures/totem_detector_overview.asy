unitsize(1cm);

label(Label("\pdfximage width20cm{cms_totem.pdf}\pdfrefximage\pdflastximage"), (0, 8));
label(Label("\pdfximage width10mm{cms_totem.pdf}\pdfrefximage\pdflastximage"), (-8.9, 0.6));

label(Label("\pdfximage width20cm{RP_stations_original.pdf}\pdfrefximage\pdflastximage"));

draw((-9.5, 1)--(-9.5, 5));
draw((-8.5, 1){0, 0.1}..{1, 0}(0, 3){1, 0}..{0, 0.1}(+8.5, 5));

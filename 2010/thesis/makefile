files = $(wildcard fig/asy/*.asy)
timestamps = $(patsubst fig/asy/%, fig/.timecache/%.pdf, $(files))

.PHONY: all asy tex info

all: asy tex

tex: thesis.pdf

thesis.pdf : thesis.tex references.tex $(timestamps) \
	alignment.tex appendices.tex  elastic.tex introduction.tex references.tex \
	first_el_measurement.tex
	@echo "* TeX"
	@#pdftex -fmt encpdftex -interaction batchmode thesis.tex &> /dev/nul
	@pdftex -interaction batchmode thesis.tex &> /dev/null || pdftex thesis.tex

references.tex : references.bib
	@echo "* bib -> tex"
	@bib2tex references.bib

asy: fig/.timecache fig/pdf $(timestamps)

.timecache :
	@mkdir -p .timecache

fig/.timecache :
	@mkdir -p fig/.timecache

fig/pdf :
	@mkdir -p fig/pdf

$(timestamps) : fig/.timecache/%.pdf : fig/asy/%
	@echo "* asy $<"
	cd "fig/asy"; asy -o "../pdf/" $(ASYOPT) "../../$<"
	@touch $@

info:
	@echo $(files)
	@echo $(timestamps)

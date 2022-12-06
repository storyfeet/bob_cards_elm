.Phony: browser

browser: 
	nu cardlister.nu
	elm make src/Main.elm --output out/travel.js

cards:
	nu cardlister.nu
	elm-node --js src/svg_maker.js src/SvgMaker.elm
	
rules: 
	siter exec -t rules.md -d "../pics" > out/rules.html
	siter exec -t adventure.md -d "../pics" > out/adventure.html

SVGFILES := $(wildcard cards_out/*.svg)

all_pages: cards $(SVGFILES:cards_out/%.svg=cards_out/%.pdf) 

%.pdf : %.svg
	inkscape --file=$*.svg --export-pdf=$*.pdf

cards_file : cards cards_out/all_pages.pdf

cards_out/all_pages.pdf :all_pages
	pdfunite cards_out/front*.pdf cards_out/tiles*.pdf cards_out/backs.pdf cards_out/widefront*.pdf cards_out/wideback*.pdf cards_out/all_pages.pdf

	
clean:
	rm cards_out/*


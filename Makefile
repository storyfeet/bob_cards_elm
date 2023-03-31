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


rules_print:
	echo "works with out/rules_a5.pdf"
	pdftk out/rules_a5.pdf cat 20 1 2 19 18 3 4 17 16 5 6 15 14 7 8 13 12 9 10 11 output out/rules_a5_sorted.pdf
	pdfjam --nup 2x1 --outfile out/rules_2x1.pdf --landscape out/rules_a5_sorted.pdf


SVGFILES := $(wildcard cards_out/*.svg)

all_pages: cards $(SVGFILES:cards_out/%.svg=cards_out/%.pdf) 

%.pdf : %.svg
	inkscape --file=$*.svg -o $*.pdf

cards_file : cards cards_out/all_pages.pdf

cards_out/all_pages.pdf : all_pages
	pdfunite cards_out/cards*.pdf cards_out/card_backs*.pdf cards_out/tiles*.pdf cards_out/tile_backs*.pdf  cards_out/players*.pdf cards_out/player_backs*.pdf cards_out/missions*.pdf cards_out/mission_backs*.pdf cards_out/all_pages.pdf

	
clean:
	rm cards_out/*


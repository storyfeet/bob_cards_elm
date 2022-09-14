.Phony: browser

browser: 
	nu cardlister.nu
	elm make src/Main.elm --output out/travel.js

cards:
	nu cardlister.nu
	elm-node --js src/svg_maker.js src/SvgMaker.elm




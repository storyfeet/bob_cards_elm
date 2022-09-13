.Phony: browser


browser: 
	elm make src/Main.elm --output out/travel.js

cards:
	elm-node --js src/svg_maker.js src/SvgMaker.elm

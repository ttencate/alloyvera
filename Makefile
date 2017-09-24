.PHONY: run
run:
	haxelib run lime test neko

.PHONY: html5
html5:
	haxelib run lime build html5

.PHONY: run
run:
	haxelib run lime test neko

.PHONY: html5
html5:
	haxelib run lime build html5

.PHONY: upload
upload: html5
	rsync -rpltv --delete ./export/html5/bin/ frozenfractal.com:/var/www/mixium.frozenfractal.com/

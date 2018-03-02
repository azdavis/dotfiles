TEXC = pdflatex
TEXFLAGS = -halt-on-error -output-directory=build

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.pdf

all: build/main.pdf

clean:
	rm -rf build

build/%.pdf: src/%.tex
	mkdir -p build
	for x in 1 2; do $(TEXC) $(TEXFLAGS) $< $(Q); done

TEXC = pdflatex -halt-on-error -interaction nonstopmode -output-directory build
Q = >/dev/null

.SUFFIXES:
.PHONY: all clean

all: build/main.pdf

clean:
	rm -rf build

build/%.pdf: src/%.tex
	mkdir -p build
	for x in 1 2; do $(TEXC) $^ $(Q); done

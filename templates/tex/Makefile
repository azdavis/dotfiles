TEXC = pdflatex -halt-on-error -interaction nonstopmode -output-directory build

.SUFFIXES:
.PHONY: all clean

all: build/main.pdf

clean:
	rm -rf build

build/%.pdf: src/%.tex
	mkdir -p build
	! $(TEXC) $^ | grep -e '^!' -e '^l\.'
	! $(TEXC) $^ | grep -e '^!' -e '^l\.'

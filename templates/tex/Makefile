TEXC = pdflatex -halt-on-error -interaction nonstopmode -output-directory build
Q = >/dev/null

.SUFFIXES:
.PHONY: all help clean

all: build/main.pdf ## same as `build/main.pdf`

help: ## show this help
	@sed -ne '/@sed/d' -e 's/:.*##/:/p' Makefile | sort

clean: ## rm generated files
	rm -rf build

build/%.pdf: src/%.tex ## create a pdf from a tex file
	mkdir -p build
	for x in 1 2; do $(TEXC) $^ $(Q); done

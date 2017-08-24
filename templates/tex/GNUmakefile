Q = > /dev/null

.SILENT:
.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.pdf

all: build/{{proj_name}}.pdf

clean:
	rm -rf build

build/%.pdf: src/%.tex src/base.tex
	mkdir -p $(dir $@)
	pdflatex -halt-on-error -output-directory=$(dir $@) $< $(Q)
	pdflatex -halt-on-error -output-directory=$(dir $@) $< $(Q)

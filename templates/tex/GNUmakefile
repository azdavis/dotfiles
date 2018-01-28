TEXC ?= platex
TEXFLAGS ?= -halt-on-error
DVI2PDF ?= dvipdfmx

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.dvi build/%.pdf

all: build/main.pdf

clean:
	rm -rf build

build/%.dvi: src/%.tex
	mkdir -p $(dir $@)
	for x in 1 2; do $(TEXC) -output-directory=$(dir $@) $(TEXFLAGS) $^ $(Q); done

build/%.pdf: build/%.dvi
	$(DVI2PDF) -o $@ $< $(Q)

TEXC ?= platex
TEXFLAGS ?= -halt-on-error
DVI2PDF ?= dvipdfmx

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.dvi build/%.pdf

all: build/main.pdf

clean:
	rm -rf build

build/%.dvi: src/%.tex src/base.tex
	mkdir -p $(dir $@)
	$(TEXC) -output-directory=$(dir $@) $(TEXFLAGS) $< $(Q)
	$(TEXC) -output-directory=$(dir $@) $(TEXFLAGS) $< $(Q)

build/%.pdf: build/%.dvi
	$(DVI2PDF) -o $@ $< $(Q)

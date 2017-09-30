TEXC = pdflatex
TEXFLAGS = -halt-on-error

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.pdf

all: build/{{proj_name}}.pdf

clean:
	rm -rf build

build/%.pdf: src/%.tex src/base.tex
	mkdir -p $(dir $@)
	$(TEXC) -output-directory=$(dir $@) $(TEXFLAGS) $< $(TODEVNULL)
	$(TEXC) -output-directory=$(dir $@) $(TEXFLAGS) $< $(TODEVNULL)

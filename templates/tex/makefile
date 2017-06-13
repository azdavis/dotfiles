MAKEFLAGS += -rRs
Q := > /dev/null

MAIN := src/{{proj}}.pdf
M := $(basename $(MAIN))

.PHONY: all clean

all: $(MAIN)

clean:
	rm -rf $(MAIN) $(M).aux $(M).bbl $(M).dvi $(M).log $(M).toc

%.pdf: %.tex src/base.tex
	cd $(dir $<) && \
	pdflatex -halt-on-error $(notdir $<) $(Q) && \
	pdflatex -halt-on-error $(notdir $<) $(Q)

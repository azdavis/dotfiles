MAKEFLAGS += -rRs
Q := > /dev/null
MAIN := src/{{proj_name}}
MAIN_PDF := $(MAIN).pdf

.PHONY: all clean

all: $(MAIN_PDF)

clean:
	rm -rf \
		$(MAIN_PDF) \
		$(MAIN).aux \
		$(MAIN).bbl \
		$(MAIN).dvi \
		$(MAIN).log \
		$(MAIN).toc

%.pdf: %.tex src/base.tex
	cd $(dir $<) && \
	pdflatex -halt-on-error $(notdir $<) $(Q) && \
	pdflatex -halt-on-error $(notdir $<) $(Q)

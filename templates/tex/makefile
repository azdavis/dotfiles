MAKEFLAGS += -rRs
Q := > /dev/null

MAIN := src/{{proj}}.pdf

.PHONY: all clean

all: $(MAIN)

clean:
	rm -rf $(MAIN)
	find src \( \
		-name '*.aux' -o \
		-name '*.bbl' -o \
		-name '*.dvi' -o \
		-name '*.log' -o \
		-name '*.toc' \
	\) -delete

%.pdf: %.tex src/base.tex
	cd $(dir $<) && \
	pdflatex -halt-on-error $(notdir $<) $(Q) && \
	pdflatex -halt-on-error $(notdir $<) $(Q)

MAKEFLAGS += -rRs

MAIN = src/{{proj}}.pdf

PHONY += all
all: $(MAIN)

%.pdf: %.tex begin.tex
	cd $(dir $<) ;\
	pdflatex -halt-on-error $(notdir $<) ;\
	pdflatex -halt-on-error $(notdir $<)

PHONY += clean
clean:
	rm -rf $(MAIN)
	find src "(" \
	   -name "*.aux" \
	-o -name "*.bbl" \
	-o -name "*.log" \
	-o -name "*.toc" \
	")" -delete

.PHONY: $(PHONY)

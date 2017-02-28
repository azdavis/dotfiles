MAKEFLAGS += -rRs
Q = > /dev/null

MAIN = src/{{proj}}.pdf

PHONY += all
all: $(MAIN)

%.pdf: %.tex src/base.tex
	cd $(dir $<) ;\
	pdflatex -halt-on-error $(notdir $<) $(Q) ;\
	pdflatex -halt-on-error $(notdir $<) $(Q)

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

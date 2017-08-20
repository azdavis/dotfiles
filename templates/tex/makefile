Q = > /dev/null
SRC = src
BUILD = build

.POSIX:

.SILENT:

.PHONY: all clean

all: $(BUILD)/{{proj_name}}.pdf

clean:
	rm -rf $(BUILD)

$(BUILD)/%.pdf: $(SRC)/%.tex src/base.tex
	mkdir -p $(dir $@)
	pdflatex -halt-on-error -output-directory=$(dir $@) $< $(Q)
	pdflatex -halt-on-error -output-directory=$(dir $@) $< $(Q)

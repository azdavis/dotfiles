CFLAGS = -Werror -Weverything -std=c99 -g
SRC = src
BUILD = build

.SILENT:

.PHONY: all clean

.PRECIOUS: $(BUILD)/%.out

all: $(BUILD)/{{proj_name}}.run

clean:
	rm -rf $(BUILD)

$(BUILD)/%.out: $(SRC)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $<

$(BUILD)/%.run: $(BUILD)/%.out
	./$<
	touch $@

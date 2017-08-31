CFLAGS = -std=c99 -g -O0 -Werror -Weverything

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.out build/%.run

all: build/{{proj_name}}.run

clean:
	rm -rf build

build/%.out: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $<

build/%.run: build/%.out
	./$<
	touch $@

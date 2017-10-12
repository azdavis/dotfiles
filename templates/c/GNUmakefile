CC = cc
CFLAGS = -std=c99 -g -O0 -Werror -Weverything

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.out

all: build/{{proj_name}}.out

clean:
	rm -rf build

build/%.out: src/%.c
	mkdir -p $(dir $@)
	$(CC) -o $@ $(CFLAGS) $<

CC = cc
CFLAGS = -std=c99 -g -O0 -Werror -Weverything

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: build/%.out

all: build/main.out

clean:
	rm -rf build

build/%.out: src/%.c
	mkdir -p build
	$(CC) -o $@ $(CFLAGS) $<

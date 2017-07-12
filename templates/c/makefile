MAKEFLAGS += -rRs
CFLAGS := -Werror -Weverything -std=c99 -g
MAIN := src/{{proj}}
OBJS :=

.PHONY: all clean

.PRECIOUS: %.out

all: $(MAIN).run

clean:
	rm -rf $(MAIN).run $(MAIN).out $(MAIN).dSYM $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.out: %.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $<

%.run: %.out
	./$<
	touch $@

MAKEFLAGS += -rRs
CFLAGS := -Werror -Weverything -std=c99 -g

MAIN := src/{{proj}}
OBJS :=

.PHONY: all clean run

all: $(MAIN)

clean:
	rm -rf $(MAIN) $(OBJS)
	find src -name '*.dSYM' -prune -exec rm -rf {} \;

run: all
	./$(MAIN)

$(MAIN): $(MAIN).c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $<

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

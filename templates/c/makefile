MAKEFLAGS += -rRs
CFLAGS := -Werror -Weverything -std=c99 -g

MAIN := src/{{proj}}
OBJS :=

PHONY += all
all: $(MAIN)

$(MAIN): $(MAIN).c $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

PHONY += clean
clean:
	rm -rf $(MAIN) $(OBJS)
	find src -name '*.dSYM' -prune -exec rm -rf {} \;

PHONY += run
run: all
	./$(MAIN)

.PHONY: $(PHONY)

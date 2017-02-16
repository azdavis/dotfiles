MAKEFLAGS += -rRs
MAIN = src/{{proj}}
CFLAGS = -Werror -Weverything -g

%: %.c
	$(CC) $(CFLAGS) -o $@ $<

PHONY += all
all: $(MAIN)

PHONY += clean
clean:
	rm -rf $(MAIN)
	find . "(" -name "*.o" -o -name "*.dSYM" ")" -prune -exec rm -rf {} \;

PHONY += run
run: all
	./$(MAIN)

.PHONY: $(PHONY)

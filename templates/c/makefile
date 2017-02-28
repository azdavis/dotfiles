MAKEFLAGS += -rRs
CFLAGS = -Werror -Weverything -g

MAIN = src/{{proj}}
OBJS =

PHONY += all
all: $(MAIN)

$(MAIN): $(MAIN).c $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

PHONY += clean
clean:
	rm -rf $(MAIN)
	find src "(" \
		   -name "*.dSYM" \
		-o -name "*.o" \
	")" -prune -exec rm -rf {} \;

PHONY += run
run: all
	./$(MAIN)

.PHONY: $(PHONY)

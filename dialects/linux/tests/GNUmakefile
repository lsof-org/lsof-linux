HELPERS = \
	mq-fork \
	mq-open \
	pipe \
	pty \
	target-open-with-flags \
	\
	$(NULL)

CFLAGS  = -g -Wall -std=c99

.PHONY: clean all

all: $(HELPERS)
clean:
	rm -f $(HELPERS) *.o

# See
# https://stackoverflow.com/questions/19964206/weird-posix-message-queue-linking-issue-sometimes-it-doesnt-link-correctly
#
# We cannot use LDFLAGS here.
# -lrt must be at the end of the command line.
#
mq-open: mq-open.o
	$(CC) $(CFLAGS) -o $@ $< -lrt

mq-fork: mq-fork.o
	$(CC) $(CFLAGS) -o $@ $< -lrt

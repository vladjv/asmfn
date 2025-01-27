AS=as
ASFLAGS=--noexecstack -g
LD=ld
LDFLAGS=--format elf64-x86-64 -z defs -z undefs -z muldefs -z noexecstack
INCLUDE=-I "../print_number"
SRCS=factorial.s
OBJS=$(SRCS:.s=.o)

factorial: $(OBJS)
	$(LD) $(LDFLAGS) $(INCLUDE) -o $@ $<

$(OBJS): $(SRCS)
	$(AS) $(ASFLAGS) $(INCLUDE) -o $@ $<

clean:
	$(RM) $(OBJS) ./factorial

CC=clang
FLAGS=-Wall -Wextra
LDFLAGS=
#SAFEFLAGS=$(FLAGS) -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
#OPTFLAGS=`rpm -E %optflags` -O3
EXTRAFLAGS=
#NEWGCCFLAGS=-grecord-gcc-switches -fstack-protector-strong --param=ssp-buffer-size=4
#OPTFLAGS=-O3 -g -pipe -m64 -mtune=native -march=native -flto $(NEWGCCFLAGS)
DBGFLAGS=-O0 -g -pipe -m64 -mtune=native -march=native -flto $(NEWGCCFLAGS)
PKG_FLAGS=`pkg-config --cflags glib-2.0 json-c`
PKG_LDFLAGS=`pkg-config --libs glib-2.0 json-c`

msp430-emu: main.c
	$(CC) $(FLAGS) main.c -o msp430-emu

msp430-sym: main.c emu.h gdbstub.c
	$(CC) $(OPTFLAGS) $(SAFEFLAGS) $(PKG_FLAGS) $< gdbstub.c -o $@

#check: check_instr
#	./check_instr
check: LDFLAGS+=-lcmocka
check: unit_tests
	./unit_tests

check_instr: check_instr.c main.c emu.h
	$(CC) $(DBGFLAGS) $(FLAGS) $(PKG_FLAGS) -DEMU_CHECK $< main.c -lcheck $(PKG_LDFLAGS) $(EXTRAFLAGS) -o $@

clean:
	rm -f check_instr msp430-sym msp430-emu


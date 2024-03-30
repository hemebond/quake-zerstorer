QCC=fteqcc64

ifeq ($(QCC),fteqcc64)
	CFLAGS=-Wall -src qc
endif

ifeq ($(QCC),gmqcc)
	CFLAGS=-std=fteqcc -Wall -Werror -s qc/progs.src
endif



progs.dat: $(wildcard qc/*.qc) qc/progs.src
	$(QCC) $(CFLAGS)


all: progs.dat

clean:
	rm progs.dat

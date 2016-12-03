OBJDUMP=objdump
OBJCOPY=objcopy
QEMU=qemu-system-i386

CFLAGS=-static -nostdinc -fno-builtin -I.

.PHONY: run clean

bootblock: bootasm.S 
	$(CC) $(CFLAGS) -m16 -c bootasm.S
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o bootblock.o bootasm.o
	$(OBJDUMP) -S -m i8086 bootblock.o > bootblock.asm
	$(OBJCOPY) -S -O binary -j .text bootblock.o bootblock
	./sign.pl bootblock

run: bootblock
	$(QEMU) -hda bootblock


OBJ=bootblock

clean:
	rm *.o *.asm ${OBJ}

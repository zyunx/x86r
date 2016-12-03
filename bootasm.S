.code16

start:
	cli			# disable interrupt

	xorw %ax, %ax
	movw %ax, %ds

# print 'a'
	movw $0xB000, %ax
	movw %ax, %ds
	movw $0x8000, %bx
	movb $'a', (%bx)
	movb $0x0f, 1(%bx)

# forever loop
spin:
	jmp spin


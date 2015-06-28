	.file	"yuvtorgb-inline.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	process_vector
	.type	process_vector, @function
process_vector:
.LFB537:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$76, %esp
	.cfi_def_cfa_offset 96
	movl	108(%esp), %eax
	movl	104(%esp), %ebx
	testl	%eax, %eax
	jle	.L1
	movdqa	.LC12, %xmm0
	leal	(%ebx,%ebx), %eax
	leal	0(,%ebx,4), %ebp
	movl	100(%esp), %edi
	movl	96(%esp), %ecx
	xorl	%esi, %esi
	movdqa	%xmm0, %xmm6
	pslld	$24, %xmm0
	movl	%eax, 44(%esp)
	movaps	%xmm0, 16(%esp)
	psrld	$8, %xmm6
	movaps	%xmm6, 48(%esp)
	.p2align 4,,10
	.p2align 3
.L3:
	testl	%ebx, %ebx
	jle	.L5
	pxor	%xmm6, %xmm6
	movl	%edi, %edx
	xorl	%eax, %eax
	movdqa	48(%esp), %xmm5
	movaps	%xmm5, (%esp)
	pxor	%xmm5, %xmm5
	movdqa	.LC5, %xmm7
	.p2align 4,,10
	.p2align 3
.L4:
	addl	$16, %edx
	movq	(%ecx,%eax,2), %xmm0
	addl	$4, %eax
	movdqa	(%esp), %xmm2
	movdqa	.LC0, %xmm3
	pand	%xmm0, %xmm2
	pand	%xmm0, %xmm3
	pand	16(%esp), %xmm0
	psrld	$8, %xmm2
	movdqa	%xmm2, %xmm1
	psubw	.LC1, %xmm3
	punpcklwd	%xmm6, %xmm3
	pslld	$16, %xmm1
	por	%xmm1, %xmm2
	psrld	$24, %xmm0
	movdqa	%xmm0, %xmm1
	psubw	.LC2, %xmm2
	punpcklwd	%xmm6, %xmm2
	pslld	$16, %xmm1
	por	%xmm1, %xmm0
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm3
	pslld	$16, %xmm1
	por	%xmm2, %xmm1
	psubw	.LC2, %xmm0
	punpcklwd	%xmm6, %xmm0
	movdqa	%xmm1, %xmm4
	movdqa	%xmm0, %xmm2
	pmaddwd	.LC3, %xmm4
	pmaddwd	.LC4, %xmm2
	paddd	%xmm4, %xmm2
	psrad	$10, %xmm2
	pcmpgtd	%xmm2, %xmm3
	pand	%xmm3, %xmm2
	pandn	.LC6, %xmm3
	por	%xmm3, %xmm2
	movdqa	%xmm1, %xmm3
	pmaddwd	.LC10, %xmm1
	movdqa	%xmm2, %xmm4
	pmaddwd	.LC8, %xmm3
	pcmpgtd	%xmm5, %xmm4
	pand	%xmm2, %xmm4
	movdqa	%xmm0, %xmm2
	pmaddwd	.LC11, %xmm0
	paddd	%xmm1, %xmm0
	psrad	$10, %xmm0
	pmaddwd	.LC9, %xmm2
	paddd	%xmm3, %xmm2
	movdqa	%xmm7, %xmm3
	psrad	$10, %xmm2
	pslld	$2, %xmm4
	por	.LC7, %xmm4
	pcmpgtd	%xmm2, %xmm3
	pand	%xmm3, %xmm2
	pandn	.LC6, %xmm3
	por	%xmm3, %xmm2
	movdqa	%xmm2, %xmm3
	pcmpgtd	%xmm5, %xmm3
	pand	%xmm3, %xmm2
	movdqa	%xmm7, %xmm3
	pcmpgtd	%xmm0, %xmm3
	pslld	$12, %xmm2
	por	%xmm4, %xmm2
	movdqa	%xmm3, %xmm4
	pand	%xmm3, %xmm0
	pandn	.LC6, %xmm4
	por	%xmm4, %xmm0
	movdqa	%xmm0, %xmm1
	movdqa	%xmm0, %xmm4
	pcmpgtd	%xmm5, %xmm1
	pand	%xmm1, %xmm4
	pslld	$22, %xmm4
	por	%xmm4, %xmm2
	movups	%xmm2, -16(%edx)
	cmpl	%eax, %ebx
	jg	.L4
.L5:
	addl	$1, %esi
	addl	%ebp, %edi
	addl	44(%esp), %ecx
	cmpl	108(%esp), %esi
	jne	.L3
.L1:
	addl	$76, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE537:
	.size	process_vector, .-process_vector
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.text.unlikely
.LCOLDB14:
	.text
.LHOTB14:
	.p2align 4,,15
	.globl	process_usuall
	.type	process_usuall, @function
process_usuall:
.LFB538:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$36, %esp
	.cfi_def_cfa_offset 56
	movl	68(%esp), %edx
	testl	%edx, %edx
	jle	.L9
	movl	64(%esp), %eax
	movl	$0, 24(%esp)
	addl	%eax, %eax
	movl	%eax, 28(%esp)
	movl	64(%esp), %eax
	sall	$2, %eax
	movl	%eax, 32(%esp)
	.p2align 4,,10
	.p2align 3
.L11:
	movl	64(%esp), %eax
	xorl	%ebx, %ebx
	testl	%eax, %eax
	jle	.L21
	movl	%edi, %esi
	movl	60(%esp), %edi
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L37:
	testl	%ecx, %ecx
	jns	.L32
	movb	$0, 8(%esp)
	movb	$0, 7(%esp)
.L14:
	imull	$-775, (%esp), %edx
	imull	$4826, %eax, %ecx
	addl	%edx, %ecx
	imull	$-2670, %esi, %edx
	addl	%edx, %ecx
	movl	%ecx, %edx
	sarl	$10, %edx
	cmpl	$1023, %edx
	jg	.L24
	testl	%edx, %edx
	jns	.L33
	xorl	%ecx, %ecx
	xorl	%edx, %edx
.L16:
	imull	$2389, %eax, %eax
	addl	(%esp), %eax
	imull	$6931, %esi, %ebp
	leal	0(%ebp,%eax,2), %ebp
	movl	%ebp, %eax
	sarl	$10, %eax
	cmpl	$1023, %eax
	jg	.L26
	testl	%eax, %eax
	jns	.L34
	xorl	%ebp, %ebp
	movl	$3, %eax
.L18:
	movb	%al, (%edi,%ebx,4)
	orb	7(%esp), %cl
	orl	%ebp, %edx
	movzbl	8(%esp), %eax
	movb	%dl, 1(%edi,%ebx,4)
	movb	%cl, 2(%edi,%ebx,4)
	movb	%al, 3(%edi,%ebx,4)
	addl	$1, %ebx
	cmpl	64(%esp), %ebx
	je	.L35
.L28:
	movl	56(%esp), %eax
	movl	%ebx, %edx
	andl	$-2, %edx
	movzbl	(%eax,%ebx,2), %eax
	subl	$16, %eax
	cmpl	%ebx, %edx
	je	.L36
.L12:
	imull	$8809, (%esp), %edx
	imull	$4768, %eax, %ecx
	addl	%ecx, %edx
	leal	(%esi,%esi,4), %ecx
	leal	(%esi,%ecx,2), %ecx
	addl	%ecx, %edx
	movl	%edx, %ecx
	sarl	$10, %ecx
	cmpl	$1023, %ecx
	jle	.L37
	movb	$-1, 8(%esp)
	movb	$-64, 7(%esp)
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L26:
	movl	$15, %ebp
	movl	$-1, %eax
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L24:
	movl	$63, %ecx
	movl	$-16, %edx
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L36:
	movl	56(%esp), %esi
	movzbl	1(%esi,%ebx,2), %edx
	leal	-128(%edx), %esi
	movl	%esi, (%esp)
	movl	56(%esp), %esi
	movzbl	3(%esi,%ebx,2), %esi
	addl	$-128, %esi
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L32:
	sall	$6, %ecx
	shrl	$12, %edx
	movb	%cl, 7(%esp)
	movl	%edx, 8(%esp)
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L33:
	sall	$4, %edx
	shrl	$14, %ecx
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L34:
	leal	3(,%eax,4), %eax
	shrl	$16, %ebp
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L35:
	movl	%esi, %edi
.L21:
	addl	$1, 24(%esp)
	movl	28(%esp), %eax
	addl	%eax, 56(%esp)
	movl	32(%esp), %eax
	addl	%eax, 60(%esp)
	movl	24(%esp), %eax
	cmpl	68(%esp), %eax
	jne	.L11
.L9:
	addl	$36, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE538:
	.size	process_usuall, .-process_usuall
	.section	.text.unlikely
.LCOLDE14:
	.text
.LHOTE14:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC15:
	.string	"error pos is %d %d"
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.globl	check
	.type	check, @function
check:
.LFB539:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	44(%esp), %edi
	movl	40(%esp), %ebp
	testl	%edi, %edi
	jle	.L46
	movl	32(%esp), %ebx
	movl	36(%esp), %ecx
	xorl	%esi, %esi
.L40:
	testl	%ebp, %ebp
	jle	.L43
	movzbl	(%ecx), %eax
	cmpb	%al, (%ebx)
	movl	$0, %eax
	je	.L41
	jmp	.L44
	.p2align 4,,10
	.p2align 3
.L42:
	movzbl	(%ecx,%eax), %edx
	cmpb	%dl, (%ebx,%eax)
	jne	.L44
.L41:
	addl	$1, %eax
	cmpl	%ebp, %eax
	jne	.L42
.L43:
	addl	$1, %esi
	addl	%ebp, %ebx
	addl	%ebp, %ecx
	cmpl	%edi, %esi
	jne	.L40
.L46:
	movl	$1, %eax
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L44:
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	%esi
	.cfi_def_cfa_offset 40
	pushl	$.LC15
	.cfi_def_cfa_offset 44
	pushl	$1
	.cfi_def_cfa_offset 48
	call	__printf_chk
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
.L39:
	addl	$12, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE539:
	.size	check, .-check
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.globl	createframe
	.type	createframe, @function
createframe:
.LFB540:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$24, %esp
	.cfi_def_cfa_offset 44
	movl	44(%esp), %edi
	pushl	$0
	.cfi_def_cfa_offset 48
	call	time
	movl	%eax, (%esp)
	call	srand
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	36(%esp), %eax
	testl	%eax, %eax
	jle	.L50
	movl	40(%esp), %edx
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L52:
	testl	%edi, %edi
	leal	(%edi,%edx), %ebx
	movl	%edx, %ebp
	jle	.L54
	.p2align 4,,10
	.p2align 3
.L53:
	call	rand
	movl	%eax, %ecx
	addl	$1, %ebp
	sarl	$31, %ecx
	shrl	$24, %ecx
	addl	%ecx, %eax
	movzbl	%al, %eax
	subl	%ecx, %eax
	movb	%al, -1(%ebp)
	cmpl	%ebx, %ebp
	jne	.L53
.L54:
	addl	$1, %esi
	cmpl	36(%esp), %esi
	movl	%ebx, %edx
	jne	.L52
.L50:
	addl	$12, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE540:
	.size	createframe, .-createframe
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.rodata.str1.1
.LC18:
	.string	"Usuall"
.LC19:
	.string	"%4d "
.LC20:
	.string	"Vector"
.LC21:
	.string	"GO!"
.LC22:
	.string	"You fail %d tests"
.LC23:
	.string	"\nUsuall process"
.LC24:
	.string	"Tics acc: %lld\n"
.LC25:
	.string	"\nVector process"
.LC27:
	.string	"\nperfomance koef is %f\n"
	.section	.text.unlikely
.LCOLDB29:
	.text
.LHOTB29:
	.p2align 4,,15
	.globl	test
	.type	test, @function
test:
.LFB541:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	xorl	%ebx, %ebx
	subl	$216, %esp
	movb	$100, -44(%ebp)
	movb	$-56, -43(%ebp)
	pushl	$614400
	movb	$-126, -42(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movb	$40, -41(%ebp)
	movb	$50, -40(%ebp)
	movb	$60, -39(%ebp)
	movb	$70, -38(%ebp)
	movb	$80, -37(%ebp)
	movb	$90, -36(%ebp)
	movb	$100, -35(%ebp)
	movb	$110, -34(%ebp)
	movb	$120, -33(%ebp)
	movb	$-126, -32(%ebp)
	movb	$-116, -31(%ebp)
	movb	$-106, -30(%ebp)
	movb	$-96, -29(%ebp)
	movl	$0, -60(%ebp)
	movl	$0, -56(%ebp)
	movl	$0, -52(%ebp)
	movl	$0, -48(%ebp)
	call	malloc
	movl	$1228800, (%esp)
	movl	%eax, -156(%ebp)
	call	malloc
	movl	$1228800, (%esp)
	movl	%eax, -160(%ebp)
	call	malloc
	movl	$.LC18, (%esp)
	movl	%eax, -164(%ebp)
	call	puts
	leal	-44(%ebp), %eax
	movl	-104(%ebp), %ecx
	addl	$16, %esp
	movl	%ebx, -104(%ebp)
	movl	%eax, %esi
	leal	-60(%ebp), %eax
	movl	%eax, -144(%ebp)
	movl	%eax, %edi
	movl	$100, %eax
	jmp	.L68
.L155:
	testl	%ebx, %ebx
	jns	.L151
	movb	$0, -88(%ebp)
	movb	$0, -136(%ebp)
.L62:
	imull	$-775, -120(%ebp), %edx
	imull	$4826, %eax, %ebx
	addl	%ebx, %edx
	imull	$-2670, %ecx, %ebx
	addl	%ebx, %edx
	movl	%edx, %ebx
	sarl	$10, %edx
	cmpl	$1023, %edx
	jg	.L115
	testl	%edx, %edx
	jns	.L152
	movb	$0, -140(%ebp)
	xorl	%edx, %edx
.L64:
	imull	$2389, %eax, %eax
	addl	-120(%ebp), %eax
	imull	$6931, %ecx, %ebx
	leal	(%ebx,%eax,2), %eax
	movl	%eax, %ebx
	sarl	$10, %eax
	cmpl	$1023, %eax
	jg	.L117
	testl	%eax, %eax
	jns	.L153
	xorl	%ebx, %ebx
	movl	$3, %eax
.L66:
	movb	%al, (%edi)
	movl	%ebx, %eax
	addl	$1, -104(%ebp)
	orl	%eax, %edx
	movzbl	-140(%ebp), %eax
	addl	$2, %esi
	orb	-136(%ebp), %al
	movb	%dl, 1(%edi)
	addl	$4, %edi
	movb	%al, -2(%edi)
	movzbl	-88(%ebp), %eax
	movb	%al, -1(%edi)
	movl	-104(%ebp), %eax
	cmpl	$4, %eax
	je	.L67
	movzbl	(%esi), %eax
.L68:
	movl	-104(%ebp), %ebx
	subl	$16, %eax
	movl	%ebx, %edx
	andl	$-2, %edx
	cmpl	%edx, %ebx
	je	.L154
.L60:
	imull	$8809, -120(%ebp), %edx
	imull	$4768, %eax, %ebx
	addl	%ebx, %edx
	movl	%edx, %ebx
	leal	(%ecx,%ecx,4), %edx
	leal	(%ecx,%edx,2), %edx
	addl	%ebx, %edx
	movl	%edx, %ebx
	sarl	$10, %ebx
	cmpl	$1023, %ebx
	jle	.L155
	movb	$-1, -88(%ebp)
	movb	$-64, -136(%ebp)
	jmp	.L62
.L117:
	movl	$15, %ebx
	movl	$-1, %eax
	jmp	.L66
.L115:
	movb	$63, -140(%ebp)
	movl	$-16, %edx
	jmp	.L64
.L154:
	movzbl	1(%esi), %edx
	movzbl	3(%esi), %ecx
	leal	-128(%edx), %ebx
	addl	$-128, %ecx
	movl	%ebx, -120(%ebp)
	jmp	.L60
.L151:
	sall	$6, %ebx
	shrl	$12, %edx
	movb	%bl, -136(%ebp)
	movl	%edx, -88(%ebp)
	jmp	.L62
.L152:
	shrl	$14, %ebx
	sall	$4, %edx
	movl	%ebx, -140(%ebp)
	jmp	.L64
.L153:
	leal	3(,%eax,4), %eax
	shrl	$16, %ebx
	jmp	.L66
.L67:
	leal	-60(%ebp), %ebx
.L69:
	subl	$4, %esp
	pushl	(%ebx)
	addl	$4, %ebx
	pushl	$.LC19
	pushl	$1
	call	__printf_chk
	leal	-44(%ebp), %eax
	addl	$16, %esp
	cmpl	%eax, %ebx
	jne	.L69
	subl	$12, %esp
	pushl	$.LC20
	call	puts
	movdqa	.LC12, %xmm0
	addl	$16, %esp
	movl	-144(%ebp), %ebx
	movq	-44(%ebp), %xmm3
	movdqa	%xmm0, %xmm1
	pslld	$24, %xmm0
	psrld	$8, %xmm1
	movaps	%xmm1, -120(%ebp)
	pand	%xmm3, %xmm1
	movaps	%xmm0, -184(%ebp)
	pand	%xmm3, %xmm0
	movdqa	.LC0, %xmm2
	psrld	$24, %xmm0
	pand	%xmm3, %xmm2
	movdqa	%xmm1, %xmm3
	psrld	$8, %xmm3
	movdqa	%xmm3, %xmm1
	psubw	.LC1, %xmm2
	pslld	$16, %xmm1
	por	%xmm3, %xmm1
	movdqa	%xmm0, %xmm3
	pslld	$16, %xmm3
	por	%xmm3, %xmm0
	psubw	.LC2, %xmm1
	pxor	%xmm3, %xmm3
	psubw	.LC2, %xmm0
	punpcklwd	%xmm3, %xmm2
	punpcklwd	%xmm3, %xmm1
	punpcklwd	%xmm3, %xmm0
	pslld	$16, %xmm2
	por	%xmm2, %xmm1
	movdqa	%xmm0, %xmm2
	movdqa	%xmm1, %xmm3
	pmaddwd	.LC4, %xmm2
	movdqa	%xmm1, %xmm5
	pmaddwd	.LC10, %xmm1
	pmaddwd	.LC3, %xmm3
	paddd	%xmm3, %xmm2
	movdqa	.LC5, %xmm3
	psrad	$10, %xmm2
	pmaddwd	.LC8, %xmm5
	pcmpgtd	%xmm2, %xmm3
	pand	%xmm3, %xmm2
	pandn	.LC6, %xmm3
	por	%xmm3, %xmm2
	pxor	%xmm3, %xmm3
	movdqa	%xmm2, %xmm4
	pcmpgtd	%xmm3, %xmm4
	pand	%xmm4, %xmm2
	movdqa	%xmm0, %xmm4
	pmaddwd	.LC11, %xmm0
	paddd	%xmm1, %xmm0
	movdqa	.LC5, %xmm1
	psrad	$10, %xmm0
	pmaddwd	.LC9, %xmm4
	paddd	%xmm5, %xmm4
	psrad	$10, %xmm4
	movdqa	.LC5, %xmm5
	pcmpgtd	%xmm0, %xmm1
	pslld	$2, %xmm2
	por	.LC7, %xmm2
	pcmpgtd	%xmm4, %xmm5
	pand	%xmm1, %xmm0
	pand	%xmm5, %xmm4
	pandn	.LC6, %xmm5
	pandn	.LC6, %xmm1
	por	%xmm5, %xmm4
	por	%xmm1, %xmm0
	movdqa	%xmm4, %xmm5
	pcmpgtd	%xmm3, %xmm5
	movdqa	%xmm0, %xmm1
	pand	%xmm5, %xmm4
	pcmpgtd	%xmm3, %xmm1
	pand	%xmm1, %xmm0
	pslld	$12, %xmm4
	por	%xmm4, %xmm2
	pslld	$22, %xmm0
	por	%xmm0, %xmm2
	movups	%xmm2, -60(%ebp)
.L70:
	subl	$4, %esp
	pushl	(%ebx)
	addl	$4, %ebx
	pushl	$.LC19
	pushl	$1
	call	__printf_chk
	leal	-44(%ebp), %eax
	addl	$16, %esp
	cmpl	%eax, %ebx
	jne	.L70
	subl	$12, %esp
	pushl	$.LC21
	call	puts
	movl	-156(%ebp), %eax
	pxor	%xmm4, %xmm4
	addl	$16, %esp
	movl	$100, -200(%ebp)
	movl	$0, -188(%ebp)
	addl	$614400, %eax
	movl	%eax, -168(%ebp)
	movl	-160(%ebp), %eax
	addl	$1228800, %eax
	movl	%eax, -152(%ebp)
	movl	-164(%ebp), %eax
	addl	$1228800, %eax
	movl	%eax, -192(%ebp)
.L88:
	subl	$12, %esp
	pushl	$0
	movaps	%xmm4, -104(%ebp)
	call	time
	movl	%eax, (%esp)
	call	srand
	movl	-156(%ebp), %esi
	movl	-168(%ebp), %edi
	addl	$16, %esp
	movdqa	-104(%ebp), %xmm4
	.p2align 4,,10
	.p2align 3
.L71:
	leal	1280(%esi), %ebx
	.p2align 4,,10
	.p2align 3
.L72:
	movaps	%xmm4, -104(%ebp)
	call	rand
	cltd
	addl	$1, %esi
	shrl	$24, %edx
	addl	%edx, %eax
	movdqa	-104(%ebp), %xmm4
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%esi)
	cmpl	%esi, %ebx
	jne	.L72
	cmpl	%edi, %ebx
	movl	%ebx, %esi
	jne	.L71
	movl	-160(%ebp), %eax
	movl	$0, -104(%ebp)
	xorl	%esi, %esi
	movl	%eax, -148(%ebp)
	movl	-156(%ebp), %eax
	movl	%eax, -144(%ebp)
	.p2align 4,,10
	.p2align 3
.L73:
	xorl	%ebx, %ebx
	movl	-148(%ebp), %edi
	jmp	.L81
	.p2align 4,,10
	.p2align 3
.L161:
	testl	%ecx, %ecx
	jns	.L156
	movb	$0, -88(%ebp)
	movb	$0, -136(%ebp)
.L76:
	imull	$-775, -104(%ebp), %edx
	imull	$4826, %eax, %ecx
	addl	%edx, %ecx
	imull	$-2670, %esi, %edx
	addl	%edx, %ecx
	movl	%ecx, %edx
	sarl	$10, %edx
	cmpl	$1023, %edx
	jg	.L121
	testl	%edx, %edx
	jns	.L157
	xorl	%ecx, %ecx
	movb	$0, -140(%ebp)
.L78:
	imull	$2389, %eax, %eax
	addl	-104(%ebp), %eax
	imull	$6931, %esi, %edx
	leal	(%edx,%eax,2), %eax
	movl	%eax, %edx
	sarl	$10, %eax
	cmpl	$1023, %eax
	jg	.L123
	testl	%eax, %eax
	jns	.L158
	xorl	%edx, %edx
	movl	$3, %eax
.L80:
	movb	%al, (%edi,%ebx,4)
	movl	%edx, %eax
	movzbl	-140(%ebp), %edx
	orb	-136(%ebp), %cl
	orl	%eax, %edx
	movzbl	-88(%ebp), %eax
	movb	%dl, 1(%edi,%ebx,4)
	movb	%cl, 2(%edi,%ebx,4)
	movb	%al, 3(%edi,%ebx,4)
	addl	$1, %ebx
	cmpl	$640, %ebx
	je	.L159
.L81:
	movl	-144(%ebp), %eax
	movl	%ebx, %edx
	andl	$-2, %edx
	movzbl	(%eax,%ebx,2), %eax
	subl	$16, %eax
	cmpl	%edx, %ebx
	je	.L160
.L74:
	imull	$8809, -104(%ebp), %edx
	imull	$4768, %eax, %ecx
	addl	%ecx, %edx
	leal	(%esi,%esi,4), %ecx
	leal	(%esi,%ecx,2), %ecx
	addl	%ecx, %edx
	movl	%edx, %ecx
	sarl	$10, %ecx
	cmpl	$1023, %ecx
	jle	.L161
	movb	$-1, -88(%ebp)
	movb	$-64, -136(%ebp)
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L123:
	movl	$15, %edx
	movl	$-1, %eax
	jmp	.L80
	.p2align 4,,10
	.p2align 3
.L121:
	movl	$63, %ecx
	movb	$-16, -140(%ebp)
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L160:
	movl	-144(%ebp), %esi
	movzbl	1(%esi,%ebx,2), %edx
	movzbl	3(%esi,%ebx,2), %esi
	leal	-128(%edx), %ecx
	addl	$-128, %esi
	movl	%ecx, -104(%ebp)
	jmp	.L74
	.p2align 4,,10
	.p2align 3
.L156:
	sall	$6, %ecx
	shrl	$12, %edx
	movb	%cl, -136(%ebp)
	movl	%edx, -88(%ebp)
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L157:
	sall	$4, %edx
	shrl	$14, %ecx
	movb	%dl, -140(%ebp)
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L158:
	leal	3(,%eax,4), %eax
	shrl	$16, %edx
	jmp	.L80
	.p2align 4,,10
	.p2align 3
.L159:
	addl	$2560, -148(%ebp)
	addl	$1280, -144(%ebp)
	movl	-148(%ebp), %eax
	cmpl	-152(%ebp), %eax
	jne	.L73
	movl	-164(%ebp), %eax
	movl	-156(%ebp), %ebx
	movl	-192(%ebp), %esi
	movdqa	-184(%ebp), %xmm7
	.p2align 4,,10
	.p2align 3
.L82:
	pxor	%xmm6, %xmm6
	leal	2560(%eax), %ecx
	movl	%ebx, %edx
	.p2align 4,,10
	.p2align 3
.L83:
	movq	(%edx), %xmm0
	addl	$16, %eax
	addl	$8, %edx
	movdqa	-120(%ebp), %xmm1
	pand	%xmm0, %xmm1
	movdqa	.LC0, %xmm2
	psrld	$8, %xmm1
	pand	%xmm0, %xmm2
	movdqa	%xmm1, %xmm3
	pand	%xmm7, %xmm0
	pslld	$16, %xmm3
	por	%xmm3, %xmm1
	psubw	.LC1, %xmm2
	psrld	$24, %xmm0
	movdqa	%xmm0, %xmm3
	punpcklwd	%xmm4, %xmm2
	pslld	$16, %xmm3
	psubw	.LC2, %xmm1
	por	%xmm3, %xmm0
	punpcklwd	%xmm4, %xmm1
	pslld	$16, %xmm2
	movdqa	.LC5, %xmm3
	psubw	.LC2, %xmm0
	punpcklwd	%xmm4, %xmm0
	por	%xmm2, %xmm1
	movdqa	%xmm0, %xmm2
	movdqa	%xmm1, %xmm5
	pmaddwd	.LC4, %xmm2
	pmaddwd	.LC3, %xmm5
	paddd	%xmm5, %xmm2
	psrad	$10, %xmm2
	pcmpgtd	%xmm2, %xmm3
	pand	%xmm3, %xmm2
	pandn	.LC6, %xmm3
	por	%xmm3, %xmm2
	movdqa	%xmm1, %xmm3
	pmaddwd	.LC10, %xmm1
	movdqa	%xmm2, %xmm5
	pmaddwd	.LC8, %xmm3
	pcmpgtd	%xmm6, %xmm5
	pand	%xmm5, %xmm2
	movdqa	%xmm2, %xmm5
	movdqa	%xmm0, %xmm2
	pmaddwd	.LC11, %xmm0
	paddd	%xmm1, %xmm0
	movdqa	.LC5, %xmm1
	psrad	$10, %xmm0
	pslld	$2, %xmm5
	pmaddwd	.LC9, %xmm2
	paddd	%xmm3, %xmm2
	psrad	$10, %xmm2
	movdqa	.LC5, %xmm3
	pcmpgtd	%xmm0, %xmm1
	por	.LC7, %xmm5
	pcmpgtd	%xmm2, %xmm3
	pand	%xmm1, %xmm0
	pand	%xmm3, %xmm2
	pandn	.LC6, %xmm3
	pandn	.LC6, %xmm1
	por	%xmm3, %xmm2
	por	%xmm1, %xmm0
	movdqa	%xmm2, %xmm3
	pcmpgtd	%xmm6, %xmm3
	pand	%xmm3, %xmm2
	pslld	$12, %xmm2
	por	%xmm2, %xmm5
	movdqa	%xmm0, %xmm2
	pcmpgtd	%xmm6, %xmm2
	pand	%xmm2, %xmm0
	pslld	$22, %xmm0
	por	%xmm0, %xmm5
	movups	%xmm5, -16(%eax)
	cmpl	%eax, %ecx
	jne	.L83
	addl	$1280, %ebx
	cmpl	%esi, %ecx
	movl	%ecx, %eax
	jne	.L82
	movl	-160(%ebp), %ecx
	movl	-164(%ebp), %edx
	xorl	%ebx, %ebx
.L84:
	xorl	%eax, %eax
	movl	%ebx, %edi
	.p2align 4,,10
	.p2align 3
.L87:
	movzbl	(%edx,%eax), %ebx
	cmpb	%bl, (%ecx,%eax)
	jne	.L162
	addl	$1, %eax
	cmpl	$2560, %eax
	jne	.L87
	movl	%edi, %ebx
	addl	$2560, %ecx
	addl	$2560, %edx
	addl	$1, %ebx
	cmpl	$480, %ebx
	jne	.L84
	subl	$1, -200(%ebp)
	jne	.L88
.L172:
	subl	$4, %esp
	pushl	-188(%ebp)
	pushl	$.LC22
	pushl	$1
	call	__printf_chk
	movl	$.LC23, (%esp)
	call	puts
	addl	$16, %esp
	movl	$100, -204(%ebp)
	movl	$0, -200(%ebp)
	movl	$0, -196(%ebp)
.L102:
	subl	$12, %esp
	pushl	$0
	call	time
	movl	%eax, (%esp)
	call	srand
	movl	-156(%ebp), %esi
	movl	-168(%ebp), %edi
	addl	$16, %esp
	.p2align 4,,10
	.p2align 3
.L89:
	leal	1280(%esi), %ebx
	.p2align 4,,10
	.p2align 3
.L90:
	call	rand
	cltd
	addl	$1, %esi
	shrl	$24, %edx
	addl	%edx, %eax
	movzbl	%al, %eax
	subl	%edx, %eax
	movb	%al, -1(%esi)
	cmpl	%esi, %ebx
	jne	.L90
	cmpl	%edi, %ebx
	movl	%ebx, %esi
	jne	.L89
	call	clock
	movl	%eax, -188(%ebp)
	movl	-160(%ebp), %eax
	xorl	%esi, %esi
	movl	$0, -104(%ebp)
	movl	%eax, -148(%ebp)
	movl	-156(%ebp), %eax
	movl	%eax, -144(%ebp)
	.p2align 4,,10
	.p2align 3
.L92:
	xorl	%ebx, %ebx
	movl	-148(%ebp), %edi
	jmp	.L100
	.p2align 4,,10
	.p2align 3
.L168:
	testl	%ecx, %ecx
	jns	.L163
	movb	$0, -88(%ebp)
	movb	$0, -136(%ebp)
.L95:
	imull	$-775, -104(%ebp), %edx
	imull	$4826, %eax, %ecx
	addl	%edx, %ecx
	imull	$-2670, %esi, %edx
	addl	%edx, %ecx
	movl	%ecx, %edx
	sarl	$10, %edx
	cmpl	$1023, %edx
	jg	.L127
	testl	%edx, %edx
	jns	.L164
	xorl	%ecx, %ecx
	movb	$0, -140(%ebp)
.L97:
	imull	$2389, %eax, %eax
	addl	-104(%ebp), %eax
	imull	$6931, %esi, %edx
	leal	(%edx,%eax,2), %eax
	movl	%eax, %edx
	sarl	$10, %eax
	cmpl	$1023, %eax
	jg	.L129
	testl	%eax, %eax
	jns	.L165
	xorl	%edx, %edx
	movl	$3, %eax
.L99:
	movb	%al, (%edi,%ebx,4)
	movl	%edx, %eax
	movzbl	-140(%ebp), %edx
	orb	-136(%ebp), %cl
	orl	%eax, %edx
	movzbl	-88(%ebp), %eax
	movb	%dl, 1(%edi,%ebx,4)
	movb	%cl, 2(%edi,%ebx,4)
	movb	%al, 3(%edi,%ebx,4)
	addl	$1, %ebx
	cmpl	$640, %ebx
	je	.L166
.L100:
	movl	-144(%ebp), %eax
	movl	%ebx, %edx
	andl	$-2, %edx
	movzbl	(%eax,%ebx,2), %eax
	subl	$16, %eax
	cmpl	%edx, %ebx
	je	.L167
.L93:
	imull	$8809, -104(%ebp), %edx
	imull	$4768, %eax, %ecx
	addl	%ecx, %edx
	leal	(%esi,%esi,4), %ecx
	leal	(%esi,%ecx,2), %ecx
	addl	%ecx, %edx
	movl	%edx, %ecx
	sarl	$10, %ecx
	cmpl	$1023, %ecx
	jle	.L168
	movb	$-1, -88(%ebp)
	movb	$-64, -136(%ebp)
	jmp	.L95
	.p2align 4,,10
	.p2align 3
.L129:
	movl	$15, %edx
	movl	$-1, %eax
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L127:
	movl	$63, %ecx
	movb	$-16, -140(%ebp)
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L167:
	movl	-144(%ebp), %esi
	movzbl	1(%esi,%ebx,2), %edx
	movzbl	3(%esi,%ebx,2), %esi
	leal	-128(%edx), %ecx
	addl	$-128, %esi
	movl	%ecx, -104(%ebp)
	jmp	.L93
	.p2align 4,,10
	.p2align 3
.L164:
	sall	$4, %edx
	shrl	$14, %ecx
	movb	%dl, -140(%ebp)
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L163:
	sall	$6, %ecx
	shrl	$12, %edx
	movb	%cl, -136(%ebp)
	movl	%edx, -88(%ebp)
	jmp	.L95
	.p2align 4,,10
	.p2align 3
.L165:
	leal	3(,%eax,4), %eax
	shrl	$16, %edx
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L166:
	addl	$2560, -148(%ebp)
	addl	$1280, -144(%ebp)
	movl	-148(%ebp), %eax
	cmpl	%eax, -152(%ebp)
	jne	.L92
	call	clock
	subl	-188(%ebp), %eax
	cltd
	addl	%eax, -200(%ebp)
	adcl	%edx, -196(%ebp)
	subl	$1, -204(%ebp)
	jne	.L102
	pushl	-196(%ebp)
	pushl	-200(%ebp)
	pushl	$.LC24
	pushl	$1
	call	__printf_chk
	movl	$.LC25, (%esp)
	call	puts
	pxor	%xmm3, %xmm3
	movl	-168(%ebp), %ebx
	movl	-192(%ebp), %esi
	xorl	%eax, %eax
	xorl	%edx, %edx
	addl	$16, %esp
	movl	$100, -140(%ebp)
	movl	%eax, -88(%ebp)
	movl	%edx, -84(%ebp)
.L109:
	subl	$12, %esp
	pushl	$0
	movaps	%xmm3, -104(%ebp)
	call	time
	movl	%eax, (%esp)
	call	srand
	movl	-156(%ebp), %eax
	addl	$16, %esp
	movdqa	-104(%ebp), %xmm3
	.p2align 4,,10
	.p2align 3
.L103:
	leal	1280(%eax), %edi
	movl	%eax, -104(%ebp)
	.p2align 4,,10
	.p2align 3
.L104:
	movaps	%xmm3, -136(%ebp)
	call	rand
	cltd
	shrl	$24, %edx
	movl	-104(%ebp), %ecx
	addl	%edx, %eax
	movzbl	%al, %eax
	movdqa	-136(%ebp), %xmm3
	subl	%edx, %eax
	movb	%al, (%ecx)
	addl	$1, %ecx
	cmpl	%ecx, %edi
	movl	%ecx, -104(%ebp)
	jne	.L104
	cmpl	%ebx, %edi
	movl	%edi, %eax
	jne	.L103
	movaps	%xmm3, -104(%ebp)
	call	clock
	movl	%eax, %ecx
	movl	%ecx, %edx
	movl	-164(%ebp), %eax
	movl	-156(%ebp), %edi
	movdqa	-184(%ebp), %xmm7
	movdqa	-104(%ebp), %xmm3
	.p2align 4,,10
	.p2align 3
.L106:
	pxor	%xmm6, %xmm6
	leal	2560(%eax), %ecx
	movl	%edx, -136(%ebp)
	movl	%edi, -104(%ebp)
	movl	%edi, %edx
	.p2align 4,,10
	.p2align 3
.L107:
	movq	(%edx), %xmm0
	addl	$16, %eax
	addl	$8, %edx
	movdqa	-120(%ebp), %xmm1
	pand	%xmm0, %xmm1
	movdqa	.LC0, %xmm2
	psrld	$8, %xmm1
	pand	%xmm0, %xmm2
	movdqa	%xmm1, %xmm4
	pand	%xmm7, %xmm0
	pslld	$16, %xmm4
	por	%xmm4, %xmm1
	psubw	.LC1, %xmm2
	psrld	$24, %xmm0
	movdqa	%xmm0, %xmm4
	punpcklwd	%xmm3, %xmm2
	pslld	$16, %xmm4
	psubw	.LC2, %xmm1
	por	%xmm4, %xmm0
	punpcklwd	%xmm3, %xmm1
	pslld	$16, %xmm2
	movdqa	.LC5, %xmm4
	psubw	.LC2, %xmm0
	punpcklwd	%xmm3, %xmm0
	por	%xmm2, %xmm1
	movdqa	%xmm0, %xmm2
	movdqa	%xmm1, %xmm5
	pmaddwd	.LC4, %xmm2
	pmaddwd	.LC3, %xmm5
	paddd	%xmm5, %xmm2
	psrad	$10, %xmm2
	pcmpgtd	%xmm2, %xmm4
	pand	%xmm4, %xmm2
	pandn	.LC6, %xmm4
	por	%xmm4, %xmm2
	movdqa	%xmm1, %xmm4
	pmaddwd	.LC10, %xmm1
	movdqa	%xmm2, %xmm5
	pmaddwd	.LC8, %xmm4
	pcmpgtd	%xmm6, %xmm5
	pand	%xmm5, %xmm2
	movdqa	%xmm2, %xmm5
	movdqa	%xmm0, %xmm2
	pmaddwd	.LC11, %xmm0
	paddd	%xmm1, %xmm0
	movdqa	.LC5, %xmm1
	psrad	$10, %xmm0
	pslld	$2, %xmm5
	pmaddwd	.LC9, %xmm2
	paddd	%xmm4, %xmm2
	psrad	$10, %xmm2
	movdqa	.LC5, %xmm4
	pcmpgtd	%xmm0, %xmm1
	por	.LC7, %xmm5
	pcmpgtd	%xmm2, %xmm4
	pand	%xmm1, %xmm0
	pand	%xmm4, %xmm2
	pandn	.LC6, %xmm4
	pandn	.LC6, %xmm1
	por	%xmm4, %xmm2
	por	%xmm1, %xmm0
	movdqa	%xmm2, %xmm4
	pcmpgtd	%xmm6, %xmm4
	pand	%xmm4, %xmm2
	pslld	$12, %xmm2
	por	%xmm2, %xmm5
	movdqa	%xmm0, %xmm2
	pcmpgtd	%xmm6, %xmm2
	pand	%xmm2, %xmm0
	pslld	$22, %xmm0
	por	%xmm0, %xmm5
	movups	%xmm5, -16(%eax)
	cmpl	%eax, %ecx
	jne	.L107
	movl	-136(%ebp), %eax
	addl	$1280, %edi
	cmpl	%esi, %ecx
	movl	%eax, %edx
	movl	%ecx, %eax
	jne	.L106
	movl	%edx, %edi
	movaps	%xmm3, -104(%ebp)
	call	clock
	subl	%edi, %eax
	cltd
	addl	%eax, -88(%ebp)
	adcl	%edx, -84(%ebp)
	subl	$1, -140(%ebp)
	movdqa	-104(%ebp), %xmm3
	jne	.L109
	movl	-84(%ebp), %edx
	movl	-88(%ebp), %eax
	pushl	%edx
	pushl	%eax
	movl	%edx, %edi
	pushl	$.LC24
	pushl	$1
	movl	%eax, %esi
	call	__printf_chk
	popl	%eax
	pushl	-156(%ebp)
	call	free
	movl	-196(%ebp), %edx
	movl	-200(%ebp), %eax
	movl	%edx, -100(%ebp)
	movl	%eax, -104(%ebp)
	testl	%edx, %edx
	fildq	-104(%ebp)
	js	.L169
.L110:
	movl	%esi, -104(%ebp)
	movl	%edi, -100(%ebp)
	testl	%edi, %edi
	fstpl	-80(%ebp)
	fldl	-80(%ebp)
	fildq	-104(%ebp)
	js	.L170
.L111:
	subl	$8, %esp
	fstpl	-80(%ebp)
	fldl	-80(%ebp)
	fdivrp	%st, %st(1)
	fstpl	-80(%ebp)
	fldl	-80(%ebp)
	fstpl	(%esp)
	pushl	$.LC27
	pushl	$1
	call	__printf_chk
	addl	$32, %esp
	xorl	%eax, %eax
	movl	-28(%ebp), %edi
	xorl	%gs:20, %edi
	jne	.L171
	leal	-12(%ebp), %esp
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
.L162:
	.cfi_restore_state
	pushl	%eax
	pushl	%edi
	pushl	$.LC15
	pushl	$1
	movaps	%xmm4, -104(%ebp)
	call	__printf_chk
	addl	$16, %esp
	addl	$1, -188(%ebp)
	subl	$1, -200(%ebp)
	movdqa	-104(%ebp), %xmm4
	jne	.L88
	jmp	.L172
.L171:
	call	__stack_chk_fail
.L170:
	fadds	.LC26
	jmp	.L111
.L169:
	fadds	.LC26
	jmp	.L110
	.cfi_endproc
.LFE541:
	.size	test, .-test
	.section	.text.unlikely
.LCOLDE29:
	.text
.LHOTE29:
	.section	.rodata.str1.1
.LC30:
	.string	"rb"
.LC31:
	.string	"Error of reading"
.LC32:
	.string	"wb"
.LC33:
	.string	"out.rgb"
	.section	.text.unlikely
.LCOLDB34:
	.text
.LHOTB34:
	.p2align 4,,15
	.globl	fileProcess
	.type	fileProcess, @function
fileProcess:
.LFB542:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$36, %esp
	.cfi_def_cfa_offset 56
	movl	56(%esp), %eax
	movl	60(%esp), %esi
	movl	%eax, 12(%esp)
	pushl	$.LC30
	.cfi_def_cfa_offset 60
	pushl	68(%esp)
	.cfi_def_cfa_offset 64
	call	fopen
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	movl	%eax, %ebx
	je	.L176
	movl	4(%esp), %edi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	imull	%esi, %edi
	leal	(%edi,%edi), %ecx
	pushl	%ecx
	.cfi_def_cfa_offset 64
	movl	%ecx, 28(%esp)
	call	malloc
	leal	0(,%edi,4), %edx
	movl	%eax, %ebp
	movl	%edx, (%esp)
	movl	%edx, 24(%esp)
	call	malloc
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	32(%esp), %ecx
	movl	%eax, %edi
	pushl	%ecx
	.cfi_def_cfa_offset 72
	pushl	$1
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	fread
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	%ebx
	.cfi_def_cfa_offset 64
	call	fclose
	pushl	%esi
	.cfi_def_cfa_offset 68
	pushl	24(%esp)
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	process_vector
	addl	$24, %esp
	.cfi_def_cfa_offset 56
	pushl	$.LC32
	.cfi_def_cfa_offset 60
	pushl	$.LC33
	.cfi_def_cfa_offset 64
	call	fopen
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	28(%esp), %edx
	movl	%eax, %esi
	pushl	%edx
	.cfi_def_cfa_offset 72
	pushl	$1
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	fwrite
	movl	%esi, 80(%esp)
	addl	$60, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	jmp	fclose
	.p2align 4,,10
	.p2align 3
.L176:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -20
	.cfi_offset 5, -8
	.cfi_offset 6, -16
	.cfi_offset 7, -12
	movl	$.LC31, 48(%esp)
	addl	$28, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	jmp	puts
	.cfi_endproc
.LFE542:
	.size	fileProcess, .-fileProcess
	.section	.text.unlikely
.LCOLDE34:
	.text
.LHOTE34:
	.section	.rodata.str1.1
.LC35:
	.string	"out.yuv"
	.section	.text.unlikely
.LCOLDB36:
	.section	.text.startup,"ax",@progbits
.LHOTB36:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB543:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$4, %esp
	call	test
	subl	$4, %esp
	pushl	$.LC35
	pushl	$144
	pushl	$176
	call	fileProcess
	movl	-4(%ebp), %ecx
	.cfi_def_cfa 1, 0
	addl	$16, %esp
	xorl	%eax, %eax
	leave
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE543:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE36:
	.section	.text.startup
.LHOTE36:
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	16711935
	.long	16711935
	.long	16711935
	.long	16711935
	.align 16
.LC1:
	.value	16
	.value	16
	.value	16
	.value	16
	.value	16
	.value	16
	.value	16
	.value	16
	.align 16
.LC2:
	.value	128
	.value	128
	.value	128
	.value	128
	.value	128
	.value	128
	.value	128
	.value	128
	.align 16
.LC3:
	.value	2
	.value	4778
	.value	2
	.value	4778
	.value	2
	.value	4778
	.value	2
	.value	4778
	.align 16
.LC4:
	.value	6931
	.value	6931
	.value	6931
	.value	6931
	.value	6931
	.value	6931
	.value	6931
	.value	6931
	.align 16
.LC5:
	.long	1023
	.long	1023
	.long	1023
	.long	1023
	.align 16
.LC6:
	.long	1023
	.long	1023
	.long	1023
	.long	1023
	.align 16
.LC7:
	.long	3
	.long	3
	.long	3
	.long	3
	.align 16
.LC8:
	.value	-775
	.value	4826
	.value	-775
	.value	4826
	.value	-775
	.value	4826
	.value	-775
	.value	4826
	.align 16
.LC9:
	.value	-2670
	.value	-2670
	.value	-2670
	.value	-2670
	.value	-2670
	.value	-2670
	.value	-2670
	.value	-2670
	.align 16
.LC10:
	.value	8809
	.value	4768
	.value	8809
	.value	4768
	.value	8809
	.value	4768
	.value	8809
	.value	4768
	.align 16
.LC11:
	.value	11
	.value	11
	.value	11
	.value	11
	.value	11
	.value	11
	.value	11
	.value	11
	.align 16
.LC12:
	.long	16711935
	.long	16711935
	.long	16711935
	.long	16711935
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC26:
	.long	1602224128
	.ident	"GCC: (Ubuntu 4.9.2-10ubuntu13) 4.9.2"
	.section	.note.GNU-stack,"",@progbits

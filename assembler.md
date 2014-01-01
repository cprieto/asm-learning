# Assembler for Real Men (or really pretty women) - Lesson 1, introduction and basic stuff

_What would I need?_

 * Linux, later we will go in Assembler for Windows.
 * A sane developer tool chain (you know, gcc, gdb, make, all that stuff).
 * An Assembler for Linux, NASM is what you need pal.
 * A good editor, Vim, Kate, GEdit, whatever, it will do.
 * You need to know the differences between decimal, binary and hexadecimal numbering systems.
 * You should know how to convert from decimal to binary to hexadecimal. With the term "_know_" I include the knowledge of googling about how to do it or knowing how to use your calculator to do the conversion.
 
_Would I become a super human after all of this?_

No, but you will probably be able to ride a pony-sized unicorn.

_Would I need a computer for this?_

Yes, and please, use a x86/x64 like computer, don't try this in your Texas Instrument calculator.

## Basics

 * Computers are like men, they only know zeroes and one's. Because even a zero consumes space, this space is named **bit**
 * Because counting in individual bits is kind of boring, we group them in units of 8, yes, because grouping in units of 10 is mainstream. A group of 8 bits is named **byte**

## The 8088/8086
This, my friends, is a very old CPU. It is like the grand grand father of your current modern super fast processor, but in the same way that now you use really tight jeans and your grand parent used just normal straight cut pants, well, this CPU was very different. It was basically an **16bit** CPU. It means that every register had a length of 16bit (or well, 2 bytes). Another important characteristic is that you have a limit of **1MB of unprotected memory**, and in the same way as sex, unprotected memory could be your doom. Every process can access the memory of another process and there was no way to stop it. Another interesting thing, that 1MB of memory was not _continous_ and it has to be _segmented_ in fragments of 64KB.

This CPU provides _4 general purpose 16bit registers: AX, BX, CX, DX_
Those general purpose registers can be divided in two 8bit registers, so AX can be divided in AH and AL, BX in BH and BL, and so on. AH will contain the higher 8 bits of AX and AL the lower 8 bits. Setting AX will basically change both AH and AL and changing any of both will change AX. Simple! What would you put in those registers? well, they are _general purpose_ so as long as it fit, you can put whatever you want.

We have as well _2 16bit index registers_ SI and DI. They cannot be decomposed in two 8bit registers as the general purpose registers. Wait, but what are they used for? well, theorically they are used as storage for _pointers_ but nothing stops you from using them like general purpose registers.

Now, we have two very special _16bit registers, BP and SP_. They are used to point to stack data, yes, machine code stack data. They are very special. Their names come from _"Base Pointer and Stack Pointer"_. We will mention them later.

Now, we need to mention another 4 16 bit registers. _CS, DS, SS and ES_ they are used to point to _point to segmented memory addresses_. CS is the **Code Segment**, DS is the **Data Segment**, SS stands for the **Stack Segment**, ES contains the **Extra Segment** that is basically just temporary data that probably you will use/need. These registers are the heart of the 64KB segmented memory model in the 8088/8086 Intel CPU. The idea is simple, you store the data, code and stack in different segments so you need to contain the base address for those segments in registers just to know where to get or put the stuff.

Another important register is _IP or Instruction Pointer_ which is used together with the CS register to keep track of which one is the next instruction to execute.

_FLAGS_ is the last register, it stores information of the returning status of the previous operation but not all the instructions uses the FLAGS register.

So, in general:

 * General Purpose: AX, BX, CX, DX
 * Index: SI, DI
 * Stack Registers: BP, SP
 * Segmented Memory Registers: CS, DS, SS, ES
 * Instruction Pointer: IP
 * Return Status: FLAGS

## The 80286

This processor add two important things:

 * A protected mode, now in this mode, a process cannot modify or access the memory of another process.
 * 32bit registers.

The memory model still segmented.
We have now 32 bit general purpose registers. Now AX became EAX, BX is EBX, CX is ECX and DX became EDX. You can continue using the 16bit registers but you will access the 16bit lower part (in the same way you were using AL) but not to the upper part. We have 32 bit index registers as well: ESI and EDI. We have extended versions of the other registers (EBP, ESP, EFLAGS, EBP and ESP) but they only exist in protected mode. There were two additional segment registers (GS and FS) and they work the same as ES (so they don't have any special function, they just lay there waiting for somebody to use them).

Ok, something important is the use of _word_, it describes the size of a register. In the original 8088/8086 it was 16bit wide but in 80286 it is 32bit but Intel decided to use the same meaning, weird thing.


## Operations, decreasing
This is kind of easy, decreasing a number we just truncate the bits we don't want, for example:
```
mov ax, 0034h  ; put 52 in 16bit AX
mov cl, al     ; Truncate the first 8 bits and put into CL
```

## Operations, increasing
For unsigned numbers in 16bit registers is easy, just fill it with zeroes:
```
mov ah, 0      ; put 00 into upper part of ax
```
For unsigned numbers in 32bit registers is a little more tricky, because there is no way to access the upper 16bit of a 32bit register. So we have **MOVZX** and for 80286 the equivalent is **MOVSX**
```
movzx eax, ax  ; extend value in AX and put into EAX
movzx ebx, ah  ; extend value in AH and put into EBX
movzx ax, bl   ; extend value in BL and put into AX
```

Now, _for signed numbers_ the thing is not that simple. So we have specific instructions used with implicit registers. For 8086/8088 we have: **CBW** and **CWD**
```
cbw            ; convert AL into AX
cwd            ; convert AX into DX:AX
```
For our newer friends with 32bit registers we have: **CWDE** and **CWQ**
```
cwde           ; convert AX into EAX
cwq            ; convert EAX into EDX:EAX
```
## Operations, multiplication
We have two friends here, **MUL** and **IMUL**, the first for unsigned numbers and the second for signed numbers:
```
mul el      ; multiply EL by AL and put result in AX
mul bx      ; multiply BX by AX and put result in DX:AX

```
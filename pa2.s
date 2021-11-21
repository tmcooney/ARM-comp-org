.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x^y = %d\n"

.section .text

.global main

main:

    #prompt user for x
    ldr x0, =input_x_prompt
    bl printf
    

    #set up stack pointer to hold x
    sub sp, sp, 8
    #get x from user input
    ldr x0, =input_spec
    mov x1, sp
    bl scanf

    # store x in X19
    ldrsw X19, [sp]

    #prompt user for y
    ldr x0, =input_y_prompt
    bl printf

    # set the stack pointer to hold y
    sub sp, sp, 8
    # get y from user input
    ldr x0, =input_spec
    mov x1, sp
    bl scanf

    # store y in x20
    ldrsw x20, [sp]


    bl power
    

    b exit
# power function
power:
    
    #if x is not zero
    cbnz x0, elseIf

    # if y == 0 return 1
    cbz x1, yIsZero

    # if y is less than zero
    subs xzr, x1, xzr
    b.lt yIsNegative
    # base case: if x==0 return zero
    cbz x0, xIsZero
    ret

#else if y < 0
elseIf:
    subs xzr, x1, xzr
    b.ge elseIfIf
# else if y is not 0
elseIfIf:
    cbnz x1, exponent_recurse
    
    
# if y < 0
yIsNegative:
    add x2, xzr, xzr
    add x2, x2, #1
    ret
#if y==0
yIsZero:
    mov x2, x1
    ret
#if x==0
xIsZero:
    mov x2, x0
    ret


# recursion function
exponent_recurse:
    #do stuff and things here

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret

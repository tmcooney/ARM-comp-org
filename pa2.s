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
    
    mov x0, x19
    mov x1, x20

    bl power
    
    ldr x0, =result
    mov x1, x2
    bl printf

    add sp, sp, #16

    b exit

# power function
power:
    
    #checks conditions then recurses if appropriate
    cbnz x0, elseIf

    # if y == 0 return 1
    cbz x1, yIsZero
    ret

    # if y is less than zero
    subs xzr, x1, xzr
    b.lt yIsNegative
    ret

    # base case: if x==0 return zero
    cbz x0, xIsZero
    br x30
#else if y > 0
elseIf:
    subs x9, x1, xzr
    b.gt exponent_recurse
    ret
    
# if y < 0
yIsNegative:
    add x2, xzr, xzr
    ret

#if y==0
yIsZero:
    add x2, xzr, xzr
    add x2, x2, #1
    ret

#if x==0
xIsZero:
    mov x2, x0
    ret


# recursion function
exponent_recurse:
    #set up the stack for the return register.
    sub sp, sp, 8
    str x30, [sp]

    #set up the stack to store x0 and x1 (add args)
    sub sp, sp, 8
    str x0, [sp]
    sub sp, sp, 8
    str x1, [sp]

    #recursively call the add function with arguments x and y-1
    sub x1, x1, #1
    bl power

    #return from recursive call adn restore stack
    ldr x1, [sp]
    ldr x0, [sp, 8]
    ldr x30, [sp, 16]
    add sp, sp, 24

    # value to be returned is x * power(x, y - 1)
    mul x2, x2, x0
    br x30

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret

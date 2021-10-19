.section .data

input_prompt    :   .asciz  "Input a string: "
input_spec      :   .asciz  "%s[^\n]"
length_spec     :   .asciz  "String length: %d\n"
palindrome_spec :   .asciz  "String is a palindrome (T/F): %c\n"
input_format	:   .asciz  "%s"
input           :   .space   8

.section .text

.global main

# program execution begins here
main:
	#load x0 with string and prompt for user input
	ldr x0, =input_prompt
	bl printf

	#load format specifier and input to scan for input
	ldr x0, =input_spec
	ldr x1, =input
	bl scanf
    
    #store address string in x9 (s[])
    LDR x9, =input
    
    #initialize size to zero and store in x19 (i = 0)
    ADD x19, XZR, XZR

    # while loop to get string length
    L1: # add i to s[]
        ADD x11, x9, x19

        #load the character in y[i] to x12
        ldrb w12, [x11,#0]

        # i = i + 1;
        ADD X19, X19, #1

        #if s[i] != 0 then go to L1
        CBNZ w12, L1
    #prints out the length which is stored in x19
    ldr X0, =length_spec
    SUB X19, X19, #1
    MOV X1, x19
    BL printf

    #puts 1/2 the length of s into x10
    LSR X10, X19, #1

    
    #for loop to check for palindrome
    L2: # for i (x9) = 0
        ADD x9, XZR, XZR
        # i < 1/2 length of s

	b exit

# add code and other labels here

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

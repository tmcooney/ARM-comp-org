.section .data

input_prompt    :   .asciz  "Input a string: "
input_spec      :   .asciz  "%s[^\n]"
length_spec     :   .asciz  "String length: %d\n"
palindrome_spec :   .asciz  "String is a palindrome (T/F): %c\n"
input_format	:   .asciz  "%s"
input           :   .space  8
truth           :   .asciz  "T"
falsification   :   .asciz  "F"

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

    # put input string s address in x9
    LDR x9, =input
    #puts 1/2 the length of s into x10
    LSR X10, X19, #1

    # for i (x11) = 0
    ADD x11, XZR, XZR
    #for loop to check for palindrome
    L2:
        # i (x11) < 1/2 length of s (x10). if this is false it must be palindrome
        #SUBS XZR, X11, X10
        #B.GT True

        #put s[i] (s[] + i) address into x12
        ADD x12, x9, x11
        # load the character in s[i] to x13
        LDRB w13, [x12,#0]

        # put address for s length - 1 in x12
        SUB x12, x19, #1
        # put address for s length - 1 - i in x12
        SUB x12, x12, x11
        # s[] plus [length - 1 - i]
        ADD x12, x12, x9
        # put s[length - 1 - i] character in x14
        LDRB w14, [x12,#0]
        # compare char in first half of string to its counterpart in 2nd half
        SUB x15, x13, x14
        CBNZ x15, False

        SUB x15, x11, x10
        CBZ x15, True

        add x11, x11, #1
        b L2
        

    True:
        ldr x0, =palindrome_spec
        MOV x1, #84
        BL printf
        b exit
    False:
        ldr x0, =palindrome_spec
        MOV x1, #70
        BL printf
        b exit

	#b exit

# add code and other labels here

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

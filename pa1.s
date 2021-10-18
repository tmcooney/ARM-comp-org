.section .data

input_prompt    :   .asciz  "Input a string: "
input_spec      :   .asciz  "%[^\n]"
length_spec     :   .asciz  "String length: %d\n"
palindrome_spec :   .asciz  "String is a palindrome (T/F): %c\n"
input_format	:   .asciz  "%s"
input_string	:   .size   8

.section .text

.global main

# program execution begins here
main:
	#load x0 with string and prompt for user input
	ldr x0, =input_prompt
	bl printf

	#load format specifier and input to scan for input
	ldr x0, =input_format
	ldr x1, =input_string
	bl scanf

	ldr x0, =input_string
	
	bl printf

	b exit

# add code and other labels here

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

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

    b exit

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret

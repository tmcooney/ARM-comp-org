.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x^y = %d\n"

.section .text

.global main

main:

# add code and other labels here

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret
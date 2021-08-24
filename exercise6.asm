# Calculate (a+b)/c - (d-e)

.data
	a : .word 0
	b : .word 0
	c : .word 0
	d : .word 0
	e : .word 0
	
	
	prompt : .asciiz "Please enter five integers seperated by an enter key.\n" 	## prompting the user
	values_propmpt : .asciiz "Values of a, b, c, d, e are : ( Respectively ) \n"
	result_prompt : .asciiz "\nThe result is : \n"
.text	
main:
	# Prompt the values.
	li $v0, 4		# syscall for printing a string
	la $a0, prompt		# loading the prompt from data section into $a0
	syscall 
	
	# Get "a" number from user
	li $v0, 5
	syscall
	move $t0, $v0		# store read value in $t0
	
	# Get "b" number from user
	li $v0, 5
	syscall
	move $t1, $v0		# store read value in $t1

	# Get "c" number from user
	li $v0, 5
	syscall
	move $t2, $v0		# store read value in $t2

	# Get "d" number from user
	li $v0, 5
	syscall
	move $t3, $v0		# store read value in $t3

	# Get "e" number from user
	li $v0, 5
	syscall
	move $t4, $v0		# store read value in $t4
	
	# Printing values prompt
	li $v0, 4
	la $a0, values_propmpt
	syscall

	
	# Print values
	li $v0, 1 		# code for print_int
	move $a0, $t0		# put result in $a0
	syscall	
	
	li $v0, 1 		# code for print_int
	move $a0, $t1		# put result in $a0
	syscall	
	
	li $v0, 1 		# code for print_int
	move $a0, $t2		# put result in $a0
	syscall	
	
	li $v0, 1 		# code for print_int
	move $a0, $t3		# put result in $a0
	syscall	
	
	li $v0, 1 		# code for print_int
	move $a0, $t4		# put result in $a0
	syscall	

		
	# Calculating equations
	add $t5, $t0, $t1	# store (a + b) in $t5
	div $t6, $t5, $t2	# store (a + b) / c in $t6
	sub $t7, $t3, $t4 	# store (d-e) in $t7
	sub $s0, $t6, $t7	# storing result of equation in $s0 - (a+b)/c - (d-e) 
	
	# Print out result prompt.
	li $v0, 4		# code for print_string
	la $a0, result_prompt	# point $a0 to result propmt string.
	syscall
	
	# Print result
	li $v0, 1 		# code for print_int
	move $a0, $s0		# put result in $a0
	syscall			
	
	li $v0, 10		# code for exit
	syscall	
	
	

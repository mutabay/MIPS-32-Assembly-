# Write a program that checks if the given number is an even number.
# Write a program that solves the equation Ax^2 + Bx + C = 0. ( A,B,C can't be equal 0 )


.data	
	start_prompt : .asciiz "Which program do you want to start? ( Enter 0 for checking even or odd number | Enter 1 for solving equation )"
	# First program
	start_prompt1_Check_EvenOrOdd : .asciiz "Please enter number for checking even or odd.\n" 	## prompting the user
	even_prompt: .asciiz "\nThe number is even.\n"
        odd_prompt: .asciiz "\nThe number is odd.\n"
		
	# Second program
	start_propmpt1_SolveEquation : .asciiz "\nPlease enter a,b,c value integers seperated by an enter key for solving ax^2 + bx + c = 0 equation.\n"
	equation_prompt1 : .asciiz "X^2 + "
	equation_prompt2 : .asciiz "X + "
	equation_prompt3 : .asciiz " = 0"
	
	x_prompt: .asciiz "\nRoots are :"
	x1_prompt: .asciiz "\nx1 = "
 	x2_prompt: .asciiz "\nx2 = "
 	
 	fp2: .float 2.0
	exit_prompt: .asciiz "\nProgram is closing.\n"

	
.text
	
	# Printing start_propmpt string 
	li $v0, 4
	la $a0, start_prompt
	syscall
	
	# Taking argument for running which program.
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, $zero, EvenOrOddCheck
	j SolveEquation			# Jump SolveEquation branch if argument is 1.
	
	EvenOrOddCheck:			# Run EvenOrOddCheck bran if argument is 0.
	
	# Printing propmptInt1 string 
	li $v0, 4
	la $a0, start_prompt1_Check_EvenOrOdd
	syscall
	
	# Reading value 
	li $v0, 5
	syscall
	move $t0, $v0
	
	# If number is negative, then exit program.
	slt $t1, $t0, $zero		# set $t1 register to 1 if $t0 less than zero otherwise set 0.
	bne $t1, $zero, Exit	
	
	# Check number is even or odd 
	andi $t1, $t0, 1 		# Bitwise AND immediate.
	beq $t1, $zero, Even		# If $t1 is 0, then Even instruction will work.
	j Odd				# Otherwise Odd instruction will work.
	
	
	Even:
		# Printing even number prompt
		li $v0, 4 
		la $a0, even_prompt
		syscall
		j Exit
		
	Odd:
		# Printing odd number prompt
		li $v0, 4 
		la $a0, odd_prompt
		syscall
		j Exit
	
	SolveEquation: 
		# Prompt the values.
		li $v0, 4			# syscall for printing a string
		la $a0, start_propmpt1_SolveEquation		# loading the prompt from data section into $a0
		syscall 
		
		# Get "a" value from user
		li $v0, 5
		syscall
		move $t0, $v0			# store read value in a = $t0
	
		# Get "b" value from user
		li $v0, 5
		syscall
		move $t1, $v0			# store read value in b = $t1

		# Get "c" value from user
		li $v0, 5
		syscall
		move $t2, $v0			# store read value in c = $t2
		
		beq $t0, $zero, Exit		# If a,b,c is zero then exit program.
		beq $t1, $zero, Exit
		beq $t2, $zero, Exit
		
		# Printing equation 
		# Print 'a'
		li $v0, 1 		# For print_int
		move $a0, $t0		# put result in $t0
		syscall	
		
		# Print equation_prompt1
		li $v0, 4
		la $a0, equation_prompt1
		syscall
		
		# Print 'b'
		li $v0, 1 		# For print_int
		move $a0, $t1		# put result in $t1
		syscall	
		
		# Print equation_prompt2
		li $v0, 4
		la $a0, equation_prompt2
		syscall
		
		# Print 'c'
		li $v0, 1 		# For print_int
		move $a0, $t2		# put result in $t2
		syscall	
		
		# Print equation_prompt2
		li $v0, 4
		la $a0, equation_prompt3
		syscall
		
		# Solving equation
		mul $t3, $t1, $t1		# $t3 = b^2
		mul $t4, $t0, $t2		# $t4 = a * c 
		li $t6, 4			# $t6 = 4
		mul $t4, $t4, $t6		# $t4 = 4 * a *c
		sub $t5, $t3, $t4		# $t5 = delta
		
		# Controlling determinant for roots. 
		bltz $t5,Exit			# If it's less than 0, then stop the program.
		
		# For sqrt.s function, we need floats, not word.
		mtc1 $t5, $f0			# Move to coprocessor 1 
		cvt.s.w $f0, $f0		# Convert from word to single precision.
		sqrt.s $f1, $f0			# $f1 = sgrt(delta)
		
		
		
		# For finding roots, we need to convert word a and b to float 
		mtc1 $t0, $f2			# Move a to coprocessor 1 ( $f2 = a(float)  )
		cvt.s.w $f2, $f2		# Convert from word to single precision.
		mtc1 $t1, $f3			# Move b to coprocessor 1 ( $f3 = b(float) )
		cvt.s.w $f3, $f3		# Convert from word to single precision.

		neg.s $f3, $f3			# $f3 = -b
		l.s $f9, fp2			# $f9 = 2
		
		mul.s $f4, $f2, $f9		# $f4 = 2*a
		
		add.s $f5, $f3, $f1		# $f5 = -b + sqrt(delta)
		sub.s $f6, $f3, $f1		# $f6 = -b - sqrt(delta)
		
		div.s $f7, $f5, $f4		# -b + sqrt(delta) / 2*a
		div.s $f8, $f6, $f4		# -b - sqrt(delta) / 2*a
		
		# Printing x_prompt
		li $v0, 4
		la $a0, x_prompt
		
		# Printing x1_prompt
		li $v0, 4
		la $a0, x1_prompt
		syscall
		
		# Printing x1
		li $v0, 2 
		mov.s $f12, $f7
		syscall
		
		# Printing x2_prompt
		li $v0, 4
		la $a0, x2_prompt
		syscall
		
		# Printing x2
		li $v0, 2 
		mov.s $f12, $f8
		syscall
		
		# Exit program
		j Exit
		
		
	# Exit
	Exit:
		li $v0, 4
		la $a0, exit_prompt
		syscall
		
		li $v0, 10
		syscall
		
	
	
		

# 1- Calculate the value of factorial of integer values with for loop.
# 2- What is the greates integer value for your program works correctly?
# 3- Modify code in such way that oweflow will be recognized when the value of factorial will be too large.


# Integer boundaries 32 bits | -2,147,483,648 | +2,147,483,647 | Integer variables can't pass this value, this is called overflow.
# So the max value of the number can be 19 (19! = 109641728), We can't calculate 20! with integer.
# Because 20! is equal to 2,432,902,008, it's passing boundary of integer.

.data
	start_prompt : .asciiz "\nPlease enter integer for calculating factorial of that number.\n"
	result_prompt_1 : .asciiz "Result of the "
	result_prompt_2 : .asciiz " factorial is : "
	overflow_prompt : .asciiz "\n!!!!!Please enter less than 20!!!\n"  
	exit_prompt: .asciiz "\nProgram is closing.\n"
	
.text

main:
	# Printing start_propmpt string.
	li $v0, 4
	la $a0, start_prompt
	syscall
	
	# Reading number for calculating factorial.
	li $v0, 5
	syscall
	move $t0, $v0		# Loading n value. number = $t0
	
	# Checking number if it's greater than 20 or not.
	bge $t0, 20, Overflow
	
	# Printing result_prompt_1.
	li $v0, 4
	la $a0, result_prompt_1
	syscall
	
	# Printing rnumber. 
	li $v0, 1
	move $a0, $t0
	syscall

	# Printing result_prompt_2.
	li $v0, 4
	la $a0, result_prompt_2
	syscall
	
	li $t1, 1		# Storing factorial result value. factorial = $t1
	
	li $t2, 1

	
	
# For loop (int i = number ; i >= 0 ; i--)
ForLoop:
	blez $t0, Exit		# Jump exit if n is equal or less than 0.
	mul $t1, $t1, $t0	# Factorial calculation.
	addi $t0, $t0, -1	# Decreasing iterator value (number or i),
	j ForLoop


# Overflow Handling
Overflow:
	# Printing start_propmpt string.
	li $v0, 4
	la $a0, overflow_prompt
	syscall
	
	j main

# Exit Branch
Exit:
	li $v0, 1
	move $a0, $t1 
	syscall
	
	li $v0, 4
	la $a0, exit_prompt
	syscall
	
	li $v0, 10
	syscall

# Homework 1
# Discription: This program asks the user to enter two numbers. The numbers are added and the sum is displayed
# Author@ Jeremy Pierce
# Date: 06-1-16

# # # # # # # # # # # # # # # # # # # # # # # # #
#   ___       __   _____   __
#  |  |  \    /  /\    |  |    /  /\
# |_|_/  /_/--\  |_|  /_/--\ segment
#
# ...the variables
.data
	promptFirstNum: .asciiz "Enter the First Number: "
	promptSecondNum: .asciiz "\nEnter the Second Number: "
	results: .asciiz "\nThe sum is: "
	continue: .asciiz "\nIf you would like to keep using the program press 1: "
	bye: .asciiz "Good-Bye!"
	
	.eqv call syscall
	.eqv com li $v0
	
	# Since printing is common use a macro to improve readability
	.macro println(%str)
	com, 4
	la $a0, %str
	call
	.end_macro 

# # # # # # # # # # # # # # # # # # # # # # # # #
# _____  ____  _         _____
#    |  |    |  |_    \  \_/    |  |
#   |_|    |_|__  /_/ \    |_|  segment.
#
# ...the code.
.text
main:
	# clear the registers
	li $t0, 0
	li $t1, 0	
	
	# Prompt the user to enter the first number
	println(promptFirstNum)
	
	# Get the first number
	com, 5
	call
	
	# Move the first number into a temp register
	move $t0, $v0
	
	# Prompt the user to enter the second number
	println(promptSecondNum)
	
	# Get the second number
	com, 5
	call
	
	# Move the second number into a temp register
	move $t1, $v0	
	
	# Display the results message	
	println( results)
	
	# Print the sum
	com, 1
	add $a0, $t0, $t1
	call
	
	println(continue)
	
	com, 5
	call
	
	beq $v0, 1, main
	
	println(bye)
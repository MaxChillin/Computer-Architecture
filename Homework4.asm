# Homework 4
# Discription: This program asks the user for a temperature, then performs conversion 
#		between Celsius and Fahrenheit, and displays the results
# Author@ Jeremy Pierce
# Date: 7-13-16
#######################################################
#	THESE ARE THE ASSIGNMENT INSTRUCTIONS:
#
#	Write a MIPS assemby language program that performs conversion 
#		between Celsius and Fahrenheit (temperature units).
#	a. Prompt for selection of 1) F -> C or 2) C -> F
#	b. Get a value as a decimal floating point number, e.g. 90.9
#	c. Perform the conversion as selected in step a. using single-precision 
#		floating point number instructions
#	d. Print out the result as a decimal floating point number.
#######################################################
#   ___     __   ___     __
#  || \\   //\\   ||    //\\
#  ||_//  //--\\  ||   //--\\ segment
#
# ...the variables
.data
welcomeMessage: .asciiz "Welcome, Please Select The Conversion You Would Like to Perform\n1: Fahrenheit to Celsius.\n2: Celsius to Fahrenheit."
fahrenheitMessage: .asciiz "Please Enter The Temperature in Fahrenheit: "
celsiusMessage: .asciiz "Please Enter The Temperature in Celsius: "
fahrenheitDisplayMessage: .asciiz "The Temperature in Fahrenheit is: "
celsiusDisplayMessage: .asciiz "The Temperature in Celsius is: "
continueMessage: .asciiz "Would You Like To Convert Another Temperature?"
farewellMessage: .asciiz "Have A Wonderful Day! Good-Bye!"
newLine: .asciiz "\n"

thirtyTwo: .float 32
five: .float 5
nine: .float 9

#######################################################
#  ___  ___   _    _  ___
#   ||  ||_    \\//    ||
#   ||  ||__   //\\    ||  segment.
#
# ...the code.
.text


#######################################################
lwc1 $f6, thirtyTwo		#  This store 32 into the 6th coprocessor register
lwc1 $f5, five			#  This store 5 into the 5th coprocessor register
lwc1 $f9, nine			#  This store 9 into the 9th coprocessor register
li $t6, 1				#  This sets the 6th and 7th temperary registers to 1 and 2 repectively
li $t7, 2				#	in order to handle the user input 
#######################################################
welcome:			#
la $a0, welcomeMessage		#  This displays the welcome message
li $v0, 51			#
syscall				#
move $s0, $a0			#
move $t0, $a1			#
bltz $t0, welcome		#  This repeats the question if they hit cancel or the red X
beq $s0, $t6, fahrenheit		#  This checks the user input and jumps to fahrenheit lable
beq $s0, $t7, celsius		#  This checks the user input and jumps to celsius lable
j welcome			#  This displays the welcome message again for invalid input
#######################################################
fahrenheit:			#
la $a0, fahrenheitMessage	#   This displays the fahrenheit prompt
li $v0, 52 			#
syscall				#
mov.s $f7, $f0			#
move $t0, $a1			#
bltz $t0, fahrenheit		#  This repeats the question if they hit cancel or the red X
sub.s $f7, $f7, $f6		#  This subtracts 32 from the users input value
mul.s $f7, $f7, $f5		#  This multiples the new value by 5
div.s $f7, $f7, $f9		#  This divides the new value by 9
j celsiusDisplay			#  This is the check if they hit the red X. If so it repeats the question
#######################################################
celsius:				#
la $a0, celsiusMessage		# This displays the celsius prompt
li $v0, 52			#
syscall				#
mov.s $f7, $f0			#
move $t0, $a1			#
bltz $t0, celsius 		# This repeats the question if they hit cancel or the red X
mul.s $f7, $f7, $f9		#  This multiples the users input value by 9
div.s $f7, $f7, $f5		#  This divides the new value by 5
add.s $f7, $f7, $f6		#  This adds 32 to the new value
j fahrenheitDisplay		# This is the check if they hit the red X. If so it repeats the question 
#######################################################
fahrenheitDisplay:		#
la $a0, fahrenheitDisplayMessage	#   This displays the temperature in fahrenheit
li $v0, 57			#
mov.s $f12, $f7			#
syscall				#
j continue			#
#######################################################
celsiusDisplay:			#
la $a0, celsiusDisplayMessage	#   This displays the temperature in celsius
li $v0, 57			#
mov.s $f12, $f7			#
syscall				#
j continue			#
#######################################################
continue:			#
la $a0, continueMessage		#   This displays the message to continue
li $v0, 50			#
syscall				#
move $t0, $a0			#
beq $t0, $0, welcome		#
#######################################################
end:				#
li $v0, 55			#
la $a0, farewellMessage		#  This displays the farewell message
addi $a1, $0, 1			#
syscall				#
li $v0, 10			# This command tells the system to exit the program
syscall				#
#######################################################

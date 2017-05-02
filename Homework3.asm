# Homework 3
# Discription: This program asks the user 3 questions, then displays different responses depending on how the user answers the questions.
# Author@ Jeremy Pierce
# Date: 06-20-16
#######################################################
#	THESE ARE THE ASSIGNMENT INSTRUCTIONS:
#
#	Write a MIPS assembly language program that
# 	- asks and gets answers for following Y/N questions:
# 	a. Are you attending most sessions of this course (Y/N) ?
#	b. Are you spending considerable effort for this course (Y/N) ?
#	c. Are you curious about how a computer works (Y/N)?
#	- Prints out
#	"You will PASS this course!" if both answers to question a. AND b. are Y
#	"You will DO WELL!" if all answers are Y
#	"You will FAIL this course!" if all answers are N.  
#	Show test runs for each of the possible outputs.
#######################################################
#   ___        __   ___    __
#  ||  \\    //\\    ||     //\\
# ||_//  // --\\  ||   // --\\ segment
#
# ...the variables
.data
question1: .asciiz "Are you attending most sessions of this course (Y/N) ?"
question2: .asciiz "Are you spending considerable effort for this course (Y/N) ?"
question3: .asciiz "Are you curious about how a computer works (Y/N) ?"
passMessage: .asciiz "You will PASS this course!"
wellMessage: .asciiz "You will DO WELL!"
failMessage: .asciiz "You will FAIL this course!"
newLine: .asciiz "\n"

#######################################################
#   ___  ___   _    _______
#    ||    ||_     \\/ /    ||
#   ||    ||__  / /\\     ||  segment.
#
# ...the code.
.text


#######################################################
addi $t5, $zero, 1	#  This sets the 5th temperary registers to 1 repectively
addi $t6, $zero, -1	#  This sets the 6th and 7th temperary registers to 2 and -1 repectively
addi $t7, $zero, 2	#	in order to check if the user hits "cancel" or the red "X"
#######################################################
q1:			#
la $a0, question1		#  This displays the 1st question
li $v0, 50		#
syscall			#
move $t0, $a0		#
beq $t0, $t7, q1		# This is the check if they hit cancel. If so it repeats the question
beq $t0, $t6, q1		# This is the check if they hit the red X. If so it repeats the question
#######################################################
q2:			#
la $a0, question2	#   This displays the 2nd question
li $v0, 50		#
syscall			#
move $t1, $a0		#
beq $t1, $t7, q2 	# This is the check if they hit cancel. If so it repeats the question
beq $t1, $t6, q2		# This is the check if they hit the red X. If so it repeats the question
#######################################################
q3:			#
la $a0, question3	# This displays the 3rd question
li $v0, 50		#
syscall			#
move $t2, $a0		#
beq $t2, $t7, q3 	# This is the check if they hit cancel. If so it repeats the question
beq $t2, $t6, q3		# This is the check if they hit the red X. If so it repeats the question
#######################################################
addi $t4, $zero, 1	# 
and $t3, $t0, $t1	#   Test for failure
and $t3, $t3, $t2	#
beq $t3, $t4, fail	#
#######################################################
or $t3, $t0, $zero	# 
beq $t3, $t5, end	#
or $t3, $t3, $t1		#   Test for pass
beq $t3, $t5, end	#
or $t3, $t3, $t2	#
beq $t3, $t5, pass 	#
j well			#
#######################################################
fail:			#
la $a0, failMessage	#   This displays the message "You will FAIL this course!"
addi $a1, $zero, 0	#
li $v0, 55		#
syscall			#
j end			#
#######################################################
pass:			#
la $a0, passMessage	#   This displays the message "You will Pass this course!"
addi $a1, $zero, 1	#
li $v0, 55		#
syscall			#
j end			#
#######################################################
well:			#
la $a0, wellMessage	#   This displays the message "You will DO WELL!"
addi $a1, $zero, 1	#
li $v0, 55		#
syscall			#
j end			#
#######################################################
end:			#			
li $v0, 10		# This command tells the system to exit the program
syscall			#
#######################################################

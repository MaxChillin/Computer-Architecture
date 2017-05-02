# Final Project
# Discription: This program plays the game Bulls and Cows
# Author@ Jeremy Pierce
# Date: 06-20-16
#######################################################
#	THESE ARE THE ASSIGNMENT INSTRUCTIONS:
#
#	Write a MIPS assembly language program game called Bulls and Cows
# 		The computer generates a random number. 
#		Then the user tries to guess the number based
# 		off of clues that the computer gives. 
#		Bull = A correct digit in the correct place 
#		Cow = A correct digit in the wrong place
#######################################################
#   ___        __   ___     __
#  ||  \\    //\\    ||     //\\
# ||_//  // --\\  ||   // --\\ segment
#
# ...the variables
.data

inputMessage: .asciiz "Please Enter A 4 Digit Number. \nAll Digits Must Be Different:"
guessMessage: .asciiz "Please Make A 4 Digit Guess. \nAll Digits Must Be Different"
invalidMessage: .asciiz "The Number You Entered Is Invalid. Please Make Sure All 4 Digits Are Different."
bullMessage: .asciiz "Your Total Number of Bulls Is: "
cowMessage: .asciiz "Your Total Number of Cows Is: "
victoryMessage: .asciiz "Congratulations! You Have Guessed The Correct Number!"
newLine: .asciiz "\n"
space: .asciiz " "

.macro println()
li $v0, 4
la $a0, newLine
syscall
.end_macro 

.macro space()
li $v0, 4
la $a0, space
syscall
.end_macro 

.eqv Bulls, $t8
.eqv Cows, $t9

#######################################################
#   ___  ___   _    _______
#    ||    ||_     \\/ /    ||
#   ||    ||__   / /\\    ||  segment.
#
# ...the code.
.text
#######################################################
addi $s6 , $zero, 9		#
addi $s7, $zero, 10		#
#######################################################
main:				#
EnterNumber:			#
li $v0, 51			#
la $a0, inputMessage		#
syscall				#
move $s0, $a0			#
#######################################################
div $s0, $s7			#
mfhi $s1			# dd
mflo $s0			#
div $s0, $s7			#
mfhi $s2			# cc
mflo $s0			#
div $s0, $s7			#
mfhi $s3			# bb
mflo $s0			#
div $s0, $s7			#
mfhi $s4			# aa
mflo $s0			#
#######################################################
#	This is the computer generated number that the player must guess
#######################################################
setFirstNumber:		#
li $v0, 41			#
syscall				#
move $t0, $a0			#
div $t0, $s6			#
mfhi $t0			#
slt $t4, $t0, $s7		#
beqz $t4, setFirstNumber	#
slt $t4, $zero, $t0		#
beqz $t4, setFirstNumber	#
beqz $t0, setFirstNumber	#
#######################################################
setSecondNumber:		#
li $v0, 41			#
syscall				#
move $t1, $a0			#
div $t1, $s6			#
mfhi $t1			#
slt $t4, $t1, $s7		#
beqz $t4, setSecondNumber	#
slt $t4, $zero, $t1		#
beqz $t4, setSecondNumber	#
beq $t0, $t1, setSecondNumber	#
beqz $t1, setSecondNumber	#
#######################################################
setThirdNumber:		#
li $v0, 41			#
syscall				#
move $t2, $a0			#
div $t2, $s6			#
mfhi $t2			#
slt $t4, $t2, $s7		#
beqz $t4, setThirdNumber	#
slt $t4, $zero, $t2		#
beqz $t4, setThirdNumber	#
beq $t0, $t2, setThirdNumber	#
beq $t1, $t2, setThirdNumber	#
beqz $t2, setThirdNumber	#
#######################################################
setForthNumber:		#
li $v0, 41			#
syscall				#
move $t3, $a0			#
div $t3, $s6			#
mfhi $t3			#
slt $t4, $t3, $s7		#
beqz $t4, setForthNumber	#
slt $t4, $zero, $t3		#
beqz $t4, setForthNumber	#
beq $t0, $t3, setForthNumber	#
beq $t1, $t3, setForthNumber	#
beq $t2, $t3, setForthNumber	#
beqz $t3, setForthNumber	#
#######################################################
println()				#
li $v0, 1				#
move $a0, $t0			#
syscall				#
space()				#
li $v0, 1				#
move $a0, $t1			#
syscall				#
space()				#
li $v0, 1				#
move $a0, $t2			#
syscall				#
space()				#
li $v0, 1				#
move $a0, $t3			#
syscall				#
space()				#
#######################################################
Guess:				#
li $v0, 51			#  This takes in the players guess
la $a0, guessMessage		#
syscall				#
move $s0, $a0			#
#######################################################
div $s0, $s7			#
mfhi $s1			# 
mflo $s0			#
div $s0, $s7			#
mfhi $s2			# 
mflo $s0			#
div $s0, $s7			#
mfhi $s3			# 
mflo $s0			#
div $s0, $s7			#
mfhi $s4			# 
mflo $s0			#
#######################################################
beq $s1, $s2, invalidNumber	#
beq $s1, $s3, invalidNumber	# This checks the validity of the guess to make sure all digits
beq $s1, $s4, invalidNumber	#	are unique.
beq $s2, $s3, invalidNumber	#
beq $s2, $s4, invalidNumber	#
beq $s3, $s4, invalidNumber	#
#######################################################
add Cows, $zero, $zero		#  This clears the previous count of Bulls and Cows from
add Bulls, $zero, $zero		#	the last guess.
#######################################################
bne $s1, $t3, second		#
jal incrementBulls		#
second:				#
bne $s2, $t2, third		#
jal incrementBulls		#
third:				#
bne $s3, $t1, forth		#
jal incrementBulls		#
forth:				#
bne $s4, $t0, bullsDone		#
jal incrementBulls		#
bullsDone:			#
#######################################################
li $v0, 56			#
la $a0, bullMessage		#
move $a1, Bulls			#
syscall				#
#######################################################
bne $s1, $t0, cow1		# 
jal incrementCows		# 
cow1:				#
bne $s1, $t1, cow2		# 
jal incrementCows		#
cow2:				#
bne $s1, $t2, cow3		#
jal incrementCows		#
cow3:				#
bne $s2, $t0, cow4		#
jal incrementCows		#
cow4:				#
bne $s2, $t1, cow5		#
jal incrementCows		#
cow5:				#
bne $s2, $t3, cow6		#
jal incrementCows		#
cow6:				#
bne $s3, $t0, cow7		#
jal incrementCows		#
cow7:				#
bne $s3, $t2, cow8		#
jal incrementCows		#
cow8:				#
bne $s3, $t3, cow9		#
jal incrementCows		#
cow9:				#
bne $s4, $t1, cow10		#
jal incrementCows		#
cow10:				#
bne $s4, $t2, cow11		#
jal incrementCows		#
cow11:				#
bne $s4, $t3, cowsDone		#
jal incrementCows		#
cowsDone:			#
#######################################################
li $v0, 56			#
la $a0, cowMessage		#
move $a1, Cows			#
syscall				#
#######################################################
beq Bulls, 4, victory		#
#######################################################
j Guess				#


#######################################################
victory:				#
li $v0, 55			#
la $a0, victoryMessage		#
addi $a1, $zero, 1		#
syscall				#
#######################################################
end:				#			
li $v0, 10			# This command tells the system to exit the program
syscall				#
#######################################################
invalidNumber:			#
li $v0, 55			# This procedure displays an error message when the user 
la $a0, invalidMessage		#	tries to enter and invalid number.
addi $a1, $zero, 0		#
syscall				#
j Guess				#
#######################################################
incrementBulls:			#
addi Bulls, Bulls, 1		#  This procedure adds one to the count of Bulls register
jr $ra				#
#######################################################
incrementCows:			#
addi Cows, Cows, 1		#  This procedure adds one to the count of Cows register
jr $ra				#
#######################################################

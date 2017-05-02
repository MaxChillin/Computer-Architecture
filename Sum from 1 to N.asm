.data
.eqv call, syscall
.eqv x, $t0
.eqv i, $t1
.eqv total, $t2

prompt: .asciiz "\nWe are going to add up all the numbers starting from 1 and going to the number you give us. So please enter a number: "
sum2: .asciiz "\nThe sum is: "
again: .asciiz "\n\nTo continue press 1: "



.text
main:

li $v0, 0
li $a0, 0
li $a1, 0
li $a2, 0
li $a3, 0
li $t0, 0
li $t1, 0
li $t2, 0
li $t3, 0
li $t4, 0
li $t5, 0
li $t6, 0
li $t7, 0
li $t8, 0
li $t9, 0
li $s0, 0
li $s1, 0
li $s2, 0
li $s3, 0
li $s4, 0	


li $v0, 4
la $a0, prompt
call

li $v0, 5
call

addi x, $v0, 0	#user input = x
addi i, $zero, 1	#counter = i

loop:
bgt i, x, endLoop
add total, total, i
addi i, i, 1
j loop
endLoop:

li $v0, 4
la $a0, sum2
call

li $v0, 1
addi $a0, total, 0
call

li $v0, 4
la $a0, again
call

li $v0, 5
call

addi $t3, $v0, 0

beq $t3, 1, main
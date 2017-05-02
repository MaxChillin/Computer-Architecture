.data
.eqv call syscall
.eqv com li $v0

num1: .asciiz "\nEnter the first number: "
num2: .asciiz "\nEnter the second number: "
sum: .asciiz "\nThe sum of the two numbers is: "
cont: .asciiz "\nPress 1 if you would like to continue: "

.macro println(%str)
com, 4
la $a0, %str
call
.end_macro 

.text
main:
li $t0, 0
li $t1, 0

println(num1)

com, 5
call

addi $t0, $v0, 0

println(num2)

com, 5
call

addi $t1, $v0, 0

println(sum)

com, 1
add $a0, $t0, $t1
call

println(cont)

com, 5
call

addi $t0, $v0, 0

beq $t0, 1, main

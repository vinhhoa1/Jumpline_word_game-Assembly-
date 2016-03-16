.data
prompt: .asciiz "Welcome to Jumpline2\n"
mess1: .asciiz "\nMAIN MENU\n\nHow many character do you want to play with? (5, 6, 7, or 100 to exit): "
mess2: .asciiz "Confirmed! You chose to play with: "
mess3: .asciiz "\n\nHelp options:\n Enter ? to rearrange the letters\n Enter ! to return to MAIN MENU\n # to view words left to guess\n $ to view bad guesses\n"
mess4: .asciiz "Wrong input, enter 5,6 or 7\n"
waitMess: .asciiz "Generating correct words. Please wait a moment."
endline: .asciiz "\n"


wordLength: .word 0
#main arguments
# a0 = wordlength
# a2 = game word ex: wordtest
# a3 = legitimate word ex: word1

# Instruction
# ? to rearrange
# ! to go back to menu
# 100 to end program
.text
.globl main, getWordLength

li $v0, 4
la $a0, prompt
syscall

main:
	addi $sp, $sp, -20
	li $v0, 4
	la $a0, mess1
	syscall
	li $v0, 5
	syscall
	sw $v0, wordLength
	beq $v0, 5, fiveletters
	beq $v0, 6, sixletters
	beq $v0, 7, sevenletters
	beq $v0, 100, EndGame
	li $v0, 4
	la $a0, mess4
	syscall
j main

fiveletters:

	li $v0, 4
	la $a0, mess2
	syscall
	li $v0, 1
	lw $a0, wordLength
	syscall
	li $v0, 4
	la $a0, endline
	syscall

#######################################
#generateAlphabet(5) GOES HERE
#######################################
	
	#la $a0, WordTest	# Sets to a location from heap
	lw $a1, wordLength	# Sets to a location from heap
	jal generateAlphabet
	#AT THIS POINT THE GENERATED WORD IS STORED IN $a0
	lw $a1, wordLength
	jal WordRearrange
#	li $v0, 4
	move $a0, $t7
#	syscall
#generateCorrect(5) GOES HERE
	#move the word from $a0 to $a1, we will need it here later
	move $a1, $a0
	li $v0, 4
	la $a0, waitMess
	syscall
	
	li $a3, 5
	add $sp, $sp, -4 	# Decrements stack
	jal generateCorrect
	
	add $sp, $sp, -4 	# Decrements stack
	lw $a1, wordLength
	jal splitArrays
	li $v0, 4
	la $a0, mess3
	syscall
	# load argument for 5 letters word
	lw $a0, wordLength
#	la $a2, WordTest
	la $a3, ($s2)
	
	jal inputLoop
	addi $sp, $sp, 20
	j main
	
sixletters:

	li $v0, 4
	la $a0, mess2
	syscall
	li $v0, 1
	lw $a0, wordLength
	syscall
	li $v0, 4
	la $a0, endline
	syscall

#generateAlphabet(6) GOES HERE
#la $a0, WordTest	# Sets to a location from heap
	lw $a1, wordLength	# Sets to a location from heap
	jal generateAlphabet
	lw $a1, wordLength
	jal WordRearrange
#	li $v0, 4
	move $a0, $t7
#	syscall
#generateCorrect(6) GOES HERE
	#move the word from $a0 to $a1, we will need it here later
	move $a1, $a0
	li $v0, 4
	la $a0, waitMess
	syscall
	li $a3, 6
	add $sp, $sp, -4 	# Decrements stack
	jal generateCorrect
	
	add $sp, $sp, -4 	# Decrements stack
	lw $a1, wordLength
	jal splitArrays
	
	li $v0, 4
	la $a0, mess3
	syscall
	
	lw $a0, wordLength
#	la $a2, WordTest2
#	la $a3, word2
		
	
	jal inputLoop
	addi $sp, $sp, 20
	j main

sevenletters:

#	la $0, word3
	
	
	li $v0, 4
	la $a0, mess2
	syscall
	li $v0, 1
	lw $a0, wordLength
	syscall
	li $v0, 4
	la $a0, endline
	syscall

#######################################
#generateAlphabet(7) GOES HERE
#######################################
	lw $a1, wordLength	# Sets to a location from heap
	jal generateAlphabet
	lw $a1, wordLength
	jal WordRearrange
#	li $v0, 4
	move $a0, $t7
#	syscall
#generateCorrect(7) GOES HERE
	#move the word from $a0 to $a1, we will need it here later
	move $a1, $a0
	li $v0, 4
	la $a0, waitMess
	syscall
	li $a3, 7		
	add $sp, $sp, -4 	# Decrements stack
	jal generateCorrect
	
	add $sp, $sp, -4 	# Decrements stack
	lw $a1, wordLength
	jal splitArrays
	
	li $v0, 4
	la $a0, mess3
	syscall

	lw $a0, wordLength
#	la $a2, WordTest3
#	la $a3, word3


	jal inputLoop
	addi $sp, $sp, 20
	j main
	
getWordLength:
	lw $a0, wordLength
	jr $ra
EndGame:
	li $v0, 10
	syscall

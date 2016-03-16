.data
randomWord5:	.asciiz "------"	#placeholders
randomWord6:	.asciiz "-------"
randomWord7:	.asciiz "--------"

.text
.globl random5, random6, random7, generateAlphabet, get5WordRandom, get6WordRandom, get7WordRandom

##########################################################################
#THIS FUNCTION GENERATES A RANDOM SET OF LETTERS BASED UPON THE USER INPUT
#THE USER INPUT WILL BE STORED IN $a1 PASSED IN FROM runthim.asm
##########################################################################
generateAlphabet:
#$t0 is the counter of for loop as well as index for the array
add 	$sp, $sp, -4 	# Decrements stack
move	$sp, $ra


add $t0, $zero, $zero	#$t0 = 0

la $t5, randomWord5	#$t2 is the base address of the array
la $t6, randomWord6	#$t2 is the base address of the array
la $t7, randomWord7	#$t2 is the base address of the array

beq $a1, 5, random5
beq $a1, 6, random6
beq $a1, 7, random7

random5:
	beq $t0, 5, write5	#for(int i = 0; i < 5;i++)
	
	li $v0, 42		#Generate a random number between 0 and 25
	li $a0, 0		#Generate a random number between 0 and 25
	li $a1, 25		#Generate a random number between 0 and 25
	syscall
	move 	$t1, $a0		#$t1 = random number
	beq	$t0, 3, generateVowel5
	add 	$t1, $t1, 97		#$t1 = ascii value of random lowercase letter
	add 	$t4, $t0, $t5		#$t4 is the address of randomWord[i]
	sb 	$t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	add 	$t0, $t0, 1
	j random5
generateVowel5:
	jal 	generateVowel
	add 	$t4, $t0, $t5		#$t4 is the address of randomWord[i]
	sb 	$t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	add 	$t0, $t0, 1
	j random5
	
random6:
	beq 	$t0, 6, write6	#for(int i = 0; i < 6;i++)
	
	li 	$v0, 42		#Generate a random number between 0 and 25
	li 	$a0, 0		#Generate a random number between 0 and 25
	li 	$a1, 25		#Generate a random number between 0 and 25
	syscall
	
	move 	$t1, $a0	#$t1 = random number
	beq	$t0, 3, generateVowel6
	add 	$t1, $t1, 97	#$t1 = ascii value of random lowercase letter
	add 	$t4, $t0, $t6	#$t4 is the address of randomWord[i]
	sb 	$t1, ($t4)	#$t1 is the random letter, to be put in randomWord[i]
	add 	$t0, $t0, 1
	j random6
generateVowel6:
	jal 	generateVowel
	add 	$t4, $t0, $t6	#$t4 is the address of randomWord[i]
	sb 	$t1, ($t4)	#$t1 is the random letter, to be put in randomWord[i]
	add 	$t0, $t0, 1
	j random6
	
random7:
	beq $t0, 7, write7	#for(int i = 0; i < 7;i++)
	
	li $v0, 42		#Generate a random number between 0 and 25
	li $a0, 0		#Generate a random number between 0 and 25
	li $a1, 25		#Generate a random number between 0 and 25
	syscall
	
	move $t1, $a0		#$t1 = random number
	beq	$t0, 3, generateVowel7
	add $t1, $t1, 97	#$t1 = ascii value of random lowercase letter
	add $t4, $t0, $t7	#$t4 is the address of randomWord[i]
	sb $t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	add $t0, $t0, 1
	j random7
generateVowel7:
	jal 	generateVowel
	add $t4, $t0, $t7	#$t4 is the address of randomWord[i]
	sb $t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	add $t0, $t0, 1
	j random7

write5:
	add $t4, $t0, $t5	#$t4 is the address of randomWord[i]
	add $t1, $zero, 10	#$t1 = newLine character
	#si 10, ($t4)		#Store newLine character
	sb $t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	la $a0, randomWord5
	#li $v0, 4
	#syscall
	#la $s7, randomWord5	#$s7 contains the address of the random word
	j return 
	
write6:
	add $t4, $t0, $t6	#$t4 is the address of randomWord[i]
	add $t1, $zero, 10	#$t1 = newLine character
	#si 10, ($t4)		#Store newLine character
	sb $t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	la $a0, randomWord6
	#li $v0, 4
	#syscall
	#la $s7, randomWord6	#$s7 contains the address of the random word
	j return 

write7:
	add $t4, $t0, $t7	#$t4 is the address of randomWord[i]
	add $t1, $zero, 10	#$t1 = newLine character
	#si 10, ($t4)		#Store newLine character
	sb $t1, ($t4)		#$t1 is the random letter, to be put in randomWord[i]
	la $a0, randomWord7
	#li $v0, 4
	#syscall
	#la $s7, randomWord7	#$s7 contains the address of the random word
	j return 

return:
	move	$ra, $sp
	addi	$sp, $sp, 4
	jr	$ra

get5WordRandom:
	la 	$v1, randomWord5
	jr	$ra
get6WordRandom:
	la 	$v1, randomWord6
	jr	$ra
get7WordRandom:
	la 	$v1, randomWord7
	jr	$ra
	
generateVowel:
	move 	$t1, $a0		#$t1 = random number
	#add 	$t1, $t1, 97		#$t1 = ascii value of random lowercase letter
	blt	$t1, 5, a
	blt	$t1, 10, e
	blt	$t1, 15, i
	blt	$t1, 20, o
u:
	add	$t1, $zero, 117
	jr 	$ra	
a:	
	add	$t1, $zero, 97
	jr 	$ra
e:
	add	$t1, $zero, 101
	jr 	$ra
i:
	add	$t1, $zero, 105
	jr 	$ra
o:
	add	$t1, $zero, 111
	jr 	$ra

	

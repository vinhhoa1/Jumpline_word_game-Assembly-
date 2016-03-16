.data
offset2:	.word	0	#offsets are used in the storing of individual words. They keep track of where we last wrote
offset3:	.word	0
offset4:	.word	0
offset5:	.word	0
offset6:	.word	0
offset7:	.word	0

mess2:		.asciiz		"\nNumber of two letter words: "
mess3:		.asciiz		"\nNumber of three letter words: "
mess4:		.asciiz		"\nNumber of four letter words: "
mess5:		.asciiz		"\nNumber of five letter words: "
mess6:		.asciiz		"\nNumber of six letter words: "
mess7:		.asciiz		"\nNumber of seven letter words: "

numOf2:		.word	0	#Store the number of words in each array by length
numOf3:		.word	0
numOf4:		.word	0
numOf5:		.word	0
numOf6:		.word	0
numOf7:		.word	0

resultByte2:	.byte	0:32	#Byte array used in later functions
resultByte3:	.byte	0:32
resultByte4:	.byte	0:32
resultByte5:	.byte	0:32
resultByte6:	.byte	0:32
resultByte7:	.byte	0:32

result2:	.space	1024	#The arrays themselves. The hold words according to their length
result3:	.space	1024
result4:	.space	1024
result5:	.space	1024
result6:	.space	1024
result7:	.space	1024
maxinputLength: .word 0
#testArray: .asciiz	"apology\n", "apolog\n",  "galop\n", "goopy\n","loopy\n", "ology\n", "ago\n" , "gal\n", "gap\n", "gay\n", "lag\n","log\n","pay\n","go\n", "#"
.text
.globl 	splitArrays, get2WordArray, get3WordArray, get4WordArray, get5WordArray, get6WordArray, get7WordArray, get2WordNumber, get3WordNumber, get4WordNumber, get5WordNumber, get6WordNumber, get7WordNumber, sub2WordNumber, sub3WordNumber, sub4WordNumber, sub5WordNumber, sub6WordNumber sub7WordNumber, getResultByte2, getResultByte3, getResultByte4, getResultByte5, getResultByte6, getResultByte7, printWordsLeft, result2, result3, result4, result5,result6,result7, maxinputLength, getWordSum
###########################################
#THE FULL ARRAY IS IN $s2
###########################################
splitArrays:
#RESET ARRAY OFFSET AND COUNTER TO PREVENT COUNT POLLUTION
sw	$zero, numOf2
sw	$zero, numOf3
sw	$zero, numOf4
sw	$zero, numOf5
sw	$zero, numOf6
sw	$zero, numOf7

sw	$zero, offset2
sw	$zero, offset3
sw	$zero, offset4
sw	$zero, offset5
sw	$zero, offset6
sw	$zero, offset7

move	$sp, $ra
move 	$s1, $a1	#move the word length into a temporary register
#la	$t5, testArray
move 	$t5, $s2
add 	$t1, $zero, $zero
add	$t2, $zero, $zero
add	$t3, $zero, $zero
add	$t6, $zero, $zero
add 	$t7, $zero, $zero	
add 	$t8, $zero, $zero	
add 	$t9, $zero, $zero	
add	$s6, $zero, $zero

#########################################################
#DO NOT TOUCH $t6 AT ALL, IT MUST MAKE IT TO THE
#END OF THE GIANT ARRAY
#########################################################
splitArraysNow:
	add 	$t7, $t6, $t5		#$t7 = bigArray[i] address
	lb	$t8, ($t7)		#$t8 = bigArray[i]
	addi 	$t6, $t6, 1		#giant array counter
	addi	$t9, $t9, 1		#local word counter
	beq	$t8, 0, printArrays
	
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t8, 10, jumpTable
	########################################################################
	beq	$t8, 35, printArrays
	j 	splitArraysNow
	
jumpTable:
	beq	$t9, 3, split2
	beq 	$t9, 4, split3
	beq	$t9, 5, split4
	beq 	$t9, 6, split5
	beq	$t9, 7, split6
	beq 	$t9, 8, split7
	
##############################################################################################################
split2:
	la 	$t4, result2
	lw	$t7, offset2
splitt2:
	
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	
	
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset2		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt2
	
reset2:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset2		#store the index of the last byte we stored
	
	lw	$s6, numOf2
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf2
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	la $s0, 2
	sw $s0, maxinputLength # save highest valid word length to maxinputLength
	j	splitArraysNow
##############################################################################################################
split3:
	la 	$t4, result3
	lw	$t7, offset3

splitt3:
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset3		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt3
	
reset3:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset3		#store the index of the last byte we stored
	
	lw	$s6, numOf3
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf3
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	
	la $s0, 3
	sw $s0, maxinputLength
	j	splitArraysNow
##############################################################################################################
split4:
	la 	$t4, result4
	lw	$t7, offset4

splitt4:
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset4		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt4
	
reset4:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset4		#store the index of the last byte we stored
	
	lw	$s6, numOf4
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf4
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	la $s0, 4
	sw $s0, maxinputLength
	j	splitArraysNow
##############################################################################################################
split5:
	la 	$t4, result5
	lw	$t7, offset5

splitt5:
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset5		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt5
	
reset5:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset5		#store the index of the last byte we stored
	
	lw	$s6, numOf5
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf5
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	la $s0, 5
	sw $s0, maxinputLength
	j	splitArraysNow
##############################################################################################################
split6:
	la 	$t4, result6
	lw	$t7, offset6

splitt6:
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset6		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt6
	
reset6:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset6		#store the index of the last byte we stored
	
	lw	$s6, numOf6
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf6
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	la $s0, 6
	sw $s0, maxinputLength
	j	splitArraysNow
##############################################################################################################
split7:	
	la 	$t4, result7
	lw	$t7, offset7
splitt7:
	
	#meanwhile
	add	$t2, $t1, $t5		#bigArray[i] address
	lb	$t3, ($t2)		#bigArray[i] value
	
	
	########################################################################
	#THIS HAS TO BE CHANGED TO 10 LATER SO IT WORKS WITH THE FILE
	beq	$t3, 10, reset7		#We reached the end of the current word again
	########################################################################
	
	add	$t9, $t4, $t7		#$t9 = result2[offset] address
	sb	$t3, ($t9)		#$t5 is the value of $t4\
	#What needs to change in every iteration?
	#addi	$t9, $t9, 1
	addi	$t1, $t1, 1
	addi 	$t7, $t7, 1
	j 	splitt7

reset7:
#INSERT A # AT THE END OF THE ARRAY USING THE REGISTER THAT WAS KEEPING TRACK OF THAT ARRAY'S LATEST INDEX
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 10		#$t1 = newLine char
	sb	$t2, ($t9)		#store new line char
	addi 	$t7, $t7, 1
	add	$t9, $t4, $t7		#$t9 = result7[latestByte] address
	addi	$t2, $zero, 35		#$t1 = # char
	sb	$t2, ($t9)		#store # char
	sw	$t7, offset7		#store the index of the last byte we stored
	
	lw	$s6, numOf7
	addi	$s6, $s6, 1		#increase the number of found words by 1
	sw	$s6, numOf7
	
	add	$t9, $zero, $zero	#reset critical registers
	addi	$t1, $t1, 1
	#add	$t1, $zero, $zero
	
	la $s0, 7
	sw $s0, maxinputLength
	j	splitArraysNow

#########################################################
#THIS FUNCTION WILL BE USED TO DETERMINE IF WE NEED TO
#REROLL OR IF THE GAME HAS BEEN WON
#FIND THE SUMMATION OF THE WORD ARRAYS
#LENGTH OF GAME WORD IN $a0
#########################################################
getWordSum:
	add	$t0, $zero, $zero
	lw	$t1, numOf2
	add	$t0, $t1, $t0
	lw	$t1, numOf3
	add	$t0, $t1, $t0
	lw	$t1, numOf4
	add	$t0, $t1, $t0
	lw	$t1, numOf5
	add	$t0, $t1, $t0
	beq	$a0, 5, returnSum
	lw	$t1, numOf6
	add	$t0, $t1, $t0
	beq	$a0, 6, returnSum
	lw	$t1, numOf7
	add	$t0, $t1, $t0
	
	
returnSum:
	move 	$v0, $t0	#store the result in $v0
	jr 	$ra
#########################################################
#GETTER FUNCTIONS FOR THE ARRAYS OF DIFFERENT LENGTHS
#########################################################
get2WordArray:
	la 	$v1, result2
	jr	$ra
get3WordArray:
	la 	$v1, result3
	jr	$ra
get4WordArray:
	la 	$v1, result4
	jr	$ra
get5WordArray:
	la 	$v1, result5
	jr	$ra
get6WordArray:
	la 	$v1, result6
	jr	$ra
get7WordArray:
	la 	$v1, result7
	jr	$ra

#########################################################
#GETTER FUNCTIONS FOR NUMBER OF WORDS IN THE ARRAYS
#DESIRED NUMBER WILL BE IN $v1
#########################################################
get2WordNumber:
	la 	$v1, numOf2
	jr	$ra
get3WordNumber:
	la 	$v1, numOf3
	jr	$ra
get4WordNumber:
	la 	$v1, numOf4
	jr	$ra
get5WordNumber:
	la 	$v1, numOf5
	jr	$ra
get6WordNumber:
	la 	$v1, numOf6
	jr	$ra
get7WordNumber:
	la 	$v1, numOf7
	jr	$ra

#########################################################
#GETTER FUNCTIONS FOR NUMBER OF WORDS IN THE ARRAYS
#DESIRED NUMBER WILL BE IN $v1
#########################################################
getResultByte2:
	la 	$a1, resultByte2
	jr	$ra
getResultByte3:
	la 	$a1, resultByte3
	jr	$ra
getResultByte4:
	la 	$a1, resultByte4
	jr	$ra
getResultByte5:
	la 	$a1, resultByte5
	jr	$ra
getResultByte6:
	la 	$a1, resultByte6
	jr	$ra
getResultByte7:
	la 	$a1, resultByte7
	jr	$ra
#########################################################
#SUBTRACT ONE FROM THE TOTAL (WHEN YOU GUESS CORRECTLY)
#########################################################
sub2WordNumber:
	lw	$v0, numOf2
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf2
	jr	$ra
sub3WordNumber:
	lw	$v0, numOf3
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf3
	jr	$ra
sub4WordNumber:
	lw	$v0, numOf4
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf4
	jr	$ra
sub5WordNumber:
	lw	$v0, numOf5
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf5
	jr	$ra
sub6WordNumber:
	lw	$v0, numOf6
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf6
	jr	$ra
sub7WordNumber:
	lw	$v0, numOf7
	beq	$v0, 0, alreadyZero
	subi	$v0, $v0, 1		#increase the number of found words by 1
	sw	$v0, numOf7
	jr	$ra
	
alreadyZero:
	jr	$ra

printArrays:
	li	$v0, 4		# Print String Syscall
	la	$a0, mess2	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf2
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess3	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf3
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess4	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf4
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess5	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf5
	syscall
	
	beq	$s1, 5, return
	li	$v0, 4		# Print String Syscall
	la	$a0, mess6	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf6
	syscall
	
	beq	$s1, 6, return
	li	$v0, 4		# Print String Syscall
	la	$a0, mess7	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf7
	syscall
return:
	move	$ra, $sp
	addi	$sp, $sp, 4
	jr	$ra

printWordsLeft:
	
	move 	$t0, $a1		# Moves word length to $t0

	li	$v0, 4		# Print String Syscall
	la	$a0, mess2	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf2
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess3	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf3
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess4	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf4
	syscall
	li	$v0, 4		# Print String Syscall
	la	$a0, mess5	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf5
	syscall
	
	beq	$t0, 5, return2
	li	$v0, 4		# Print String Syscall
	la	$a0, mess6	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf6
	syscall
	
	beq	$t0, 6, return2
	li	$v0, 4		# Print String Syscall
	la	$a0, mess7	# Load Contents String
	syscall
	li 	$v0, 1
	lw	$a0, numOf7
	syscall
	
return2:
	jr $ra

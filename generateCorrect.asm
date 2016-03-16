.data
int_letters: 	.word		0:26	#int array that counts letters in given word
int_count:	.word		0:26	#int array that will compare the dictionary word to our word
result:		.space		1000000	#reserve one MB for array of resulting words
fnf:		.ascii  	"The file was not found: "
fileA:		.asciiz		"0.txt"
fileB: 		.asciiz		"1.txt"
fileC:		.asciiz		"2.txt"
fileD: 		.asciiz		"3.txt"
fileE: 		.asciiz		"4.txt"
fileF: 		.asciiz		"5.txt"
fileG: 		.asciiz		"6.txt"
fileH: 		.asciiz		"7.txt"
fileI: 		.asciiz		"8.txt"
fileJ: 		.asciiz		"9.txt"
fileK: 		.asciiz		"10.txt"
fileL: 		.asciiz		"11.txt"
fileM: 		.asciiz		"12.txt"
fileN: 		.asciiz		"13.txt"
fileO: 		.asciiz		"14.txt"
fileP: 		.asciiz		"15.txt"
fileQ: 		.asciiz		"16.txt"
fileR: 		.asciiz		"17.txt"
fileS: 		.asciiz		"18.txt"
fileT: 		.asciiz		"19.txt"
fileU: 		.asciiz		"20.txt"
fileV: 		.asciiz		"21.txt"
fileW: 		.asciiz		"22.txt"
fileX: 		.asciiz		"23.txt"
fileY: 		.asciiz		"24.txt"
fileZ: 		.asciiz		"25.txt"
ok: 		.byte		1			#This is a boolean that will check if a word is valid 0= true, 1 = false
cont:		.ascii  	"File contents: "
buffer: 	.space 		1000000
wordHolder:	.space		9			#maximum word length plus null terminator plus #
#estWord:	.asciiz		"addfg"		
#testWord:	.asciiz		"tryuipx"	

.text
.globl generateCorrect
generateCorrect:
##############################################################################
#generateCorrect FINDS ALL THE VALID WORDS IN A DICTIONARY ACCORDING TO 
#A SET OF LETTERS THAT ARE PASSED IN
##############################################################################
#li 	$a3, 7
#la 	$s7, testWord			#store the user input of length into $a3
	####################################################
	#UNCOMMENT THIS
	####################################################
move	$sp, $ra
move 	$s7, $a1
# Open File
add 	$t0, $zero, $zero

iterateDict:
	beq 	$t0, 26, finalClose	#if we reached the end of dict
	beq 	$t0, 0, loadA	#Othewise iterate over every dictionary file.
	beq	$t0, 1, loadB
	beq 	$t0, 2, loadC
	beq	$t0, 3, loadD
	beq 	$t0, 4, loadE
	beq	$t0, 5, loadF
	beq 	$t0, 6, loadG
	beq	$t0, 7, loadH
	beq 	$t0, 8, loadI
	beq	$t0, 9, loadJ
	beq 	$t0, 10, loadK
	beq	$t0, 11, loadL
	beq 	$t0, 12, loadM
	beq	$t0, 13, loadN
	beq 	$t0, 14, loadO
	beq	$t0, 15, loadP
	beq 	$t0, 16, loadQ
	beq	$t0, 17, loadR
	beq 	$t0, 18, loadS
	beq	$t0, 19, loadT
	beq 	$t0, 20, loadU
	beq 	$t0, 21, loadV
	beq	$t0, 22, loadW
	beq 	$t0, 23, loadX
	beq	$t0, 24, loadY
	beq 	$t0, 25, loadZ
	


#Jump Table to load the appropriate dictionary letter
loadA:
	la 	$a0, fileA
	j	open
loadB:
	la 	$a0, fileB
	j	open
loadC:
	la 	$a0, fileC
	j	open
loadD:
	la 	$a0, fileD
	j	open
loadE:
	la 	$a0, fileE
	j	open
loadF:
	la 	$a0, fileF
	j	open
loadG:
	la 	$a0, fileG
	j	open
loadH:
	la 	$a0, fileH
	j	open
loadI:
	la 	$a0, fileI
	j	open
loadJ:
	la 	$a0, fileJ
	j	open
loadK:
	la 	$a0, fileK
	j	open
loadL:
	la 	$a0, fileL
	j	open
loadM:
	la 	$a0, fileM
	j	open
loadN:
	la 	$a0, fileN
	j	open
loadO:
	la 	$a0, fileO
	j	open
loadP:
	la 	$a0, fileP
	j	open
loadQ:
	la 	$a0, fileQ
	j	open
loadR:
	la 	$a0, fileR
	j	open
loadS:
	la 	$a0, fileS
	j	open
loadT:
	la 	$a0, fileT
	j	open
loadU:
	la 	$a0, fileU
	j	open
loadV:
	la 	$a0, fileV
	j	open
loadW:
	la 	$a0, fileW
	j	open
loadX:
	la 	$a0, fileX
	j	open
loadY:
	la 	$a0, fileY
	j	open
loadZ:
	la 	$a0, fileZ
	j	open

open:
	li	$v0, 13		# Open File Syscall
	#la	$a0, ($t3)	# Load File Name
	li	$a1, 0		# Read-only Flag
	li	$a2, 0		# (ignored)
	syscall
	move	$s6, $v0	# Save File Descriptor
	blt	$v0, 0, err	# Goto Error
	
 
# Read Data
read:
	li	$v0, 14		# Read File Syscall
	move	$a0, $s6	# Load File Descriptor
	la	$a1, buffer	# Load Buffer Address
	li	$a2, 1000000	# Buffer Size
	syscall
	#addi 	$sp, $sp, -4	
	###########################################
	#CLOSE THE FILE BEFORE WORKING ON IT'S CONTENTS
	###########################################
	#j 	findValidWords
	j	close
	
continue:
	addi	$t0, $t0 1
	#addi 	$sp, $sp, 4
	j 	iterateDict

#First we have to count the occurance of every letter in our random word
#At this point in time generateAlphabet will have generated our word
#It will be stored in $a3
findValidWords:
add $s3, $zero, $zero		#$s3 will reset the temporary array, this is to guarantee that it is 0
add $s4, $zero, $zero		#$s4 will be the counter for this function
add $t8, $zero, $zero		#t8 will count the index of a particular word
add $t9, $zero, $zero		#t9 will keep track of the solutions array index

#####################################################################################
#CREATE BINARY ARRAY COUNTING LETTERS IN OUR GENERATED ALPHABET: DONE
#####################################################################################
countLetters:
	beq	$s4, $a3, reset1
	add	$t4, $s4, $s7	#$t4 is the address of the individual byte of the shuffled word
	lb	$t5, ($t4)	#$t5 is the value of $t4
	subi 	$t6, $t5, 97	#convert the asciiz to an alphabet index, now in $t6
	
	
	la	$t4, int_letters#$t4 is now base address of letters array
	add	$t5, $t4, $t6,	#$t5 is int_letters[letter]
	lb	$t6, ($t5)	#load the byte currently at that address so we can manipulate it
	addi 	$t6, $t6, 1	#increase the number of that byte by 1
	sb	$t6, ($t5)	#The value of that index location just increased by 1
	addi	$s4, $s4, 1	#increase the loop counter by 1
	j 	countLetters


#####################################################################################
#THE FRAMEWORK OF THE WORD CHECKING ALGORITHM					
#forEveryWord ITERATES OVER THE DICT FILE IN THE BUFFER CHAR BY CHAR
#AN NEW ARRAY MUST BE INITIALIZED IN EVERY ITERATION
#A BOOLEAN FLAG KEEPING TRACK OF VALID WORDS IS SET
#ENDS WHEN WE FIND THE "#" AT THE END OF EVERY DICTIONARY FILE
#IN JAVA IT IS
#for(String word: dict){
#            int []count = new int[26];
#            boolean ok = true;
#	     for(char c : word.toCharArray()){
#		COUNT THE LETTERS (OTHER FUCNTION)
#		}
#	    if(ok)
#		result.add(word)
#####################################################################################
forEveryWord:
	#beq 	$t6, 0, newLine
	beq 	$t6, 35, return2	#while not at the end of the buffer (#)
	add 	$s5, $zero, $zero
	jal	resetSecondArray	#reset the array that counts the dictionary to 0
	sb 	$zero, 	ok		#ok = true
	#for(char c : word.toCharArray()){
	lb	$s1, ok			#s1 = false
	jal 	forEveryLetterInWord
	addi 	$s4, $s4, 1
	lb 	$s1, ok
	add	$t2, $zero, $zero	#reset all the registers used in storing
	add 	$t7, $zero, $zero
	add	$s0, $zero, $zero
	beq	$s1, 1, forEveryWord
	beq	$s1, 0, addWord
	
#####################################################################################
#addWord STORES THE DICT. WORD THAT WE FOUND CORRECT INTO THE RESULTS ARRAY
#$t9 KEEPS TRACK OF THE ADDRESS THAT IS BEING USED TO STORE
#$s3 HOLDS THE ADDRESS TO THE result ARRAY
#THIS FUNCTION APPENDS THE WORD TO THE LAST BYTE IN results WHICH IS $t9
#####################################################################################
addWord:
	
	beq 	$s0, 10, forEveryWord	#$t7, stores the character at a given index in wordHolder $t2, 
	la	$s3, result		
	la	$t3, wordHolder
	add	$t2, $s3, $t9		#$t2 contains the address of the last written index in result
	add	$t7, $t3, $s5,		#register $t7 is address of wordHolder[i]
	lb 	$s0, ($t7)		#$s0 = value of wordHolder[i]
	sb	$s0, ($t2)		#result[-1] = wordHolder[i]
	addi 	$s5, $s5, 1		
	addi	$t9, $t9, 1
	add	$v0, $zero, $zero
	
	#Count the number of found solutions
	j 	addWord


#####################################################################################
#ITERATE UNTIL WE FIND A NEWLINE CHARACTER(EVERY WORD)
#CALCULATE THE INDEX OF THE WORD IN THE BINARY ARRAY
#INCREASE THE VALUE OF THE ARRAY AT THAT INDEX FOR EVERY LETTER
#IF THE WORD IS WRONG, DO NOTHING AND REACH THE END OF THE WORD
#IN JAVA THIS SECTION IS 
#for(char c : word.toCharArray()){
#                int index = c - 'a';
#                count[index]++;
#		 if(count[index] > avail[index]){
#####################################################################################
forEveryLetterInWord:
	#int index = c - 'a';
	add	$t5, $s4, $t4	#$t5 = buffer[i] address
	lb	$t6, ($t5)	#$t6 = letter at buffer[i]
	subi 	$t7, $t6, 97	#convert the asciiz to an alphabet index, now in $t6
	beq 	$t6, 10, storeNewline		#ifNewLineCharacter
	beq	$t6, 35, storePound		#Store # char
	beq	$t6, 13, byte13 		#get rid of pesky 13 character
	beq	$s1, 1, wordIsAlreadyIncorrect	#if dictionary word is already wrong, do nothing, move to the next character
	
	#count[index]++;
	la	$t3, int_count	#$t3 is now base address of second letters array
	add	$t2, $t3, $t7,	#$t2 is int_count[letter]
	lb	$t1, ($t2)	#load the byte currently at that address so we can manipulate it
	addi 	$t1, $t1, 1	#increase the number of that byte by 1
	sb,	$t1, ($t2)	#The value of that index location just increased by 1	
	
	#if(count[index] > avail[index])
	la 	$s6, int_letters
	add	$t2, $s6, $t7,	#$t2 is int_letters[letter]
	lb 	$t5, ($t2)
	bgt	$t1, $t5, wordIsIncorrect	#$t1 = dictionary; $t5 = our word
	
#HERE WE INSERT THE BYTE INTO THE PLACEHOLDER SPACE ARRAY
	#j 	printByteArray
	j	storeByte
	
	#j 	forEveryLetterInWord

#####################################################################################
#THIS FUNCTION ADDS THE CURRENT BYTE INTO A PLACEHOLDER SPACE ARRAY
#IF THE WORD STORED IN THIS ARRAY TURNS OUT TO BE CORRECT
#IT WILL LATER BE STORED INTO A LARGER ARRAY THAT HOLDS ALL THE
#CORRECT WORDS IN THE DICTIONARY FILE
#AT THIS POINT THE BYTE WILL BE IN $t6
#THE CORRECT INDEX IS STORED IN $s4

#####################################################################################
#s4 IS NOT GOING TO WORK NEED A REGISTER THAT RESETS WITH EVERY ITERATION
storeByte:
	la 	$t3, wordHolder
	#REPLACING $s4 WITH $t8
	add	$s3, $t8, $t3		#$s3 is the address of wordHolder[i]
	sb 	$t6, ($s3)		#store the letter at the right index in wordHolder
	addi 	$s4, $s4, 1		#the difference between $s4, and $t8 is that $t8 resets every word
	addi	$t8, $t8, 1		#$s4 resets every file
	j 	forEveryLetterInWord
	
storePound:
	la 	$t3, wordHolder		#STORE THE POUND SYMBOL
	add	$s3, $t8, $t3		#$s3 is the address of wordHolder[i]
	sb 	$t6, ($s3)		#store the letter at the right index in wordHolder
	add 	$t8, $zero, $zero	#reset the word address counter
	j 	forEveryWord
	
storeNewline:
	#REPLACING $s4 WITH $t8
	la 	$t3, wordHolder
	add	$s3, $t8, $t3		#$s3 is the address of wordHolder[i]
	sb 	$t6, ($s3)		#store the letter at the right index in wordHolder
	add 	$t8, $zero, $zero	#reset the word address counter
	j	return
	
storeWhenIncorrect:
	add	$s3, $t8, $t3		#$s3 is the address of wordHolder[i]
	sb 	$t6, ($s3)		#store the letter at the right index in wordHolder
	addi 	$s4, $s4, 1		#the difference between $s4, and $t8 is that $t8 resets every word
	addi	$t8, $t8, 1		#$s4 resets every file
	lb	$t6, ($t5)		#$t6 = letter at buffer[i]
	j 	forEveryLetterInWord

byte13:
	addi 	$s4, $s4, 1		#the difference between $s4, and $t8 is that $t8 resets every word
	j 	forEveryLetterInWord

#resetLoop:
#	add 	$t6, $zero, $zero
#	la	$t5, int_letters
#printByteArray:
#	lb 	$a0, ($t2)
#	li 	$v0, 1
#	syscall
##	addi 	$t6, $t6, 1	
#	j 	printByteArray


#####################################################################################
#IF THE NUMBER OF LETTERS IN THE DICT WORD($t5) IS LESS THAN THOSE OF OURS ($t1)
#SET THE FLAG EQUAL TO FALSE
#IN JAVA THIS IS:
#if(count[index] > avail[index]){
#                    ok = false;
#                    break;	
#####################################################################################

wordIsAlreadyIncorrect:
	add	$t5, $s4, $t4	#$t5 = buffer[i] address
	j	storeWhenIncorrect
wordIsIncorrect:
	slt 	$s1, $t5, $t1	#If the number of letters is the dict. word is greater than those of our word
	sb 	$s1, ok
	#addi 	$s4, $s4, 1
	j 	storeByte
	
#####################################################################################
#AT THIS POINT WE HAVE ALREADY EXHAUSTED THE DICTIONARY 
#AND WE MUST RETURN TO THE MAIN LOOP AND ADD THE WORD
#HERE WE RESTORE THE SAVED PC IN THE STACK AND RETURN TO THE TOP OF THE CONTROL FLOW
#####################################################################################
return:
	jr	$ra
return2:
	j	continue

#####################################################################################
#RESET1 CLEARS THE FOR LOOP COUNTERS TO BE USED IN THE DICT. COUNTING
#ONLY CALLED ONCE PER FILE
#####################################################################################
reset1:
	add 	$s4, $zero, $zero		#$s4 will be the counter for this function
	add 	$t5, $zero, $zero
	add 	$t6, $zero, $zero
	la 	$t4, buffer
	lb 	$t6, ($t4)
	j 	forEveryWord
#####################################################################################
#RESET2 CLEARS THE TEMPORARY ARRAY THAT COUNTS DICT. LETTERS
#CALLED ONCE PER WORD
#####################################################################################
resetSecondArray:
add 	$s5, $zero, $zero
j 	ressetSecondArray

ressetSecondArray:
	la 	$s6, int_count
	beq	$s5, 26, reset2
	#$s3 will be 0 when this function starts 
	add	$t5, $s5, $s6	#$t4 is int_count index address
	#li	$v0, 1
	#lb	$a0, ($t5)
	#syscall
	sb	$zero, ($t5)	#replace the value at int_count[index] with 0
	#la 	$a0, ($t5)
	#syscall
	#lb	$a0, ($t5)
	#syscall
	addi	$s5, $s5, 1	#increase the loop counter by 1
	j 	ressetSecondArray	
reset2:
	add 	$s3, $zero, $zero		#$s4 will be the counter for this function
	add 	$s5, $zero, $zero		#$s4 will be the counter for this function
	la 	$t4, buffer
	jr	$ra
	


#####################################################################################
#HELPER FUCNTIONS FOR THE DICTIONARY
#####################################################################################
# Print Data
print:
	li	$v0, 4		# Print String Syscall
	la	$a0, cont	# Load Contents String
	syscall
	#j	findValidWords

# Close File
close:
	li	$v0, 16		# Close File Syscall
	move	$a0, $s6	# Load File Descriptor
	syscall
#	j	done		# Goto End
	#addi 	$t0, $t0, 1
	#j	iterateDict
	j 	findValidWords

# Error
err:
	li	$v0, 4		# Print String Syscall
	la	$a0, fnf	# Load Error String
	syscall
# Done

finalClose:
	li	$v0, 16		# Close File Syscall
	move	$a0, $s6	# Load File Descriptor
	syscall
	la 	$s2, result
	move	$ra, $sp
	addi	$sp, $sp, 4
	jr	$ra

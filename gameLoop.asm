.data
prompt: .asciiz "\nEnter a word (? to rearrange, # to view words left, and $ to view bad guesses): "
prompt2: .asciiz "\nPoints: "
prompt3: .asciiz "\nCorrectly guessed words:\n"
prompt4: .asciiz "\nIncorrect guesses:\n"
badWord: .asciiz "\nThat is not a word or already guessed.\n"
testprompt: .asciiz "\nSplited valid word array: "
yourLettersDisplayMess: .asciiz "\nYour letters are: "
winMess: .asciiz "Congratulations! You won!"
wordLength: .word 0
inputWord: .space 9
key1: .byte 1
menuaddress: .word 0
correctLength: .byte 0
correct: .space 512
incorrect: .space 512
.text
.globl inputLoop, validWord, inputWord, countInputLetters, badWordFunc

inputLoop:
addi $sp, $sp, -12
li $s7, 0
lb $t0, key1
beq $t0, 1, LoadArgument

#Score display  $k0 = score
li $v0, 4
la $a0, prompt2
syscall
li $v0, 1
la $a0, ($k0)
syscall

# Displays word already guessed by user
li $v0, 4
la $a0, prompt3
syscall
jal printall

# Beings display of scrambled letters
jal getWordLength
move $t0, $a0

beq $t0, 5, display5Word	# Branches if word is 5 letters
beq $t0, 6, display6Word	# Branches if word is 6 letters

jal get7WordRandom	# Loads 7 letter word if word was not 5 or 6 letters long
j printWordToGuess	# Jumps to print word

display5Word:
jal get5WordRandom
j printWordToGuess	# Jumps to print word

display6Word:
jal get6WordRandom

printWordToGuess:
li $v0, 4				# Loads print string
la $a0, yourLettersDisplayMess		# Loads address of string array
syscall					# Prints the message

li $v0, 4		# Loads print string
move $a0, $v1		# Moves address of randomized word into $a0
syscall			# Prints the word


#Display message for user to input guess
li $v0, 4
la $a0, prompt
syscall

li $v0, 8		# String input
li $a1, 9		# Number of chracters to accept
la $a0, inputWord	# Stores user input into inputWord
syscall 

##################### 
lw $t8, maxinputLength
jal countInputLetters
bgt $a3, $t8, badWordFunc    # if input Length> max valid word Length branch to bad word
la $a3, 0
#####################

# Checks for letter rearangement
# use $a0 for current word
# use $a1 for word length
la $t0, inputWord	# Loads address of user input
lb $t1, ($t0)		# $t1 = $t0 value
beq $t1, 63, wreg	# Branches if $t1 = ?

beq $t1, 35, printWLeft	# If user input #, displays number of words left to guess
beq $t1, 36, Inputcheck	# Display incorrect guessed word if equals $
beq $t1, 42, Cheat	# Display Splitted valid word array

jal countInputLetters		# Counts the number of user input characters for branching

# $a3 contains the user's inputed word length
beq $a3, 2, userInputTwoLetters
beq $a3, 3, userInputThreeLetters
beq $a3, 4, userInputFourLetters
beq $a3, 5, userInputFiveLetters
beq $a3, 6, userInputSixLetters
beq $a3, 7, userInputSevenLetters

j badWordFunc		# If the user input length does not match the previous criteria, will jump to bad word for invalid user input

userInputTwoLetters:
jal get2WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte2	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

j badWordFunc		# Branches to badWord if word was not guessed

userInputThreeLetters:
jal get3WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte3	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

j badWordFunc		# Branches to badWord if word was not guessed

userInputFourLetters:
jal get4WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte4	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

j badWordFunc		# Branches to badWord if word was not guessed

userInputFiveLetters:
jal get5WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte5	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

j badWordFunc		# Branches to badWord if word was not guessed

userInputSixLetters:
jal get6WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte6	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

j badWordFunc		# Branches to badWord if word was not guessed

userInputSevenLetters:
jal get7WordArray	# Calls function for obtaining address of array and guessed word array
move $a0, $v1		# Moves address of word array into $a0
jal getResultByte7	# Loads word is guessed array into $a1
jal WordCheck		# Jumps to word checker loop

# Informs user of bad guess or already found word
badWordFunc:
li $v0, 4
la $a0, badWord
syscall
jal loseSound
addi $sp, $sp, 12

#############
#Load incorrect input to incorrect label
la $t8, incorrect   #t8 = incorrect guess array
la $t9, inputWord   #t9 = user input
loop2:
lb $t0, ($t8)       #Load inccorrect array
beq $t0, 0, exit4   # exit loop if t0 = 0
addi $t8, $t8,1     # move t8 to next location
j loop2
exit4:
lb $t1, ($t9)       # load user input to t1
beq $t1, 0, exit5   # exit at the end of user input
sb $t1, ($t8)       # save letter from userinput to incorrect array
addi $t8, $t8,1     #move t8 to next
addi $t9, $t9,1     # move t9 to next 
j exit4
exit5:
addi $t9, $0, 32    #add 32 = space
sb $t9, ($t8)       #add space between word
j inputLoop
##############

validWord:
#################
#Load correct input to correct label
la $t8, correct     #t8 = correct guess array
la $t9, inputWord   #t9 = user input
loop1:
lb $t0, ($t8)       #Load correct array
beq $t0, 0, exit1   # exit loop if t0 = 0
addi $t8, $t8,1     # move t8 to next location
j loop1
exit1:
lb $t1, ($t9)       # load user input to t1
beq $t1, 0 ,exit2   # exit at the end of user input
sb $t1, ($t8)       # save letter from userinput to correct array
addi $t8, $t8,1     # move t8 to next
addi $t9, $t9,1     # move t9 to next
j exit1
exit2:
addi $t9, $0, 32    # add 32 = space
sb $t9, ($t8)       # add space between word
#############
add $t0, $zero, 1	# Store 1 to $t0

sb $t0, ($t7)		# Marks guessed word as true
jal winningSound
li $s7, 1
addi $sp, $sp, 12

# Begin decrement of valid words left to guess
jal countInputLetters	# $a3 contains return of number of letters user input
add $k0, $k0, $a3	# add length of input to user score
lw $a1, wordLength	# Loads word length to $a1

# Branches to decrement number of valid word based on word that was guessed
beq $a3, 2, sub2	# Branches if 2 letter word was guessed
beq $a3, 3, sub3	# Branches if 3 letter word was guessed
beq $a3, 4, sub4	# Branches if 4 letter word was guessed
beq $a3, 5, sub5	# Branches if 5 letter word was guessed
beq $a3, 6, sub6	# Branches if 6 letter word was guessed

jal sub7WordNumber	# If did not branch, was a valid 7 letter word
j	checkIfWin

sub2:		# Decrements by 1 then return to beginning for next input
jal sub2WordNumber
j	checkIfWin

sub3:		# Decrements by 1 then return to beginning for next input
jal sub3WordNumber
j	checkIfWin

sub4:		# Decrements by 1 then return to beginning for next input
jal sub4WordNumber
j	checkIfWin

sub5:		# Decrements by 1 then return to beginning for next input
jal sub5WordNumber
j	checkIfWin

sub6:		# Decrements by 1 then return to beginning for next input
jal sub6WordNumber
j	checkIfWin

wreg:
jal getWordLength
move $a1, $a0
jal WordRearrange
addi $sp, $sp, 12
j inputLoop

menu:
addi $sp, $sp, 20
li $s0, 1
sb $s0, key1
li $s0, 0
j main

LoadArgument: # so it will not load again after the first input
sw $a0, wordLength
sb $0, key1
move $s3 , $a2
la $s5, ($a3)
j inputLoop

Inputcheck:
# Displays incorrect word guesses
li $v0, 4
la $a0, prompt4
syscall
li $v0, 4
la $a0, incorrect
syscall
j inputLoop

# Loops counts the number of characters that the user input
countInputLetters:
la $t7, inputWord	# Loads address of user input
li $t1, 0		# Sets $t1 = 0 for counting letters of user input

countInputLettersLoop:
lb $t0, ($t7)				# Loads first letter of user input
beq $t0, 10, countInputLettersLoopExit	# Exits if new line character is found

add $t7, $t7, 1				# Increments user input to next byte
add $t1, $t1, 1				# Counts 1 letter
j countInputLettersLoop			# Loops for next character check

# Loads value for input letters to $a3, then returns to register location in $ra
countInputLettersLoopExit:
add $a3, $t1, $zero
jr $ra

printWLeft:
jal printWordsLeft
j inputLoop

# Displays the words loaded into the arrays to the user
Cheat:
li $v0, 4
la $a0, testprompt
syscall
li $v0, 4
la $a0, result2
syscall
li $v0, 4
la $a0, result3
syscall
li $v0, 4
la $a0, result4
syscall
li $v0, 4
la $a0, result5
syscall
li $v0, 4
la $a0, result6
syscall
li $v0, 4
la $a0, result7
syscall

li $v0, 1
lw $a0, maxinputLength
syscall
j inputLoop

checkIfWin:
	jal 	getWordSum
	lw 	$a0, wordLength
	beq 	$v0, 0, weWon
	j 	inputLoop	
	
weWon:
	li	$v0, 4		# Print String Syscall
	la	$a0, winMess	# Load Contents String
	syscall
	li	$v0, 10
	syscall

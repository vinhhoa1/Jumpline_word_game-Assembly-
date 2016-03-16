.text
.globl WordCheck

# Begins word check loop of array
WordCheck:
li $t0, 0		# Sets value to 0 before use
li $t2, 0		# Sets value to 0 before use
li $t7, 0		# Sets value to 0 before use
	
add $t0, $a0, $zero	# Loads word array to register
add $t7, $a1, $zero	# Loads word tracker to register
la $t1, inputWord	# Loads user input to register
lb $t6, ($t7)		# Loads value (if word is guessed) to register

CharacterLoop:
beq $t6, 1, skipWord	# If word is guessed the word is skipped over
lb $t2, ($t0)		# Loads character from word array
lb $t3, ($t1)		# Loads character from user input

beq $t2, 35, return	# Checks for end of array, branches to return if true
beq $t2, 10, ExitCharacterLoop	# Exits loop at end of user input word
bne $t2, $t3, noMatch		# If characters do not match loop exits

add $t0, $t0, 1		# Increments array word character by 1
add $t1, $t1, 1		# Increments user input word by 1 character

j CharacterLoop		# Returns to beginning of loop to check next characters

skipWord:
add $t0, $t0, $a3	# Increments word array to next word
add $t7, $t7, 1		# Increments guessed word array to next byte
lb $t6, ($t7)		# Loads value (if word is guessed) to register
j CharacterLoop

# On word loop exit, reset registers to prepare for next word
ExitCharacterLoop:
beq $t2, $t3, validWord	# If characters match at this point they are the same word, and input is valid
add $t0, $t0, 1		# Increments word array to the next word
la $t1, inputWord	# Reloads address of userinput to register
add $t7, $t7, 1		# Increments guessed word array to next byte
lb $t6, ($t7)		# Loads into $t6 is word is guessed or not
j CharacterLoop

# If the user input did not match the array, this loop will increment the array to the next word
noMatch:
beq $t2, 35, return	# Checks for end of array, branches to return if true
add $t0, $t0, 1		# Increments word array to the next char
lb $t2, ($t0)
bne $t2, 10, noMatch	# As long as it's not new line jump
la $t1, inputWord	# Reloads address of userinput to register
add $t7, $t7, 1
lb $t6, ($t7)
j CharacterLoop

return: 
jr $ra			# Returns to check next array
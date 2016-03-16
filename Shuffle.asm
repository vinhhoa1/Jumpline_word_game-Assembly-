.text
.globl WordRearrange

WordRearrange:
add $sp, $sp, -4 	# Decrements stack
move $sp, $ra		# Saves jump return address to stack
add $t2, $0, $0
add $t1, $0, $0
add $t3, $0, $0

#la $t0, ($a0)		# Loads word address
#la $t7, ($a0)		# Loads word address into $t7 also
move $t5, $a1		# Loads word length
li $t6, 0		# Sets starting position

beq $t5, 5, load5
beq $t5, 6, load6
beq $t5, 7, load7

load5:
	jal 	get5WordRandom
	la 	$t0, ($v1)		# Loads word address
	la 	$t7, ($v1)		# Loads word address into $t7 also
	j	startLoop
load6:
	jal 	get6WordRandom
	la 	$t0, ($v1)		# Loads word address
	la 	$t7, ($v1)		# Loads word address into $t7 also
	j 	startLoop
load7:
	jal 	get7WordRandom
	la 	$t0, ($v1)		# Loads word address
	la 	$t7, ($v1)		# Loads word address into $t7 also
	j	startLoop

startLoop:
beq $t5, $t6, exit
jal random		# Calls random function, interget is returned in $t1
add $t2, $t7, $t1	# $t2 = random array index address
lb $t3, ($t2)		# $t3 = value at array index
lb $t4, ($t0)		# $t4 = word[0]
sb $t4, ($t2)		# Stores word[0] into memory
sb $t3, ($t0)		# Loads original index character to swapped location character
add $t0, $t0, 1		# Increments $t0 to next location
add $t6, $t6, 1		# Increments LCV by 1
j startLoop

# Gets random number between index position and end of word position
random:
move $a0, $t6	# Sets lower bounds of random #
move $a1, $t5	# Sets upper random length to word length
li $v0, 42
syscall

move $t1, $a0
jr $ra

exit:
move $ra, $sp		# Gets PC location from stack
add $sp, $sp, 4		# Increments stack
jr $ra

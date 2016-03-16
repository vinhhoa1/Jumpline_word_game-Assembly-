.data
start: .asciiz "start of printall  "
badWord: .asciiz "That is not a word or already guessed.\n"
ha: .asciiz "  thats all folks\n"
#word1: .asciiz "Bard\n", "Word\n", "Flag\n", "#"
#word2: .asciiz "Bards\n", "Words\n", "Flags\n", "#"
#word3: .asciiz "Bardss\n", "Wordss\n", "Flagss\n", "#"
#word4: .asciiz "Bardsss\n", "Wordsss\n", "Flagsss\n", "#"
bl: .asciiz "-"
spaces: .asciiz "     "
bspace:.asciiz " "
line:.asciiz"\n"

#word4Guess: .byte 1, 0, 1, 0
#word3Guess: .byte 0, 1, 0, 0
#word2Guess: .byte 0, 0, 0, 0
adone: .byte 0, 0, 0, 0, 0, 0, 9 #if the array has already hit its # symbol
.text


	#jal get3WordArray
	#li $v0, 11
	#lb $t4,0($v1)
	#move $a0, $t4
	#syscall
	
	#li $v0, 4
	#move $a0, $v1
	#syscall
	.globl printall 
printall:
la $a3,($ra)
li $v0,4
jal getWordLength
la $t9,adone
li $t8,2

jal get2WordArray

move $a0,$v1
lb $t0,($a0)
#syscall
li $v0,4
la $a0,line 
#syscall
li $v0,4
bne $t0,0, check3
sb $t8,($t9)

check3:
addi $t9,$t9,1
jal get3WordArray
li $v0,4
move $a0,$v1
lb $t0,($a0)
#syscall
bne $t0,0, check4
sb $t8,($t9)
check4:
addi $t9,$t9,1
jal get4WordArray
li $v0,4
move $a0,$v1
#syscall
lb $t0,($a0)
bne $t0,0, check5
sb $t8,($t9)
check5:
addi $t9,$t9,1
jal get5WordArray
move $a0,$v1
#syscall
lb $t0,($a0)
bne $t0,0, check6
sb $t8,($t9)

check6:
addi $t9,$t9,1
jal get6WordArray
move $a0,$v1
lb $t0,($a0)
#syscall
bne $t0,0, check7
sb $t8,($t9)

check7:
addi $t9,$t9,1
jal get7WordArray
move $a0,$v1
lb $t0,($a0)
#syscall
bne $t0,0, check8
sb $t8,($t9)
la $a0,line
check8:

li $t9,0
li $t8,0
loop:
#2 letter word
#la $a1, word1Guess
#la $a0, word1

la $t0,adone
lb $t0,($t0)
beq $t0,2,print3

jal get2WordArray
jal getResultByte2
move $a0,$v1
mul $t8,$t9,3

add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,2
li $t7,0
bne $t0,1,continue2
li $t7,0
jal pbspace
li $v0,4
la $a0,spaces
syscall
j print3
continue2:
li $t0,0
li $t3,0

add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader

li $v0,4
la $a0,spaces
syscall

#3 letter word
#la $a1, word2Guess
#la $a0, word2
print3:
la $t0,adone
lb $t0,1($t0)
beq $t0,2,print4
jal getResultByte3
jal get3WordArray
move $a0,$v1
mul $t8,$t9,4
add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,3
li $t7,0
bne $t0,1,continue3
li $t7,0
jal pbspace
li $v0,4
la $a0,spaces
syscall
j print4
continue3:
li $t0,0
li $t3,0

add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader

li $v0,4
la $a0,spaces
syscall

#6 letter word
#la $a1, word3Guess
#la $a0, word3
print4:
la $t0,adone
lb $t0,2($t0)
beq $t0,2,print5
jal getResultByte4
jal get4WordArray
move $a0,$v1
mul $t8,$t9,5
add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,4
li $t7,0
bne $t0,1,continue4
li $t7,0
jal pbspace
li $v0,4
la $a0,spaces
syscall
j print5
continue4:
li $t0,0
li $t3,0

add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader

li $v0,4
la $a0,spaces
syscall

#7 letter word
#la $a1, word4Guess
#la $a0, word4
print5:
la $t0,adone
lb $t0,3($t0)
beq $t0,2,print6
jal get5WordArray
jal getResultByte5
move $a0,$v1
li $v0,4
mul $t8,$t9,6
add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,5
li $t7,0
bne $t0,1,continue5
li $t7,0
jal pbspace
li $v0,4
la $a0,spaces
syscall
j print6
continue5:
li $t0,0
li $t3,0

add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader

li $v0,4
la $a0,spaces
syscall

print6:
jal getWordLength
move $t7,$a0
blt $t7,6,endOfRow
la $t0,adone
lb $t0,4($t0)
beq $t0,2,print7
jal getResultByte6
jal get6WordArray
move $a0,$v1
mul $t8,$t9,7
add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,6
li $t7,0
bne $t0,1,continue6
li $t7,0
jal pbspace
li $v0,4
la $a0,spaces
syscall
j print7
continue6:
li $t0,0
li $t3,0
add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader

li $v0,4
la $a0,spaces
syscall
print7:
jal getWordLength
move $t7,$a0
blt $t7,7,endOfRow
la $t0,adone
lb $t0,5($t0)
beq $t0,2,endOfRow
jal get7WordArray
jal getResultByte7
move $a0,$v1
mul $t8,$t9,8
add $a0,$a0,$t8
mul $t9,$t9,2
add $a1,$a1,$t9
div $t9,$t9,2
li $t4,7
li $t7,0
bne $t0,1,continue7
jal pbspace
li $v0,4
la $a0,spaces
syscall
j endOfRow
continue7:
li $t0,0
li $t3,0
add $t3,$a1,0
lb $t3,($t3)
add $t0,$a0,0
jal wordReader
endOfRow:

li $v0,4
la $a0,line

syscall
jal getWordLength
la $t1,adone
move  $t7,$a0
addi $t0,$t7,-2
li  $t3,0
jal exit
add $t9,$t9,1

j loop

exit:
bgt $t3,$t0, dexit
lb $t4,($t1)
beq $t4,0,eexit
addi $t1,$t1,1
addi $t3,$t3,1
j exit

dexit:
la $ra,($a3)
beq $t4,0,eexit
sb $zero,($t1)
addi $t1,$t1,-1
lb $t4,($t1)
j dexit
eexit:
jr $ra



wordReader:
lb $t2, -1($t0)#t0 has the word
beq $t2,0x23,endrow
lb $t7, 1($t0)#t0 has the word
lb $t2, ($t0)#t0 has the word

bne $t7,0x23,continue
beq $t2,0,endrow
continue:
beq $t2,0,endrow
beq $t2,0x23,endrow
li $t7,0
beq $t3,0,blanks
 

beq $t2, 10, return
li $v0, 11#print byte\char
add $a0, $t2, $zero#print wahtever letter is in thing
syscall


add $t0, $t0, 1
#add $t1, $t1, 1

j wordReader

blanks:

beq $t4,$t7,return
li $v0,4
la $a0,bl
syscall
addi $t7,$t7,1
j blanks

pbspace:
beq $t4,$t7,return
li $v0,4
la $a0,bspace
syscall
addi $t7,$t7,1
j pbspace

endrow:
bne $t2,0x23,continuep
la $s2,($ra)
jal pbspace
la $ra,($s2)
continuep:
addi $t5,$t4,-2
la $a2,adone
add $a2,$a2,$t5
li $t5,1
sb $t5,($a2)
j return
return: 
jr $ra

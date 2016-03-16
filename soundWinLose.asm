.data
win: .asciiz "Generating win sound\n"
lose: .asciiz "Generating lose sound\n"

.text
.globl winningSound, loseSound

winningSound:
#print message
li $v0, 4
la $a0, win
syscall

#play note
li $v0, 31#syscall
li $a0, 78#pitch
li $a1, 150#duriation 1000 = 1 second
li $a2, 0#instrument 0 = piano
li $a3, 100#volume
syscall

#rest
li $v0, 32#syscall
li $a0, 100#pitch
syscall

#play note
li $v0, 31#syscall
li $a0, 78#pitch
li $a1, 150#duriation 1000 = 1 second
li $a2, 0#instrument 0 = piano
li $a3, 100#volume
syscall

#rest
li $v0, 32#syscall
li $a0, 100#pitch
syscall

#play note
li $v0, 31#syscall
li $a0, 80#pitch
li $a1, 1000#duriation 1000 = 1 second
li $a2, 0#instrument 0 = piano
li $a3, 100#volume
syscall
jr $ra

############################################
loseSound:
li $v0, 4
la $a0, lose
syscall

li $v0, 31#syscall
li $a0, 58#pitch
li $a1, 250#duriation 1000 = 1 second
li $a2, 56#instrument 0 = piano
li $a3, 100#volume
syscall

#rest
li $v0, 32#syscall
li $a0, 150#pitch
syscall

#play note
li $v0, 31#syscall
li $a0, 54#pitch
li $a1, 700#duriation 1000 = 1 second
li $a2, 56#instrument 0 = piano
li $a3, 100#volume
syscall
jr $ra


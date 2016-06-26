# Jumpline_word_game-Assembly-

Program Description

        	The program the team had to write is a simplified version of the Android/iOS mobile game called Jumbline2. In the game, the player is asked if they want to play with five, six, or seven letters. The program then randomly generates X number of letters, depending on the user selection. After that, the program scans a dictionary and returns the words that can be formed using that set of random letters, along with the amount of each words found in the dictionary according to their length. At this point, the player must input a word guess on what they think is a word that can be assembled from that random set of letters. If the user input matches a word found in the dictionary, the program updates the score according to the length of the guess, and then plays a win sound. If the guess was incorrect, the game plays a loser sound. When a correct guess has been made, the game displays the word along with all the other correct guesses, and reduces the number of remaining words in that length category by 1. The game ends when the player has correctly guessed all the words in every length category. 

User’s manual

How to run the game:
Run Mars4_5-James inside the folder(you can’t use the normal version)
Click file- > open
Open the files: gameLoop.asm, Shuffle, print_all.asm, Runthis.asm, soundWinLose.asm, WordChecker.asm, generateAlphabet.asm, generateCorrect.asm, splitArrays.asm, 
Assemble and run Runthis.asm file.
Play the game.
How to play:

When you first run the game, it will ask you for input. Enter how long should the the word you want to play be. For example, if you want to play 5 letters word, enter 5, same thing with 6 and 7. (The game will let you know if you enter the wrong input)
Enter 100 if you want to quit the game.
Please dont enter anything else beside 5, 6, 7, or 100. If you do, the game will tell you it an invalid input.
Then the game will generate a set of random letters  and display on the screen.
Enter a valid word that can be made using those random alphabets. If your guess is correct, you will get a score according to the word’s length.
The game has 3 more option to help you. 
Enter ? to rearrange the word
Or enter $ to display incorrect guessed word 
Enter # to displays number of words left to guess
Once there is no more word to guess, the game will congratulate you for winning the game and end the game.

Note:
If you are stuck and want to see all the correct answers,  enter * to display all the valid word (also for for testing purposes).
The dictionary was originally 250k words in length. Many words had to be pruned into order to achieve a playable runtime, so some common words may not be available as guesses


Group project

Contributions<br />
+David Orozco – generateAlphabet, generateCorrect, splitArrays, soundWinLose<br />
+Eddvar Guzman - printall<br />
+Hoa P Nguyen - Runthis.asm, score counting function, correct and incorrect word array, cheat option, part of word rearrange function.<br />
+Marcus Karl - gameLoop.asm, Shuffle.asm, WordCharacterCheck.asm

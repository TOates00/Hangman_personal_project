% this program lets the user play hang man
fprintf('This program allows the user to play hangman against the ')
fprintf('computer, picking 1 of 9886 random words from a dictionary\n')


% lets the user pick a word from a dictionary word back using the function
% dictionaryLookup
pickWord=input('Pick a number for your hangman word: ');
% required manual input of dictionary length (9886) as dictionary_long is
% not used in the program (only the function)
% isnumeric function taken from: 
% https://au.mathworks.com/help/matlab/ref/isnumeric.html
isNum=isnumeric(pickWord);
while pickWord<1 || pickWord>9886 | isNum~=1
    pickWord=input('Pick a number BETWEEN 1 and 9886 most common words for your hangman word: ');
    isNum=isnumeric(pickWord);
end

% runs the function dictionaryLookup and assigns wordPicked with the return
% value
wordPicked=dictionaryLookup(pickWord);
% initialises a variable to determine whether or not the word was shown
showedWord=0;
% displays the hangman word if asked
fprintf('Would you like to see your word? (y for yes): ')
showWord=input('','s');
if showWord=="y"|showWord=="yes"|showWord=="Y"|showWord=="Yes"|showWord=="YES"
    disp(wordPicked)
    showedWord=1;
end

% converts the chosen word into a vector or characters for individual
% letter comparisons (later in the cord)
% Taken from https://au.mathworks.com/help/matlab/ref/char.html
wordPicked=char(wordPicked);

% prompts the user for the maximum number of incorrect guesses the user 
% would liked to be allowed. Ensures this is positive
guessNumber=input('Enter incorrect guess limit: ');
while guessNumber<1
    guessNumber=input('Enter a positive incorrect guess limit: ');
end
    
% initialises the vector of usedCharacters, the variable containing the
% number of guesses and number of correctGuesses
usedCharacters={};
guesses=0;
correctGuesses=0;
wordGuessCorrect=0;

% initialises current guess and displays initial word format using the
% length of the picked word
currentGuess=[];
for word=1:length(wordPicked)
    currentGuess=[currentGuess '-'];
end
fprintf('Your current word format is: ')
fprintf(currentGuess)
fprintf('\n')

% uses a while loop to ask the user for a character guess when incorrect 
% guesses is less than specified guess limit AND the correct guesses is 
% less than the length of the word picked %(i.e. all the characters of the 
% word and hence the word has been guessed).
while guesses<guessNumber && correctGuesses<length(wordPicked) && wordGuessCorrect~=1
   
    % sets up an array formatting the size of the used characters
    [numRows, numCols]=size(usedCharacters);
    % prompts the user for their guess and converts it to lower case
    guess=input('Enter a character: ', 's');
    guess=lower(guess);
    % checks if the guess is one character long, and that character is in
    % the alphabet (i.e. not a number or special character). Makes the user
    % to repeat their guess until it is.
    % Taken from https://au.mathworks.com/help/matlab/ref/isstrprop.html
    isLetter=isstrprop(guess,'alpha');
    while isLetter~=1|length(guess)~=1
        guess=input('Enter a SINGLE LETTER: ','s');
        guess=lower(guess);
        isLetter=isstrprop(guess,'alpha');
    end
    % compares the guess, to the characters already guessed
    compareChosen=strcmp(guess,usedCharacters);

    % initialises a temporary value and changes it to one if any of the
    % columns of the compared chosen letters is equal to the true. Simply, 
    % this checks if any of the word's characters is equal to any of the 
    % chosen characters. Refined loop as array compareChosen is always 1 row
    temp=0;
            for col=1:length(usedCharacters)
                % isequal compares the two values compareChosen to 1
                % isequal taken 
                % from https://au.mathworks.com/help/matlab/ref/isequal.html
                if isequal(compareChosen(col),1)
                    temp=1;
                end
            end
    
    % sets compareCorrect to a logical value 1 if guess and work picked are
    % equivalent (i.e. the guess is correct) and 0 otherwise.
    compareCorrect=(guess==wordPicked);
    
    % conditional execution for all non-duplicate characters
    if temp==0
        % loop for the length of the word, if the compareCorrect is equal
        % to 1 (i.e. character is in the word), do:
        for l=1:length(wordPicked)
            if isequal(compareCorrect(l),1)
                % prints 'Correct guess' to show the letters match
                fprintf('Correct guess\n')
                % sets the temporary value to 2 (used later)
                temp=2;
                % increments correctGuesses
                correctGuesses=correctGuesses+1;
                % sets currentGuess (i.e. displayed character) to this
                % guessed character
                currentGuess(l)=guess;
            end
        end
    end
    
    % for all guesses where temp is 0 or 2 (character hasn't been guessed
    % before, or character hasn't been guessed before and is correct), add
    % this character to the guessed characters vector
    if temp==0 || temp==2
        usedCharacters=[usedCharacters guess];   
    end    
    
    % if the guess is unique and incorrect add this to the guesses variable
    % (number of incorrect guesses)
    if temp==0
        guesses=guesses+1;
    end
    guessesLeft=guessNumber-guesses;
    
    % displays the characters you have used  
    fprintf('The characters you have used are: ')
    disp(usedCharacters)
    % displays the number of incorrect guesses the user has made
    fprintf('The number of incorrect guesses you have made is: %d\n',guesses)
    % displays the number of incorrect guesses before you lose
    fprintf('The number of incorrect guesses left is: %d\n',guessesLeft)
    % displays the current word format 
    fprintf('Your current word format is: ')
    disp(currentGuess)

    % asks the user if they would like to guess their word in full
    % explained in full in t11
    if guesses<guessNumber
        guessWord=input('Would you like to guess the word? (This will count as one incorrect guess if you fail): ','s');
    else
        guessWord='n';
    end
        if (guessWord=="y"|guessWord=="yes"|guessWord=="Y"|guessWord=="Yes"|guessWord=="YES")&guesses<=guessNumber
        
            wordGuess=input('Please guess the word: ','s');
            if strcmp(wordGuess,wordPicked)
                wordGuessCorrect=1;
                fprintf('Your guess was correct!\n')
            else
                fprintf('Your guess was incorrect\n')
                guesses=guesses+1;
                guessesLeft=guessNumber-guesses;
                fprintf('The number of incorrect guesses you have made is: %d\n',guesses)
                fprintf('The number of incorrect guesses left is: %d\n',guessesLeft)
            
                if guesses<guessNumber
                    guessAgain=input('Would you like to guess the word again?: ','s');
                else
                    guessAgain='n';
                end
                    while (guessAgain=="y"|guessWord=="yes"|guessWord=="Y"|guessWord=="Yes"|guessWord=="YES")&guesses<guessNumber
                        wordGuess=input('Please guess the word: ','s');
                            if strcmp(wordGuess,wordPicked)
                                wordGuessCorrect=1;
                                fprintf('Your guess was correct!\n')
                            else
                                guesses=guesses+1;
                                guessesLeft=guessNumber-guesses;
                                fprintf('The number of incorrect guesses you have made is: %d\n',guesses)
                                fprintf('The number of incorrect guesses left is: %d\n',guessesLeft) 
                            end
                        if guesses<guessNumber
                            guessAgain=input('Would you like to guess the word again?: ','s');
                        else
                            guessAgain='n';
                        end
                    end    
            end
        end

end

% displays a message and picture depending on whether or not the user won
% the game of hangman. Refined from t10.
% updated using t11 wordGuessCorrect variable to test win statement
if correctGuesses>=length(wordPicked)||wordGuessCorrect==1
    fprintf('You win \n\n')
    imshow('hangman_win.jpg');
else
    fprintf('You lose \n\n')
    if showedWord~=1
        % displays target word in all capitals if it wasn't displayed
        % earlier
        fprintf('The word you were guessing was: %s \n\n',upper(wordPicked))
    end
    imshow('hangman_lose.jpg');
end

fprintf('Code written by Thomas Oates')


%{
LIMITATIONS
The program fails if you do any of the following:
For pickWord AND guessNumber enter a non-ASCII character, special character, 
empty entry or blank entry (i.e. space with no letters). If the pickWord 
entry contains multiple letters/numbers an error is displayed, but the 
input runs again
If guessNumber is entered as a decimal (not whole number), it automatically
rounds the value.
If the input for guess is empty (either all spaces or no entry) the program
will crash

showWord and guessWord only work (display) for 4 different type of yes
entries, otherwise default is no.

The program does not allow the user to pick their own word and play with a
friend. Made to play single player as word is hidden by default.
%}

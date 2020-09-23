% this function uses the parameter pickWord (entered in the by the user),
% determines this word and returns the variable wordPicked.
% input is the pickWord variable denoting the number of the word picked
% output is the resultant wordPicked variable that corresponds to the
% number picked (pickWord variable)

function[wordPicked]=dictionaryLookup(pickWord)
% DICTIONARY CODE (lines 7 through 13) WAS TAKEN FROM AN ONLINE SOURCE 
% (MyUni practical 3)
% use dictionary search to pick a random word
dictText=fileread('dictionary_long.txt'); % read in vector of character arrays
dictWords=splitlines(dictText); % split the text array into words
dictWords=dictWords(1:end-1);  % remove the last empty line

% build the dictionary from a text array
dictionary=[];
% only performs the loop until the pickWord (word number picked) occurs, no
% reason to format the rest of the dictionary. Reduces loading time
for i=[1:pickWord]
   % concatenate the string onto the end of the dictionary
   dictionary=[dictionary string(dictWords(i))];
end

wordPicked=dictionary(pickWord);

end



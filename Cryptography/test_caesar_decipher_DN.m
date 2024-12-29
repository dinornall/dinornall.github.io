%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code is a script that deciphers the given encoded message (encoded
    with a caesar cipher) using the deciphering function that I made, and
    then plots the possible code words as a function of the length of the
    code word logarithmically.
%}
%%
% Load the cipher text test file
load('cipher_text_test.mat')

% decipher the cipher text
c = 0;
for i = 65:90
    for j = 65:90
        code_word = [i,j];
        c = c + 1;
        pt_test{c,1} = decipher_Caesar_DN(cipher_text,code_word);
    end
end
decipher_Caesar_DN(cipher_text,'YO')
% Determine the True plain text
% True Plain Text: HELLOTHISISASECRETMESSAGEENCRYPTEDUSINGACAESARCIPHERWITHTHECODEWORDYO
% The Code Word is: YO

% Plot the number of possible code words as a function of the length of 
% the code word, from 1 to 10 letters
numOptions = zeros(10,1);
for i = 1:10
    numOptions(i) = 26^i;
end
% The graph looks fairly linear on a log scale which means that the number
% of possibilities increases exponentially with code word length
semilogy(numOptions)
xlabel("Code Word Length")
ylabel("Possible Combinations")
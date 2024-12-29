%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code enciphers text using a code word and a Vigenere cipher method
%}
%%
function [cipher_text] = encipher_Vigenere_DN(plain_text, code_word)
    % Convert plain text and code word into ASCII
    pt = uint8(plain_text);
    cw = uint8(code_word);
    % Eliminate Repeated Letters
    cw = unique(cw,'stable');
    % Initializing the plain alphabet
    A = (65:90);
    % Initialize a variable for the cipher text in ASCII format
    ct = zeros(1, length(pt));
    % Check that the inputs are valid
    mincw = min(cw);
    minpt = min(pt);
    maxcw = max(cw);
    maxpt = max(pt);
    if ((min(mincw,minpt) >= 65) && (max(maxcw,maxpt) <= 90))
        % Create the Vigenere square in ASCII format
        VSquare = zeros(26,26);
        endingLetters = [65];
        VSquare(1,:) = [A(2):A(end) endingLetters];
        for i = 2:25
            endingLetters = [endingLetters, A(i)];
            VSquare(i,:) = [A(i+1):A(end), endingLetters];
        end
        VSquare(26,:) = A;
        %Add Values to the ct vector
        firstRow = VSquare(1,:);
        for i = 1:length(pt)
            chosenRow = find(firstRow == cw(mod(i-1,length(cw))+1));
            cipherbet = VSquare(chosenRow,:);
            for j = 1:length(A)
                if pt(i) == A(j)
                    ct(i) = cipherbet(j);
                    break
                end
            end
        end
        cipher_text = char(ct);
    end
end
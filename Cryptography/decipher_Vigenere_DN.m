%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code deciphers text that was enciphered using the the Vigenere 
    method by using a code word and the Vigenere method of deciphering
%}
%%
function [plain_text] = decipher_Vigenere_DN(cipher_text, code_word)
    % Convert plain text and code word into ASCII
    ct = uint8(cipher_text);
    cw = uint8(code_word);
    % Eliminate Repeated Letters
    cw = unique(cw,'stable');
    % Initializing the plain alphabet
    A = (65:90);
    % Initialize a variable for the plain text in ASCII format
    pt = zeros(1, length(ct));
    mincw = min(cw);
    minct = min(ct);
    maxcw = max(cw);
    maxct = max(ct);
    if ((min(mincw,minct) >= 65) && (max(maxcw,maxct) <= 90))
        % Create the Vigenere square in ASCII format
        VSquare = zeros(26,26);
        endingLetters = [65];
        VSquare(1,:) = [A(2):A(end) endingLetters];
        for i = 2:25
            endingLetters = [endingLetters, A(i)];
            VSquare(i,:) = [A(i+1):A(end), endingLetters];
        end
        VSquare(26,:) = A;
        %Add Values to the pt vector
        firstRow = VSquare(1,:)
        for i = 1:length(pt)
            chosenRow = find(firstRow == cw(mod(i-1,length(cw))+1))
            cipherbet = VSquare(chosenRow,:);
            for j = 1:length(A)
                if ct(i) == cipherbet(j)
                    pt(i) = A(j);
                    break
                end
            end
        end
        % Create the plain text from pt using the "char” function.
        plain_text = char(pt);
    end
end
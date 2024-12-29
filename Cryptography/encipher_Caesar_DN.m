%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code enciphers plain text using a code word and the Caesar cipher
    method and return the enciphered text
%}
%%
function [cipher_text] = encipher_Caesar_DN(plain_text, code_word)
    % Convert plain text and code word into ASCII
    pt = uint8(plain_text);
    cw = uint8(code_word);
    % Eliminate Repeated Letters
    cw = unique(cw,'stable');
    % Initializing the plain alphabet
    A = (65:90);
    % Initialize a variable for the ctest_caesar_decipheripher text in ASCII format
    ct = zeros(1, length(pt));
    % Check that the inputs are valid
    mincw = min(cw);
    minpt = min(pt);
    maxcw = max(cw);
    maxpt = max(pt);
    if ((min(mincw,minpt) >= 65) && (max(maxcw,maxpt) <= 90))
        % Create the cipher alphabet using the code word.
        last = cw(end);
        if (last == 90)
            cipherbet = [cw, A];
        else
            cipherbet = [cw, A(find(A == last)+ 1:find(A == 90)), A(1:find(A == last))];
        end
        cipherbet = unique(cipherbet, 'stable');
        % Add values to the ct vector
        for i = 1:length(pt)
            for j = 1:length(A)
                if pt(i) == A(j)
                    ct(i) = cipherbet(j);
                    break
                end
            end
        end
        % Create the cipher text from ct using the “char” function.
        cipher_text = char(ct);
    end
end
%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code deciphers text that was enciphered using the the Caesar Cipher 
    method by using a code word and the Caesar Cipher method of deciphering
%}
%%
function [plain_text] = decipher_Caesar_DN(cipher_text, code_word)
    % Convert cipher text and code word into ASCII
    ct = uint8(cipher_text);
    cw = uint8(code_word);
    % Eliminate Repeated Letters
    cw = unique(cw,'stable');
    % Initializing the plain alphabet
    A = (65:90);
    % Initialize a variable for the cipher text in ASCII format
    pt = zeros(1, length(ct));
    % Check that the inputs are valid
    mincw = min(cw);
    minct = min(ct);
    maxcw = max(cw);
    maxct = max(ct);
    if ((min(mincw,minct) >= 65) && (max(maxcw,maxct) <= 90))
        % Create the cipher alphabet using the code word.
        last = cw(end);
        if (last == 90)
            cipherbet = [cw, A];
        else
            cipherbet = [cw, A(find(A == last)+ 1:find(A == 90)), A(1:find(A == last))];
        end
        cipherbet = unique(cipherbet, 'stable');
        % Add values to the pt vector
        for i = 1:length(ct)
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


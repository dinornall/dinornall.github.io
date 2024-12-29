%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code deciphers text that was enciphered using the the Homophonic 
    method by using a frequency list and the Homophonic method of deciphering
%}
%%
function [plain_text] = decipher_Homophonic_DN(cipher_text, Freq)
    % Set the cipher_text variable equal to ct
    ct = cipher_text;
    % Initialize the plain alphabet in ASCII format (it is 65 – 90).
    A = (65:90);
    % Initialize a variable for the plain text in ASCII format
    pt = zeros(1, length(ct));
    % Add Values to the pt Vector
    for i = 1:length(ct)
        [row, ~] = find(Freq == cipher_text(i));
        pt(i) = row;
    end
    % Create the plain text from pt using the “char” function
    plain_text = char(pt+64);
end



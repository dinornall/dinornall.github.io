%% Intro
% Dinor Nallbani
% 33710021
% The Grand Challenge
% 5/19/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{
    This code enciphers plain text and returns the cipher text and a
    frequency list that can be used to decode it using the Homophonic
    cipher
%}
%%
function [cipher_text,Freq] = encipher_Homophonic_DN(plain_text)
    % Convert the plain text into ASCII format
    pt = uint8(plain_text);
    % Initializing the plain alphabet
    A = (65:90);
    % Initialize a variable for the cipher text in ASCII format
    ct = zeros(1, length(pt));
    % Check that the inputs are valid
    minpt = min(pt);
    maxpt = max(pt);
    if ((minpt >= 65) && (maxpt <= 90))
        [Freq,p] = homophonic_alp();
        % Add Values to ct vector
        for i = 1:length(pt)
            letter = find(A == pt(i));
            ct(i) = Freq(letter,randi([1,p(letter)]));
        end
        cipher_text = ct;
    end

    % subfunction called homophonic_alp
    function [Freq, p] = homophonic_alp()
        % define p as the vector given above
        p = [8 2 3 4 12 2 2 6 6 1 1 4 2 6 7 2 1 6 6 9 3 1 2 1 2 1];
        % Initialize Freq as a 26x12 matrix of zeros
        Freq = zeros(26,12);
        % Generate vector with random ordering of 1 to 100
        r = randperm(100);
        % Replacing some 0's with for loop
        for j = 1:26
            Freq(j,1:p(j)) = r(1:p(j));
            r(1:p(j)) = [];
        end
    end
end


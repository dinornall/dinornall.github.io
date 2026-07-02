%% Intro
% Dinor Nallbani
% 33710021
% Homework #8
% 4/21/23
% I certify that the assignment I am submitting represents my own work
%% What the code does:
%{ This code finds the maximum number of boxes that someone can make by
% randomly choosing the size of panel to cut out from a panel of plywood,
% as well as the area that was wasted
%}
%% Script
close all;
clear;
clc;
sheet_dim = [96,48];
B = zeros(1,24);
A = zeros(1,24);
% part_dim = [15,8,4]
% [a,b] = rand_Layout(part_dim, sheet_dim)
%run the function for part lengths from 8-24
for i = 8:24
    part_dim = [i,8,4];
    numBoxes = zeros(1,1000);
    wastedArea = zeros(1,1000);
    %Run the function 1000 times
    for j = 1:1000
        [W,H] = rand_Layout(part_dim, sheet_dim);
        [wastedArea(j),numBoxes(j)] = check_Ratio(part_dim, sheet_dim, H, W);
    end
    B(i) = max(numBoxes);
    %find the index of the largest numBoxes so you can find the associated
    %wasted area
    k = 1;
    while (numBoxes(k) ~= B(i))
        k = k + 1;
    end
    A(i) = wastedArea(k);
end
%plot
figure(1)
plot((1:24),B)
xlabel("part Length")
ylabel("max number of boxes")
xlim([8 24]);
figure(2)
plot((1:24),A)
xlabel("part Length")
ylabel("wasted area")
xlim([8 24]);
% the results show a decreasing amount of area wasted as part lengths
% increase and a fairly flat number of max boxes that one can make out of
% the given parts around 6-9
%% rand_Layout function
% This function randomly places the boxes onto the sheet of plywood and
% returns an array of the height and width of each box and their location
function [W,H] = rand_Layout(part_dim, sheet_dim)
    part_dim = part_dim + (1/8);
    parts = [part_dim(3),part_dim(2);   % North Side
            part_dim(3),part_dim(2);    % South Side
            part_dim(3),part_dim(1);    % East Side
            part_dim(3),part_dim(1);    % West Side
            part_dim(2),part_dim(1)];   % Bottom
    rows = floor(sheet_dim(1)/part_dim(3));
    cols = floor(sheet_dim(2)/part_dim(2));
    H = zeros(rows,cols);
    W = zeros(rows,cols);
    running_height = sheet_dim(1);
    i = 1;
    while (running_height >= part_dim(3))
        partnum = randi(5);
        randpart = parts(partnum,:);
%         running_height = running_height - randpart(1);
        running_width = sheet_dim(2);
        j = 1;
        if (randpart(1) <= running_height)
            H(i,j) = randpart(1);
            W(i,j) = randpart(2);
            running_width = running_width - randpart(2);
            while (running_width >= part_dim(2))
                running_width = running_width - randpart(2);
                addnum = randi(5);
                addpart = parts(addnum,:);
                if(addpart(1) == randpart(1) && addpart(2) <= running_width)
                    j = j + 1;
                    H(i,j) = addpart(1);
                    W(i,j) = addpart(2);
%                     running_width = running_width - randpart(2);
                else
                    continue
                    
                end
            end
        end
        running_height = running_height - randpart(1);
        i = i+1;
    end
end
%% check_Ratio function
% This function finds the area that is unused by the parts cut out of the
% ply wood and the maximum number of boxes that can be created given a
% certain sheet of plywood
function [A_wasted, N_complete] = check_Ratio(part_dim, sheet_dim, height_array, width_array)
    sheet_area = sheet_dim(1) * sheet_dim(2);
    used_area = 0;
    [height, width] = size(height_array);
    for i = 1:height
        usedH = height_array(i,1);
        usedW = sum(width_array(i,:));
        used_area = used_area + (usedH*usedW);
    end
    unused_area = sheet_area - used_area;
    A_wasted = unused_area/sheet_area;
    bottom = 0;
    long_side = 0;
    short_side = 0;
    for j = 1:height
        for k = 1:width
            area = height_array(j,k).* width_array(j,k); % I talked this 
            % bit through ideologically with Michael Grady
            if (area == (part_dim(1)+0.125) * (part_dim(2)+0.125))
                bottom = bottom + 1;
            end
            if(area == (part_dim(1)+0.125) * (part_dim(3)+0.125))
                long_side = long_side + 1;
            end
            if(area == (part_dim(2)+0.125) * (part_dim(3)+0.125)   )
                short_side = short_side + 1;
            end
        end
    end
    long_side = floor(long_side/2);
    short_side = floor(short_side/2);
    N_complete = min([bottom, long_side,short_side]);
end

% Counting dimes
close all, clear all, imtool close all, clc

%% coins.png reconstruction
% Below is the code used to convert the coins.png image
% into its reconstructed binary image.
% I = imread('coins.png');
% imshow(I)
% threshold = graythresh(I);
% bw = im2bw(I,threshold);
% imshow(bw)
% bw = bwareaopen(bw,30);
% imshow(bw)
% bw = imfill(bw,'holes');
% imshow(bw) % BW image of coins
% imwrite(bw,'bw_coins.png','png')

%% Load and view the coins.png image and its binary equivalent
I = imread('coins.png');
subplot(2,1,1), imshow(I)
bw = imread('bw_coins.png');
subplot(2,1,2), imshow(bw)

%% Finding the region properties
L = bwlabel(bw);
stats = regionprops(L,'Area','Centroid');

%% Counting the dimes by using object sizes 
figure, imshow(bw)
hold on
count = 0;
for i = 1:length(stats)
    if stats(i).Area < 1900 % Since dimes are smaller than nickels
        plot(stats(i).Centroid(1),stats(i).Centroid(2),'*')
        count = count+1;
    end
end
title(['There are ' num2str(count) ' dimes in this image.'])
        
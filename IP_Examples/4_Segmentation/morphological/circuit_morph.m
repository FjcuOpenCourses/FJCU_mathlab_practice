% Example of morphology and region property measurement
clear all, close all

%% Identifiy Chips in the Circuit
BW1 = imread('circbw.tif');
subplot(2,1,1)
imshow(BW1)

SE = strel('rectangle',[40 30]);
BW2 = imerode(BW1,SE);
subplot(2,2,3)
imshow(BW2)

BW3 = imdilate(BW2,SE);
subplot(2,2,4)
imshow(BW3)

%% Labeling and Region Properites 
[L,n] = bwlabel(BW3);
RGB = label2rgb(L, 'spring', 'c');
figure, imshow(RGB)

stats = regionprops(L)

hold on
for i = 1:length(stats)
    text(stats(i).Centroid(1),stats(i).Centroid(2), num2str(i))
end
    
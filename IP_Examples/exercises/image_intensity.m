%% Load and convert image
jpg = imread('darkimage.jpg');
I = rgb2gray(jpg);
imshow(I)
%% Compute mean and std
mu = mean2(I)
sigma = std2(I)
low_in = (mu-sigma)/255;
if low_in < 0, low_in = 0; end
high_in = (mu+sigma)/255;
if high_in > 1, high_in = 1; end
%% Adjust image 
J = imadjust(I,...
    [low_in high_in],[0 1]);
figure, imshow(J)
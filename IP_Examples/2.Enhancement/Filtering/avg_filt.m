% Averaging filter example of removing speckle noise
I = imread('cameraman.tif');
% addition of graininess
I_noise = imnoise(I, 'speckle', 0.01);
% I_noise = imnoise(I, 'salt & pepper');

% the average of 3^2, or 9 values
% h = ones(3,3) / 3^2;
% or you could use:
h = fspecial('average', [3 3])
I2 = imfilter(I_noise,h);
imshow(I_noise), title('Original image')
figure, imshow(I2), title('Filtered image')
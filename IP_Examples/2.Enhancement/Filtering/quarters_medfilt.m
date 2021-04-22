% Example of using median filter to remove salt & pepper noise
I = imread('eight.tif');
% I = imread('cameraman.tif');
I_noise = imnoise(I,'salt & pepper');

h = fspecial('average',[3 3]);
I_avg = imfilter(I_noise,h);

I_med = medfilt2(I_noise, [3 3]);

subplot(2,1,1)
imshow(I_noise), title('Quarters w/ Salt & Pepper')
subplot(2,2,3)
imshow(I_avg), title('Averaging Filter')
subplot(2,2,4)
imshow(I_med), title('Median Filter')
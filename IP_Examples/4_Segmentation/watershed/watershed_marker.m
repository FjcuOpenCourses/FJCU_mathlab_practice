%% marker based watershed segmentation
% avoids over-segmentation
close all

img = imread('bon1g.jpg');
imshow(img);

%convert to binary image
bw = img >50;
figure, imshow(bw),title('bw');
 
% separate objects
e = imerode(bw,strel('disk',18));
figure, imshow(e), title('marker: eroded image');

% only allow regional minima wherever BW is nonzero
imp = imimposemin(double(bw),e);

L = watershed(imp);  % calculate watershed

rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure, imshow(rgb),title('Watershed transform of D')

% set background to black
rgb(repmat(~bw,[1,1,3])) = 0;
figure, imshow(rgb),title('Result')

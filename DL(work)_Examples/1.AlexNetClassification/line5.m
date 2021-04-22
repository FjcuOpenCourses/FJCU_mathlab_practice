net = alexnet;

im = imread('peppers.png');
imshow(im);

im2 = imresize(im,[227 227]);
label = classify(net,im2)
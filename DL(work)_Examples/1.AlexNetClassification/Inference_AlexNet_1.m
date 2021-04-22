%% Use alexnet to do inference
% Load Pre-trained CNN
% This network is available from out add-ons location in the home tab. 
% You can use a variety of pretrained networks available for download
net = alexnet;
% Show the architecture of AlexNet
net.Layers

%% Classify 'peppers' in 4 lines of code
% Import a testing image.
img = imread('peppers.png');

% There is a size requirement of 227 x 227 for AlexNet. 
img = imresize(img, [227 227]);

% Recognize the testing image
[Ypred, scores] = classify(net, img);

% Show predicting result
imshow(img);
title(char(Ypred))

%% List top 3 class scores
[ssort, sidx] = sort(scores, 'descend');

numTopClasses = 3; % show top N choices
TopClasses = net.Layers(end).ClassNames(sidx(1:numTopClasses));
TopScores = ssort(1:numTopClasses)';

topTable = table(TopClasses, TopScores)


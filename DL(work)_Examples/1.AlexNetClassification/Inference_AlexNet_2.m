%% ImageDatastore
clear all,close all,clc
%load model
net = alexnet;
% Show the architecture of AlexNet
net.Layers

%% Show what AlexNet does with random images without being retrained
samples = imageDatastore('SampleImages',...
    'IncludeSubfolders', true, 'LabelSource', 'foldernames', 'ReadFcn', @preprocessImg);

%% Count files in ImageDatastore labels
countEachLabel(samples)

%% Split ImageDatastore labels by proportions
[samplespart, testing] = splitEachLabel(samples, 2);
countEachLabel(samplespart)
 
%% Change ReadFunction in imageDatastore 
% Resize image before reading it
samples.ReadFcn = @preprocessImg;
img = readimage(samples, 8);
%whos img

% Make prediction
% classLabel = classify(net, samplespart);
classLabel = classify(net, img);

% Show image
imshow(img); 
title(char(classLabel));

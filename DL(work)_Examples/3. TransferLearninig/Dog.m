%close all; clear all;clc
%% 輸入資料
digitData = imageDatastore('Dog_Images', ...
    'IncludeSubfolders', true, 'LabelSource', 'foldernames');
%% 正規化
digitData.ReadFcn = @preprocessImg;
%% 分割資料
trainingNumFiles = 150;

[trainDigitData,testDigitData] = splitEachLabel(digitData, ...
trainingNumFiles, 'randomize');

%% Model
Net = alexnet;
%Net = vgg16();
NewNet = Net.Layers(1:end-3);

Layer = [NewNet
    fullyConnectedLayer(3,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer
     ];
%%
options = trainingOptions(...
    'sgdm',...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 16,...
    'InitialLearnRate', 0.0001,...
    'ExecutionEnvironment', 'gpu',...
    'Plots', 'training-progress',...
    'ValidationData', testDigitData,...
    'ValidationFrequency', 30);
%%
convnet = trainNetwork(trainDigitData, Layer, options);

%% Classify the Images in the Test Data and Compute Accuracy
predictedLabels  = classify(convnet, testDigitData);
valLabels  = testDigitData.Labels;

%% Calculate the accuracy.
accuracy = sum(predictedLabels == valLabels)/numel(valLabels)

%% Calculate the confusion matrix
figure
[cmat,classNames] = confusionmat(valLabels,predictedLabels);
h = heatmap(classNames,classNames,cmat);
xlabel('Predicted Class');
ylabel('True Class');
title('Confusion Matrix');

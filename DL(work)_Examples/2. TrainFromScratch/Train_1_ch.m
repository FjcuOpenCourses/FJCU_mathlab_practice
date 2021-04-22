%% �Ыؤp���`�׾ǲߺ����i���g�Ʀr����-1

%% ���J�v�����
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDataset');

digitData = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders', true, 'LabelSource', 'foldernames');

%% �q��Ʈw����ܼv��
figure;
perm = randperm(10000, 20);
for i = 1:20
    subplot(4,5,i);
    img = readimage(digitData, perm(i));
    imshow(img);
end

%% �T�{�C�Ӥ��������v���ƶq
CountLabel = digitData.countEachLabel

%% ���ΰV�m�P���ո��
trainingNumFiles = 750;
[trainDigitData,testDigitData] = splitEachLabel(digitData, ...
    trainingNumFiles, 'randomize');

%% �w�q�����[�c
% �o��Х�Deepnetwork design�ԥX�@�ӻP�U��@�˪��ҫ�
% layers = [
%     imageInputLayer([28 28 1])
%     convolution2dLayer(5, 20)
%     reluLayer
%     maxPooling2dLayer(2, 'Stride', 2)
%     fullyConnectedLayer(10)
%     softmaxLayer
%     classificationLayer];

%% �]�w�V�m�Ѽ�
options = trainingOptions(...
    'sgdm',...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 128,...
    'InitialLearnRate', 0.01,...
    'ExecutionEnvironment', 'auto',...
    'Plots', 'training-progress');

%% �V�m����
convnet = trainNetwork(trainDigitData, layers_13, options);

%% �b���ռv�����i��v������
predictedLabels  = classify(convnet, testDigitData);
valLabels  = testDigitData.Labels;

%% �p���ǫ�
accuracy = sum(predictedLabels == valLabels)/numel(valLabels)

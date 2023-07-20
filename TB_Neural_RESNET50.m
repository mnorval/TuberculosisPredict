for n = 1:5
    

LASTN = maxNumCompThreads(1)
rand('seed',1);%88.06
rng('default')


net=resnet50();
inputSize = net.Layers(1).InputSize;
layersTransfer = net.Layers(1:end-2);


categories = {'NoTB_Combined','HasTB_Combined'};

rootFolder = 'D:\Temp\Combined';
 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');  

    image_size = 224;
    image_color_channels = 3;
    imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);

%split the datastore into training x% and x%
[imagedataTrain,imagedataValidation] = splitEachLabel(imagedata,0.9);


numClasses = numel(categories(imagedataTrain.Labels));
%fc1 = fullyConnectedLayer(image_size*2,'BiasLearnRateFactor',2);
layers = [
    layersTransfer
    %fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    %fullyConnectedLayer(numClasses)
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];
	


options = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.0001, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'ValidationData',imagedataValidation,...
    'ValidationFrequency',5,... 
    'MaxEpochs', 30, ...
    'MiniBatchSize', 30, ...
    'Verbose', true, ...
    'VerboseFrequency',1, ...    
    'Plots','training-progress'); 

TBnetTransfer = trainNetwork(imagedataTrain,layers,options);
end

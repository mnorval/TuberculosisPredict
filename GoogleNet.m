clearvars;
clc;

net = googlenet;

%inputSize = net.Layers(1).InputSize;
layersTransfer = net.Layers(1:end-3);
%net.Layers(1);




categories = {'Adjusted_Cropped_Has_TB1024_RGB','Adjusted_Cropped_No_TB1024_RGB'};
%categories = {'Adjusted_Cropped_No_TB1024_RGB'};

rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Datasets';
 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');  

    image_size = 128;
    image_color_channels = 3;
    imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);

    
numClasses = numel(categories(imagedata.Labels));    
%split the datastore into training x% and x%
[imagedataTrain,imagedataValidation] = splitEachLabel(imagedata,0.9);

varSize = image_size;
new_layersx = [
    %imageInputLayer([varSize varSize image_color_channels]);    
    layersTransfer;
    fullyConnectedLayer(numClasses)
    softmaxLayer;
    classificationLayer
    ];

%new_layers(142) = fullyConnectedLayer(2);
	
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imagedataValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');	

%TBnetTransfer = trainNetwork(imagedataTrain,layerGraph(net),options);
%TBnetTransfer = trainNetwork(imagedataTrain,new_layers,options);

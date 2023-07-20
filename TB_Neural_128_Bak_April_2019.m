

for n = 1:3

%clear all;
%clear global
%clearvars
%clc
%clear all;
%pause(3);
LASTN = maxNumCompThreads(1)
%rand('seed',123456);%88.06
rng('default')

%categories = {'Adjusted_Cropped_Has_TB128_3','Adjusted_Cropped_No_TB128_3'};
categories = {'No_TB','Has_TB'};

rootFolder = 'D:\Temp\Original\Small_Set';

 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'IncludeSubfolders', true,'LabelSource', 'foldernames');  

%imagedataValidation = imageDatastore(fullfile(rootFolder_validation, categories), ...
%    'LabelSource', 'foldernames'); 

[imagedataTrain,imagedataValidation] = splitEachLabel(imagedata,0.9);

image_size = 64;
image_color_channels = 1;



%if image_size == 16 
%    imageSize = [16,16];
%    fprintf('Imagesize = 16  \n');
%end

%if image_size == 32 
%    imageSize = [32,32]; 
%    fprintf('Imagesize = 32  \n');
%end
if image_size == 64 
    imageSize = [64,64];
    fprintf('Imagesize = 64  \n');
end
%if image_size == 80
%    imageSize = [80,80]; 
%    fprintf('Imagesize = 80  \n');
%end
%if image_size == 100
%    imageSize = [100,100]; 
%    fprintf('Imagesize = 100  \n');
%end

%if image_size == 128
%    imageSize = [128,128]; 
%    fprintf('Imagesize = 128  \n');
%end
%imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);
%imageSize = '64 64';


if image_color_channels == 1
    augmentedTrainingSet = augmentedImageDatastore(imageSize, imagedataTrain,'ColorPreprocessing', 'rgb2gray');
    augmentedValidateSet = augmentedImageDatastore(imageSize, imagedataValidation,'ColorPreprocessing', 'rgb2gray');
    fprintf('Color Channel = 1  \n');
end
    
%if image_color_channels == 3
%    augmentedTrainingSet = augmentedImageDatastore(imageSize, imagedataTrain,'ColorPreprocessing', 'gray2rgb');
%    augmentedValidateSet = augmentedImageDatastore(imageSize, imagedataValidation,'ColorPreprocessing', 'gray2rgb');
%    fprintf('Color Channel = 3  \n');
%end


%split the datastore into training x% and x%

    
conv1 = convolution2dLayer(5,image_size,'Padding',2,'BiasLearnRateFactor',2);
conv1.Weights = gpuArray(single(randn([5 5 image_color_channels image_size])*0.0001));

fc1 = fullyConnectedLayer(image_size*2,'BiasLearnRateFactor',2);

%if image_size == 16
%fc1.Weights = gpuArray(single(randn([image_size*2 1*1*image_size*2])*0.1));
%fprintf('Weights = 16  \n');
%end

%f image_size == 32
%c1.Weights = gpuArray(single(randn([image_size*2 3*3*image_size*2])*0.1));
%fprintf('Weights = 32  \n');
%end

if image_size == 64
%fc1.Weights = gpuArray(single(randn([image_size*2 7*7*image_size*2])*0.1));
fc1.Weights = gpuArray(single(randn([image_size*2 7*7*image_size])*0.1));
fprintf('Weights = 64  \n');
end

%f image_size == 80
%fc1.Weights = gpuArray(single(randn([image_size*2 9*9*image_size*2])*0.1));
%fprintf('Weights = 80  \n');
%end

%if image_size == 100
%fc1.Weights = gpuArray(single(randn([image_size*2 11*11*image_size*2])*0.1));
%fprintf('Weights = 100  \n');
%end

%if image_size == 128
%fc1.Weights = gpuArray(single(randn([image_size*2 15*15*image_size*2])*0.1));
%fprintf('Weights = 128  \n');%
%end

%fc1.Weights = gpuArray(single(randn([image_size*2 11*11*image_size*2])*0.1));

%ceiling = 0.02;
fc2 = fullyConnectedLayer(2,'BiasLearnRateFactor',2);
fc2.Weights = gpuArray(single(randn([2 image_size*2])*0.1));

%nn = -5:0.1:5;
%tansig = tansig(nn);

layers = [
    imageInputLayer([image_size image_size image_color_channels]);
    conv1;
    maxPooling2dLayer(3,'Stride',2);
    reluLayer();
    convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
    reluLayer();
    averagePooling2dLayer(3,'Stride',2);
    convolution2dLayer(5,64,'Padding',2,'BiasLearnRateFactor',2);
    reluLayer();
    averagePooling2dLayer(3,'Stride',2);
    fc1;
    reluLayer();
    fc2;
    softmaxLayer()
    classificationLayer()];    
  
    
    %'sgdm' | 'rmsprop' | 'adam'
    %'ValidationPatience',5
    
opts = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'ValidationData',augmentedValidateSet,...
    'ValidationFrequency',2,... 
    'ExecutionEnvironment','GPU',...
    'MaxEpochs', 25, ...
    'Shuffle', 'every-epoch', ...
    'MiniBatchSize', 50, ...
    'Verbose', true, ...
    'VerboseFrequency',1, ...    
    'Plots','training-progress'); 




[net, info] = trainNetwork(augmentedTrainingSet, layers, opts);
%save('E:\Documents\Dropbox\Personal\Study\MTech\Simulations\DeepLearning_M_Degree\256_3_NN.mat','net')
end


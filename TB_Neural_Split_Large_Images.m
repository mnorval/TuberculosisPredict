clear all;clear global;clearvars;
clc;clear all;
pause(3);
LASTN = maxNumCompThreads(1)

sub_plot_x = 2;
sub_plot_y = 4;
count = 1;

%categories = {'Split_64_Has_TB','Split_64_No_TB'};
categories = {'Adjusted_Cropped_No_TB1024_3','Adjusted_Cropped_Has_TB1024_3'};
rootFolder = 'E:\Originals\Matlab\Matlab Dataset Backup';
 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');  


%imageSize = [1024,1024];

%augmentedTrainingSet = augmentedImageDatastore(imageSize, imagedata);
%augmentedValidateSet = augmentedImageDatastore(imageSize, imagedataValidation,'ColorPreprocessing', 'rgb2gray');
datastore_count = 1;
image_size = 1024;
imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);

while(datastore_count <=imagedata.countEachLabel.Count)
%while(datastore_count <=3)

image_number = datastore_count ;
datastore_count =datastore_count +1;
[xray_image,info] = readimage(imagedata,image_number);
%subplot(sub_plot_y,sub_plot_x,count), imshow(xray_image), title('Original');count=count+1;

[folder, baseFileName, ext] = fileparts(info.Filename);
rowcount=1;
x=0;y=0;

for i = 1:2
    %------------------
for i = 1:2
Cropped_Temp = imcrop(xray_image,[x y 512 512]);x=x+512;
newBaseName = [baseFileName ext];
newBaseName = ['_' newBaseName];
newBaseName = [int2str(count) newBaseName];
newBaseName = ['_' newBaseName];
newBaseName = [int2str(rowcount) newBaseName];
newBaseName = ['ROW_' newBaseName];

count=count+1;folder = 'c:\temp\';outputFile = fullfile(folder, newBaseName); imwrite(Cropped_Temp, outputFile )
end
%-------------------------
x=0;y=y+512;rowcount=rowcount+1;count=1;
end

%---------------------------
end


clc;
clear all;
close all;
count=1;
sub_plot_x = 5;
sub_plot_y = 5;



%categories = {'Has_TB','No_TB'};
%categories = {'No_TB_Blob','Has_TB_Blob'};
%rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Matlab\Datasets\Temp\Hybrid';
%rootFolder = 'D:\Temp\No_TB';
%imagedata = imageDatastore(fullfile(rootFolder), ...
%    'LabelSource', 'foldernames');  
%----------------------------------------------
%while(count <= imagedata.countEachLabel.Count)
    
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%image_number = randi(imagedata.countEachLabel.Count-1)+1;

%Read Image
%[xray_image,info] = readimage(imagedata,count);
%----------------------------------------------
[xray_image] = readimage('C:\Temp\Shz_CHNCXR_0004_0.png');
%subplot(sub_plot_y,sub_plot_x,count), imshow(xray_image), title(['original image: ',num2str(image_number)]);count=count+1;

%xray_image_grey =  rgb2gray(xray_image);
%xray_image_grey =  xray_image;
xray_image_adjusted = imadjust(xray_image);
%xray_image_adjusted = imcrop(xray_image);

%imwrite(xray_image_adjusted,info.Filename); 
%count = count + 1;
%close all;
%----------------------------------------------
%end



clc;
clear all;
close all;
sub_plot_x = 5;
sub_plot_y = 5;
count = 1;



set(gcf, 'Position', get(0, 'Screensize'));
rootFolder = 'D:\Temp\Hybrid - Noise\No_TB';
imagedata = imageDatastore(fullfile(rootFolder), ...
    'LabelSource', 'foldernames');  

while(count<=imagedata.countEachLabel.Count)
%image_number = randi(imagedata.countEachLabel.Count-1)+1;
image_number = count;
%Read Image
[xray_image,info] = readimage(imagedata,image_number);
xray_image_grey =  xray_image;


xray_image_grey = imadjust(xray_image_grey);
xray_image_noise = imnoise(xray_image_grey,'gaussian');

imwrite(xray_image_noise,info.Filename);
%close all;
count = count + 1;
end
close all;
f = msgbox('Operation Completed');
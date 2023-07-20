sub_plot_x = 2;
sub_plot_y = 3;
count = 1;

categories = {'Has_TB','No_TB'};
rootFolder = 'C:\Temp';
 
imagedata = imageDatastore(fullfile(rootFolder, categories), ...
    'IncludeSubfolders', true,'LabelSource', 'foldernames');  


[xray_image,info] = readimage(imagedata,2);
xray_image_grey =  rgb2gray(xray_image);
subplot(sub_plot_y,sub_plot_x,count), imshow(xray_image_grey), title('Before');count=count+1;

F1=fft2(xray_image_grey,128,128);
F2=fftshift(F1);


subplot(sub_plot_y,sub_plot_x,count), imshow(F1), title('FFT');count=count+1;
subplot(sub_plot_y,sub_plot_x,count), imshow(F2), title('SHIFT');count=count+1;

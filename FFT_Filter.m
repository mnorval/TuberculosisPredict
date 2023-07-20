    clc;
    clear all;
    close all;
    sub_plot_x = 5;
    sub_plot_y = 5;
    count = 1;
    set(gcf, 'Position', get(0, 'Screensize'));
    rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Datasets\BlobExtract_No_TB1024';
    imagedata = imageDatastore(fullfile(rootFolder), ...
        'LabelSource', 'foldernames');  
    %image_size = 128;    %image_color_channels = 3;    %imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);
    image_number = randi(50)+1;
    %Read Image
    [xray_image,info] = readimage(imagedata,image_number);
    xray_image_grey =  xray_image;%rgb2gray(xray_image);
    subplot(sub_plot_y,sub_plot_x,count), imshow(xray_image), title(['original image: ',num2str(image_number)]);count=count+1;
    
    xray_FFT= fft2(xray_image_grey);
    subplot(sub_plot_y,sub_plot_x,count), imshow(xray_FFT), title('FFT');count=count+1;
    
    xray_I_FFT=ifft2(xray_FFT);
    subplot(sub_plot_y,sub_plot_x,count), imshow(xray_I_FFT), title('I_FFT');count=count+1;
    
    LowpassMask=(1/3)*ones(3,3); % Averaging mask of size 3*3 
    Filtered=conv2(xray_image_grey,LowpassMask);
    subplot(sub_plot_y,sub_plot_x,count), imshow(Filtered), title('Filtered');count=count+1;
    
    
    Sobel=[-1 0 1]; 
    Filtered=conv2(xray_image_grey,Sobel);
    subplot(sub_plot_y,sub_plot_x,count), imshow(Filtered), title('Filtered');count=count+1;
    
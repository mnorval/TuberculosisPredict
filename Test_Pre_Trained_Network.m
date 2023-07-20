clearvars
clc
sub_plot_x = 4;
sub_plot_y = 4;
sub_plot_count = 1;
loopcount = 1;
correct_count = 0;
%load '64_3_NN'
load '128_3_NN'

categories = {'Adjusted_Cropped_Has_TB1024_RGB','Adjusted_Cropped_No_TB1024_RGB'};
%categories = {'Adjusted_Cropped_Has_TB64','Adjusted_Cropped_No_TB64'};
rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Datasets';
%rootFolder = 'E:\Originals\Study\MTech';

imds_test = imageDatastore(fullfile(rootFolder, categories), ...
    'LabelSource', 'foldernames');  

image_size = 128;
image_color_channels = 3;
imds_test.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);

while(loopcount<=(sub_plot_x*sub_plot_y))
    
    labels = classify(net, imds_test);
    %ii = randi(imds_test.countEachLabel.Count);
    ii = randi(660)+1;
    im = imread(imds_test.Files{ii});
    subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(im), title('Pre Trained NN results');sub_plot_count=sub_plot_count+1;
    if labels(ii) == imds_test.Labels(ii)
       labels(ii) = 'True';
       colorText = 'g';
       correct_count = correct_count+1;
    else
        labels(ii) = 'False';
        colorText = 'r';
    end
    title(char(labels(ii)),'Color',colorText);
    loopcount = loopcount + 1;
end
%sprintf('SNR target for BER 10^{%0.1f}', (x));
%subplot(1:10);text(10,1,'Is this what you need?');


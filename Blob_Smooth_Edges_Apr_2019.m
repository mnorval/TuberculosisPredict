
loopcount = 0;
sub_plot_x = 4;
sub_plot_y = 2;

extract_biggest_blobs = 6;
grayImage_threshold = 180;
%===============================================================================

%-----------------------
%-----------------------
%-----------------------
rootFolder = 'C:\Temp\No_TB_Blob_Smooth';
imagedata = imageDatastore(fullfile(rootFolder), ...
    'LabelSource', 'foldernames');  


while hasdata(imagedata)
    [xray_image,info] = readimage(imagedata,loopcount);
    sub_plot_count = 1;
    %set(gcf, 'Position', get(0, 'Screensize'));
    
    %subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(xray_image), title('Original');sub_plot_count=sub_plot_count+1;


    %Smooth Edges
    dilatedImage = imdilate(xray_image,strel('disk',1));
    
    

%subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(dilatedImage), title('Dilated');sub_plot_count=sub_plot_count+1;




%    answer = questdlg('Save Conversion', ...
%        'Options', ...
%        'Yes','No','Cancel','Cancel');
    % Handle response
%    switch answer
%        case 'Yes'
%            imwrite(dilatedImage,info.Filename);
%            close all;
%       case 'No'
%           close all;
%       case 'Cancel'
%            close all;
%           break
%    end
imwrite(dilatedImage,info.Filename);
    loopcount=loopcount+1;
    %sprintf(loopcount);
end
close all;
f = msgbox('Operation Completed');

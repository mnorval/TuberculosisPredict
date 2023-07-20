% Program to find the two lung regions in a CT cross sectional image.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 22;
loopcount = 1;
binarize_thresholdValue = 1;



extract_biggest_blobs = 2;
grayImage_threshold = 120;
borderclear = 4;  %1/4/8
%===============================================================================

%-----------------------
%-----------------------
%-----------------------
rootFolder = 'E:\Documents\Dropbox\Personal\Study\MTech\Simulations\Matlab\Datasets\Temp\Hybrid\No_TB_Blob\Morton_NHI';
imagedata = imageDatastore(fullfile(rootFolder), ...
    'LabelSource', 'foldernames');  


while hasdata(imagedata)
    [xray_image,info] = readimage(imagedata,loopcount);
    grayImage=xray_image;

    % Get the dimensions of the image.  
    % numberOfColorBands should be = 1.
    [rows, columns, numberOfColorBands] = size(grayImage);
    if numberOfColorBands > 1
      % It's not really gray scale like we expected - it's color.
      % Convert it to gray scale by taking only the green channel.
      grayImage = grayImage(:, :, 2); % Take green channel.
    end
    % Display the original gray scale image.
    grayImage=imadjust(grayImage);
    
    grayImage = addborder(grayImage, 50, 255, 'outer'); 
    
    subplot(2, 3, 1);imshow(grayImage, []);axis on;title('Original Grayscale Image (added Border)', 'FontSize', fontSize);drawnow;
    
    
    
    % Enlarge figure to full screen.
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    % Give a name to the title bar.
    set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
    %===============================================================================
    % Let's compute and display the histogram.
    [pixelCount, grayLevels] = imhist(grayImage);
    % The first and last bin of pixelCount are so huge that it suppresses the height 
    % of the rest of the histogram when plotted.  Zero out these bins so we can see the other bins.
    pixelCount(1) = 0;
    pixelCount(end) = 0;
    subplot(2, 3, 2); 
    bar(grayLevels, pixelCount, 'BarWidth', 1, 'FaceColor', 'b');
    grid on;
    title('Histogram of Original Image', 'FontSize', fontSize);
    xlim([0 grayLevels(end)]); % Scale x axis manually.
    %===============================================================================
    % Threshold (binarize) the image.

    % Draw a red line on the histogram at this value.
    line([binarize_thresholdValue, binarize_thresholdValue], ylim, 'LineWidth', 2, 'Color', 'r');
    % Label the regions for the two body zones.
    text(22000, 7500, 'Lungs', 'Color', 'r', 'FontSize', 20, 'FontWeight', 'bold');
    text(51000, 7500, 'Body', 'Color', 'r', 'FontSize', 20, 'FontWeight', 'bold');
    binaryImage = grayImage < grayImage_threshold; % Do the thresholding.
    % Display the binary image.
    subplot(2, 3, 3);imshow(binaryImage, []);axis on;title('Binary Image', 'FontSize', fontSize);drawnow;
    % Get rid of stuff touching the border
    
    
    binaryImage = imclearborder(binaryImage,borderclear);
    %binaryImage = imclearborder(binaryImage,4);
    % Extract only the two largest blobs.
    binaryImage = bwareafilt(binaryImage, extract_biggest_blobs)
    %binaryImage = bwareafilt(binaryImage, [smallblob largeblob]);
    % Fill holes in the blobs to make them solid.
    %conn = conndef(5,'maximal');
    %binaryImage = imfill(binaryImage,conn, 'holes');
    binaryImage = imfill(binaryImage, 'holes');


    %Smooth Edges
    %windowSize = 10;
    %kernel = ones(windowSize) / windowSize ^ 2;
    %blurryImage = conv2(single(binaryImage), kernel, 'same');
    %binaryImage = blurryImage > 0.5; % Rethreshold
    
    
    % Display the binary image.
    subplot(2, 3, 4);imshow(binaryImage, []);axis on;title('Lungs-Only Binary Image', 'FontSize', fontSize);drawnow;
    % Mask image with lungs-only mask.  
    % This will produce a gray scale image in the lungs and black everywhere else.
    maskedImage = grayImage; % Initialize
    

    
    
    maskedImage(~binaryImage) = 0;
    
    % Display the masked gray scale image of only the lungs.
    
    subplot(2, 3, 5);imshow(maskedImage, []);axis on;title('Masked Lungs-Only Image', 'FontSize', fontSize);



    %answer = questdlg('Save Conversion', ...
    %    'Options', ...
    %    'Yes','No','Cancel','Cancel');
    % Handle response
    %switch answer
    %    case 'Yes'
    %        finalImage = maskedImage;%  imcrop(maskedImage);
    %        imwrite(finalImage,info.Filename); 
    %    case 'No'
    %       %break
    %    case 'Cancel'
    %        close all;
    %        break
    %end
            finalImage = maskedImage;%  imcrop(maskedImage);
            imwrite(finalImage,info.Filename); 
    loopcount=loopcount+1;
    
end


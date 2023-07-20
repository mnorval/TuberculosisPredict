clc;
clear;
sub_plot_x = 4;
sub_plot_y = 2;
loopcount = 1;
success_count = 0;
fail_count = 0;

rootFolder = 'E:\Originals\Study\MTech\NLM-MontgomeryCXRSet\MontgomerySet\CXR_png';
imagedata = imageDatastore(fullfile(rootFolder), ...
    'LabelSource', 'foldernames');  
image_size = 128;
image_color_channels = 3;
imagedata.ReadFcn = @(loc)imresize(imread(loc),[image_size,image_size]);

while hasdata(imagedata)
[xray_image,info] = readimage(imagedata,loopcount);

sub_plot_count = 1;
image_number = loopcount;      
try
xray_image_grey =  rgb2gray(xray_image);

xray_image_binary = (xray_image_grey > 140) & (xray_image_grey < 300);
xray_image_binary = imclose(xray_image_binary,strel('disk',2))

image_coords = regionprops(xray_image_binary, 'Area');
%% Compute the area of each component:
CC1 = bwconncomp(xray_image_binary, 4);
S = regionprops(xray_image_binary, 'Area');
%% Remove small objects
fig_areas = [S.Area];
[max_area, idx] = max(fig_areas);
extract_fig = false(size(xray_image_binary));
extract_fig(CC1.PixelIdxList{idx}) = true;
roi_image = extract_fig;

roi_image = ~roi_image;
BW2 = bwareafilt(roi_image,[500 2500]);

% Assign each blob an ID label.
labeledImage = bwlabel(BW2);
SC = regionprops(BW2, 'Centroid');
image_assigned_count = 0;
try
    for tempcount = 1:20
        %Check Blob X & Y location as well as size
        if (SC(tempcount).Centroid(1)) > 25 && (SC(tempcount).Centroid(1) < 100) && (SC(tempcount).Centroid(2)) > 40 && (SC(tempcount).Centroid(2) < 100)
        tempimage = ismember(labeledImage, tempcount) > 0;  
        subplot(sub_plot_y,sub_plot_x,count), imshow(tempimage), title(['Image - ',num2str(SC(tempcount).Centroid(1))]);count=count+1; 
            if (image_assigned_count < 1)
            left_lung_image = tempimage;    
            image_assigned_count=image_assigned_count+1;
            elseif (image_assigned_count >= 1)
            right_lung_image = tempimage;    
            image_assigned_count=image_assigned_count+1;
            end            
        end
    end
catch
end
%----------------------------------------------------------
%----------------------------------------------------------
roi_image = left_lung_image;
%% selecting the Region of interest
structBoundaries = bwboundaries(roi_image);
xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy(:, 2); % Columns.
y = xy(:, 1); % Rows.
 
leftColumn = min(x);
rightColumn = max(x);
topLine = min(y);
bottomLine = max(y);
width = rightColumn - leftColumn + 1;
height = bottomLine - topLine + 1;
croppedImage = imcrop(roi_image, [leftColumn, topLine, width, height]);
blackMaskedImage = xray_image_grey;
blackMaskedImage(~roi_image) = 0 ;
croppedImage_ori = imcrop(blackMaskedImage, [leftColumn, topLine, width, height]);
left_lung_image = croppedImage_ori;
%subplot(sub_plot_y,sub_plot_x,count), imshow(left_lung_image), title('Left Lung');count=count+1;

roi_image = right_lung_image;
%% selecting the Region of interest
structBoundaries = bwboundaries(roi_image);
xy1=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy1(:, 2); % Columns.
y = xy1(:, 1); % Rows.
leftColumn = min(x);
rightColumn = max(x);
topLine = min(y);
bottomLine = max(y);
width = rightColumn - leftColumn + 1;
height = bottomLine - topLine + 1;
croppedImage1 = imcrop(roi_image, [leftColumn, topLine, width, height]);
blackMaskedImage = xray_image_grey;
blackMaskedImage(~roi_image) = 0 ;
croppedImage_ori = imcrop(blackMaskedImage, [leftColumn, topLine, width, height]);
right_lung_image = croppedImage_ori;
subplot(sub_plot_y,sub_plot_x,count), imshow(croppedImage_ori), title('Right Lung');count=count+1;



left_lung_image = imresize(left_lung_image,[256 128]);
right_lung_image = imresize(right_lung_image,[256 128]);
combined_lung = cat(2,left_lung_image,right_lung_image);
subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(combined_lung), title('Final');sub_plot_count=sub_plot_count+1;
      
      
      
imwrite(combined_lung,info.Filename);       
    fprintf('Success #%d\n', loopcount);
    success_count = success_count + 1;


loopcount = loopcount + 1;   

catch ME
    fprintf('Error #%d\n', loopcount);
    loopcount = loopcount + 1;   
    fprintf('Error Encountered: %s\n', ME.message);
    fail_count = fail_count+1;
    %continue;
end
  end
  f = msgbox('Operation Completed','Success');
%fprintf(['Success', num2str(success_count)]);
%fprintf(['Failed', num2str(fail_count)]);
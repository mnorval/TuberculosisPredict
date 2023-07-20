sub_plot_x = 2;
sub_plot_y = 1;
sub_plot_count = 1;

Original_Image = imread('c:\temp\CHNCXR_0327_1.jpg');
Original_Grey_Image = rgb2gray(Original_Image);

GuasBlur3 = imgaussfilt(Original_Image,8);
EdgeImage = edge(Original_Grey_Image,'canny');
Noise = imnoise(Original_Grey_Image,'gaussian')


subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(Original_Image), title('Original Image');sub_plot_count=sub_plot_count+1;
%subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(GuasBlur3), title('Gaussian Smoothing');sub_plot_count=sub_plot_count+1;
%subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(EdgeImage), title('Line Detect');sub_plot_count=sub_plot_count+1;
subplot(sub_plot_y,sub_plot_x,sub_plot_count), imshow(Noise), title('Add Image Noise');sub_plot_count=sub_plot_count+1;
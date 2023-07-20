%Combine image
clear all;
sub_plot_x = 1;
sub_plot_y = 4;
count = 1;

I_1_1 = imread('c:\temp\ROW_1_1_CHNCXR_0003_0.png');I_1_2 = imread('c:\temp\ROW_1_2_CHNCXR_0003_0.png');I_1_3 = imread('c:\temp\ROW_1_3_CHNCXR_0003_0.png');
I_1_4 = imread('c:\temp\ROW_1_4_CHNCXR_0003_0.png');I_1_5 = imread('c:\temp\ROW_1_5_CHNCXR_0003_0.png');I_1_6 = imread('c:\temp\ROW_1_6_CHNCXR_0003_0.png');
I_1_7 = imread('c:\temp\ROW_1_7_CHNCXR_0003_0.png');I_1_8 = imread('c:\temp\ROW_1_8_CHNCXR_0003_0.png');I_1_9 = imread('c:\temp\ROW_1_9_CHNCXR_0003_0.png');
I_1_10 = imread('c:\temp\ROW_1_10_CHNCXR_0003_0.png');I_1_11 = imread('c:\temp\ROW_1_11_CHNCXR_0003_0.png');I_1_12 = imread('c:\temp\ROW_1_12_CHNCXR_0003_0.png');
I_1_13 = imread('c:\temp\ROW_1_13_CHNCXR_0003_0.png');I_1_14 = imread('c:\temp\ROW_1_14_CHNCXR_0003_0.png');I_1_15 = imread('c:\temp\ROW_1_15_CHNCXR_0003_0.png');
I_1_16 = imread('c:\temp\ROW_1_16_CHNCXR_0003_0.png');
%---------------------
I_2_1 = imread('c:\temp\ROW_2_1_CHNCXR_0003_0.png');I_2_2 = imread('c:\temp\ROW_2_2_CHNCXR_0003_0.png');I_2_3 = imread('c:\temp\ROW_2_3_CHNCXR_0003_0.png');
I_2_4 = imread('c:\temp\ROW_2_4_CHNCXR_0003_0.png');I_2_5 = imread('c:\temp\ROW_2_5_CHNCXR_0003_0.png');I_2_6 = imread('c:\temp\ROW_2_6_CHNCXR_0003_0.png');
I_2_7 = imread('c:\temp\ROW_2_7_CHNCXR_0003_0.png');I_2_8 = imread('c:\temp\ROW_2_8_CHNCXR_0003_0.png');I_2_9 = imread('c:\temp\ROW_2_9_CHNCXR_0003_0.png');
I_2_10 = imread('c:\temp\ROW_2_10_CHNCXR_0003_0.png');I_2_11 = imread('c:\temp\ROW_2_11_CHNCXR_0003_0.png');I_2_12 = imread('c:\temp\ROW_2_12_CHNCXR_0003_0.png');
I_2_13 = imread('c:\temp\ROW_2_13_CHNCXR_0003_0.png');I_2_14 = imread('c:\temp\ROW_2_14_CHNCXR_0003_0.png');I_2_15 = imread('c:\temp\ROW_2_15_CHNCXR_0003_0.png');
I_2_16 = imread('c:\temp\ROW_2_16_CHNCXR_0003_0.png');
%---------------------
I_3_1 = imread('c:\temp\ROW_3_1_CHNCXR_0003_0.png');I_3_2 = imread('c:\temp\ROW_3_2_CHNCXR_0003_0.png');I_3_3 = imread('c:\temp\ROW_3_3_CHNCXR_0003_0.png');
I_3_4 = imread('c:\temp\ROW_3_4_CHNCXR_0003_0.png');I_3_5 = imread('c:\temp\ROW_3_5_CHNCXR_0003_0.png');I_3_6 = imread('c:\temp\ROW_3_6_CHNCXR_0003_0.png');
I_3_7 = imread('c:\temp\ROW_3_7_CHNCXR_0003_0.png');I_3_8 = imread('c:\temp\ROW_3_8_CHNCXR_0003_0.png');I_3_9 = imread('c:\temp\ROW_3_9_CHNCXR_0003_0.png');
I_3_10 = imread('c:\temp\ROW_3_10_CHNCXR_0003_0.png');I_3_11 = imread('c:\temp\ROW_3_11_CHNCXR_0003_0.png');I_3_12 = imread('c:\temp\ROW_3_12_CHNCXR_0003_0.png');
I_3_13 = imread('c:\temp\ROW_3_13_CHNCXR_0003_0.png');I_3_14 = imread('c:\temp\ROW_3_14_CHNCXR_0003_0.png');I_3_15 = imread('c:\temp\ROW_3_15_CHNCXR_0003_0.png');
I_3_16 = imread('c:\temp\ROW_3_16_CHNCXR_0003_0.png');
%---------------------

combined_1 = cat(2,I_1_1,I_1_2,I_1_3,I_1_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
combined_2 = cat(2,I_2_1,I_2_2,I_2_3,I_2_4,I_2_5,I_2_6,I_2_7,I_2_8,I_2_9,I_2_10,I_2_11,I_2_12,I_2_13,I_2_14,I_2_15,I_2_16);
combined_3 = cat(2,I_3_1,I_3_2,I_3_3,I_3_4,I_3_5,I_3_6,I_3_7,I_3_8,I_3_9,I_3_10,I_3_11,I_3_12,I_3_13,I_3_14,I_3_15,I_3_16);

%combined_4 = cat(2,I_1_1,I_1_2,I_1_3,I_4_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_5 = cat(2,I_1_1,I_1_2,I_1_3,I_5_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_6 = cat(2,I_1_1,I_1_2,I_1_3,I_6_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_7 = cat(2,I_1_1,I_1_2,I_1_3,I_7_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_8 = cat(2,I_1_1,I_1_2,I_1_3,I_8_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_9 = cat(2,I_1_1,I_1_2,I_1_3,I_9_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_10 = cat(2,I_1_1,I_1_2,I_1_3,I_10_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_11 = cat(2,I_1_1,I_1_2,I_1_3,I_11_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_12 = cat(2,I_1_1,I_1_2,I_1_3,I_12_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_13 = cat(2,I_1_1,I_1_2,I_1_3,I_13_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%ombined_14 = cat(2,I_1_1,I_1_2,I_1_3,I_14_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_15 = cat(2,I_1_1,I_1_2,I_1_3,I_15_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);
%combined_16 = cat(2,I_1_1,I_1_2,I_1_3,I_16_4,I_1_5,I_1_6,I_1_7,I_1_8,I_1_9,I_1_10,I_1_11,I_1_12,I_1_13,I_1_14,I_1_15,I_1_16);



subplot(sub_plot_y,sub_plot_x,count), imshow(combined_1), title('Combined');count=count+1;
subplot(sub_plot_y,sub_plot_x,count), imshow(combined_2), title('Combined');count=count+1;
subplot(sub_plot_y,sub_plot_x,count), imshow(combined_3), title('Combined');count=count+1;
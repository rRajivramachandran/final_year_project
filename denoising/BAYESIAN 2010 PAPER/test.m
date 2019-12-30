clear all;
close all;
clc;
img = imread('NORMAL1.jpeg');
a1=img(:,:,3);
a = double(a1)/255; % Normalized Image
c = 1; % Constant
f = c*log(1 + (a)); % Log Transform
subplot(1,2,1),imshow(a1),title('Original Image');
subplot(1,2,2),imshow((f)),title('Log Transformation Image');
res = bayesEstimateDenoise(f);
imshow(res)
 
        
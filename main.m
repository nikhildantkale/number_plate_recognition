tic
clc;
clear all;
close all;
x=imread('C:\Users\Nikhil\Documents\MATLAB\2.jpg');
%x=imread('F:\pro\pro\project\final codes2\2.jpg');
%x=imread('F:\pro\pro\project\final codes2\6.jpg');
%x=imread('F:\pro\pro\project\final codes2\4.jpg');
%x=imread('F:\pro\pro\project\final codes2\3.jpg');
imshow(x);
figure


f=imresize(x,[600 NaN]);% Resizing the image keeping aspect ratio same.
if length(size(f))==3 %RGB image
    f=rgb2gray(f);  
end % Converting the RGB (color) image to gray (intensity).
g=medfilt2(f,[3 3]); % Median filtering to remove noise.
se=strel('disk',1); % Structural element for morphological processing.
gi=imdilate(g,se); % Dilating the gray image with the structural element.
ge=imerode(g,se); % Eroding the gray image with structural element.
gdiff=imsubtract(gi,ge); % Morphological Gradient for edges enhancement.
gdiff=mat2gray(gdiff); % Converting the class to double.
gdiff=conv2(gdiff,[1 1;1 1]); % Convolution of the double image for brightening the edges.
gdiff=imadjust(gdiff,[0.5 0.7],[0 1]); % Intensity scaling between the range 0 to 1.

B=logical(gdiff); %
er=imerode(B,strel('line',65,0));
out1=imsubtract(B,er);
F=imfill(out1,'holes');
H=bwmorph(F,'thin',1);
figure,imshow(H);
title('image after morphological operations');
H=imerode(H,strel('line',5,90));
H=imerode(H,strel('line',4,0));
figure,imshow(H);
title('thin lines removed');
final=bwareaopen(H,100);
final=imdilate(final,se);
figure,imshow(final);
title('final image');
%final=imread('C:\Users\GANESH\Desktop\t1.bmp');
%final=~final;
%final=finalhough1(final);
a=ocr123(final);
toc
 
 
 
 
 
 
 


 
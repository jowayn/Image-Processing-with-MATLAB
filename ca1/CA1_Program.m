%Tan Jo-Wayn
%Note: Run code in sections demarcated

%Part A

%Read file, launch imtool, display image profile and histogram
I = imread("test1.bmp");
imtool(I, []);
improfile(I, [1,363],[25,25]);
imhist(I);
%%
%Histogram Equalisation of Part A Image
I = imread("test1.bmp");
J = histeq(I,256);
subplot(1,2,1),imshow(J),title('Image after Histogram Equalisation');
subplot(1,2,2),imhist(J),title('Histogram of Image after Histogram Equalisation');

%%
%Part B4

S.a_val = [0.5; 0.6; 0.7; 0.8; 0.9; 1; 1.1; 1.2; 1.3; 1.4; 1.5];
S.m_val = [84.0518; 100.5611; 117.3507; 134.0817; 150.8983; 167.6004; 183.9521; 199.1632; 212.101; 221.987; 230.0611];
S.mu2_val = [353.2476; 508.4035; 692.5718; 903.7772; 1144.2394; 1412.25; 1636.8112; 1758.3411; 1692.317; 1465.1267; 1203.3522];
S.mu3_val = [-898.6275; -1562.4992; -2443.289; -3700.9717; -5230.4308; -7253.7062; -16221.7088; -31451.5392; -47270.9956; -55951.932; -55931.6791];

T = struct2table(S);
stackedplot(T,"XVariable",'a_val','GridVisible','on')
%%
%Part B5

%Histogram specification with non-flat target distribution
I2 = imread("test2.bmp");
target = 256:-1:1;
L = histeq(I2,target);
subplot(2,2,1),imshow(L),title('Image after Histogram Specification');
subplot(2,2,2),imhist(L),title('Histogram after Image Specification');
subplot(2,2,3),bar(1:1:256,target),title('Target Distribution Bar Graph');

%%
%Part B6

I2 = imread("test2.bmp");
K = histeq(I2,256);
subplot(1,2,1),imshow(K),title("test2.bmp after Histogram Equalisation");
subplot(1,2,2),imhist(K),title("Histogram of test2.bmp after Histogram Equalisation");

%%
%Part B1,B2,B3

% To enhance an image using the transformation s_k = a*(r_k + b).
% Inputs: the uint8 matrix of the gray level image ‘xxx.bmp’ (load the image using "imread" into Matlab first), and the parameters a, b.
% Outputs: the figure showing the input and output images with their respective histograms, the message to indicate clipping, and the histogram features m, mu2, mu3.

%Modify variable values in the function call below
[Iout,m,mu2,mu3] = enh("test2.bmp",1.2, -10); 

function [Iout,m,mu2,mu3] = enh(Iin,a,b)

I2 = imread(Iin);
Iout = a*(I2 + b);

%Computing m, mu2 and mu3
[pixelCount, grayLevels] = imhist(Iout);
imgPixels = sum(pixelCount);

m = sum(grayLevels .* pixelCount)/imgPixels;

probAtGrayLevels = pixelCount/imgPixels;

mu2 = sum((grayLevels - m).^2 .* probAtGrayLevels);

mu3 = sum((grayLevels - m).^3 .* probAtGrayLevels);

%Determining if there is clipping
I3 = double(I2);
I4 = a*(I3 + b);
exceed255 = any(I4(:) >255);
below0 = any(I4(:) <0);

%Displaying plots and values
subplot(2,2,1),imshow(I2),title('Original Image');
subplot(2,2,2),imhist(I2),title('Original Image Histogram');
subplot(2,2,3),imshow(Iout),title('Transformation Image');
subplot(2,2,4),imhist(Iout),title('Transformation Image Histogram');

disp("m =" + m);
disp("mu2 =" + mu2);
disp("mu3 =" + mu3);

%Display clipping message, if any
if exceed255 && below0
    disp("There is clipping at both 0 and 255")
elseif exceed255
    disp("There is clipping at 255")
elseif below0
    disp("There is clipping at 0")
end

end


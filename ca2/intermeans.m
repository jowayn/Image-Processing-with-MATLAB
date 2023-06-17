% To calculate the intermeans threshold;
% input is the gray level image ‘test1.bmp’
% output is the threshold value T and the binary thresholded
% image Iout.

function [T,Iout] = intermeans(Iin)
    %Iin = imread(Iin);
    T_prev = 0; %initialise prev T
    T = mean(mean(Iin)); %obtain threshold estimate
    while T_prev ~= T %loop until T_prev == T
        T_prev = T;
        u_1 = mean(mean(Iin(Iin<T_prev))); %mean of image for image <threshold
        u_2 = mean(mean(Iin(Iin>T_prev))); %mean of image for image >threshold
        T = ceil((u_1+u_2)/2); 
        %disp(T);
    end
    Iout = Iin >= T; %obtain binary matrix
    %imwrite(Iout,"letter_threshold.bmp");
    %subplot(1,2,1),imshow(Iin),title('Original Image');
    %subplot(1,2,2),imshow(Iout),title('Image After Thresholding');
end

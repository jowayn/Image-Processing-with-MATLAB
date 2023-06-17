% To compute the features;
% input is the binary thresholded image
% outputs are the feature values


function [P, A, C, xbar, ybar, phione] = features(Iin)
    %Iin = imread(Iin);
    %perimeter
    P = regionprops(Iin, 'Perimeter').Perimeter;
    %disp("Perimeter: " + P);
    
    %area - find by filling perimeter, then find sum of pixels
    boundary = bwperim(Iin,8);
    I_filled = imfill(boundary,'holes');
    A = sum(sum(I_filled));
    %disp("Area: " + A);
    
    %compactness - formula as per lecture notes
    C = (P^2)/(4*pi*A);
    %disp("Compactness: " + C);
    
    %centroid
    %m00: no. of pixels in component
    %size(matrix,2) finds its no. of columns
    m00=0;
    m10=0;
    m01=0;
    t_cols = size(Iin,2); %total columns
    t_rows = size(Iin,1); %total rows
    
    for x = 0:t_cols-1 %iterating across columns
        for y = 0:t_rows-1 %iterating across rows
            m00 = m00 + Iin(t_rows-y, x+1);
            m10 = m10 + (x * Iin(t_rows-y, x+1));
            m01 = m01 + (y * Iin(t_rows-y, x+1));
        end
    end
    
    xbar = m10/m00;
    ybar_actual = m01/m00;
    ybar = t_rows - m01/m00;
    imshow(Iin);
    axis on
    hold on;
    plot(xbar,ybar, 'r+', 'MarkerSize', 10, 'LineWidth', 2); %plot cross
    %disp("xbar: " + xbar);
    %disp("ybar: " + ybar);
    
    %invariant moment
    % m20 = sumof x^2 * f(x,y)
    % m02 = sumof y^2 * f(x,y)
    % u20 = m20 - xbar(m10)
    % u02 = m02 - ybar(m01)
    % fi_1 = u20/(u00)^2 + u02/(u00)^2
    
    u00 = m00;
    m20 = 0;
    m02 = 0;
    for x = 0:t_cols-1
        for y = 0:t_rows-1
            m20 = m20 + (x^2 * I_filled(t_rows-y, x+1));
            m02 = m02 + (y^2 * I_filled(t_rows-y, x+1));
        end
    end
    u20 = m20 - xbar*m10;
    u02 = m02 - ybar_actual*m01;
    phione = u20/(u00)^2 + u02/(u00)^2;
    %disp("phione: " + phione);

end
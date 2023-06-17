% To compute the r-theta plot;
% input is a boundary image ‘test3.bmp’
% output is the array containing the r-theta value
function [r, theta] = rtheta(Iin)
    %Iin = imread(Iin);
    Iin = Iin > 0;
    Iin = bwareafilt(Iin,1);
    
    %calculate xbar, ybar
    m00 =0;
    m10 = 0;
    m01 = 0;
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
    ybar = m01/m00;

    r = zeros(sum(sum(Iin)),1);
    theta = zeros(sum(sum(Iin)),1);
    pos = 0;
    for x = 0:t_cols-1
        for y = 0:t_rows-1
             if Iin(t_rows-y, x+1) == 1 %if pixels are edge pixels 
                pos = pos + 1;
                r(pos) = sqrt((x-xbar)^2 + (y-ybar)^2); %populate r array
                theta(pos) = atan2(y-ybar, x-xbar); %populate theta array
                if theta(pos)<0
                    theta(pos) = theta(pos) + 2*pi; %right-shift to make x-axis positive
                end
             end
        end
    end
end


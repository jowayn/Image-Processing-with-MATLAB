%%
%%%%% Section C %%%%%
% This m file is used to test your code for Section C
% Ensure that when you run this script file
%--- 1.
I = imread('./letter.bmp');
imshow(I); 
hold on;
% Compute edge map
[T,Iout] = intermeans(I);
edgemap = bwperim(Iout,8);

% Hough transform
[y_edges,x_edges] = find(edgemap); %retrieve no. of coordinates of edgemap

% Populate accumulator
t_cols = size(Iout,2); % no. of columns
t_rows = size(Iout,1); % no. of rows

rho_range = round(sqrt(t_rows^2 + t_cols^2)); %transformation to rho
acc = zeros(2*rho_range,180); %initialise accumulator
edge_pixels = length(x_edges); % no. of perimeter pixels

for i = 0:edge_pixels-1 % iterate across all edge pixels
    j = 0;
    for theta = (-pi/2):pi/180:(pi/2-pi/180) % increment thetha by pi/180
        rho = round(x_edges(i+1).*cos(theta) + y_edges(i+1).*sin(theta));
        acc((rho_range+rho),j+1) = acc(rho_range+rho,j+1)+1; %add one vote
        %for clearer plotting, enable this line only when plotting hough
        %transform graph
        %acc((rho_range+rho),j+1) = 1.45*acc((rho_range+rho),j+1); 
        j = j+1;
    end
end

% Plot edge lines
for i = 1:180 %iterate across range of theta
    for j = 1:rho_range*2 %iterate across range of rho
        if acc(j,i) >= 37 %set threshold to be 37 votes
            rho_offset = j - rho_range;
            x_lines = 0:t_cols;
            y_lines = (rho_offset - x_lines*cosd(i-90))/sind(i-90);
            plot(x_lines,y_lines); 
        end
    end
end

saveas(gcf,'letter_line.bmp')

%%
%{
% Note: Runs before plotting edge lines, also uncommment Line 31
% Run separate from edge lines as well
%
% Plotting hough transform graph
rho = -rho_range:rho_range-1;
theta = rad2deg(-pi/2:pi/180:pi/2-pi/180);
imshow(uint8(acc),[],'XData',theta,'YData',rho);
xlabel('theta')
ylabel('rho')
axis on, axis normal;
colormap(gca,hot);
title('Hough Transform Plot');
%}
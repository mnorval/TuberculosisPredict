%prevents rounding when displaying fractions
format long
%Reader 2-D Coordinates [x, y]
Reader = [-2, 2; 2, 1; -1, -2];
%plot reader locations
%scatter(getcolumn(Reader(1:3,1:2),1),getcolumn(Reader(1:3,1:2),2), 'MarkerEdgeColor',[1 0 0], 'MarkerFaceColor', [1 0 0]);figure(gcf)
%x = 0;0;0;
%y = 0;0;0;
%x = getcolumn(Reader(1:3,1:2),1)
%y = getcolumn(Reader(1:3,1:2),2)
%e = [1;1;1]
hold on
%errorbar(x,y, e, 'og', 'Marker', '+');
%axis([-5 5 -5 5]) %set axis for 2-D graphs
set(gca, 'XTick', -5:1:5);
set(gca, 'YTick', -5:1:5);

grid on;
%distances to Tag from Reader(i)
%Distance = [2.82842715;2.236067977;2.236067977]; %(0, 0) tag
Distance = [3.16227766; 1; 3.60555127]; %(1, 1) tag
%error circles
circle([-2, 2],Distance(1), 1000,'-');figure(gcf)
%http://www.mathworks.com/matlabcentral/fileexchange/2876-draw-a-circle
circle([2, 1],Distance(2),1000, '-');figure(gcf)
circle([-1, -2],Distance(3), 1000, '-');figure(gcf)
pause;
x = 0;
y = 0;
%Reader(row, col)
[x, y] = two_tri(Reader(1,1), Reader(2, 1), Reader(3,1), Reader(1, 2), Reader(2, 2),
Reader(3, 2), Distance(1), Distance(2), Distance(3));
%plot tag
scatter(x,y, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0 0 0]);figure(gcf)
circle([x, y],.5,1000,'-');figure(gcf)
pause;
clf;





function [ x, y ] = two_tri(x1, x2, x3, y1, y2, y3, d1, d2, d3)
%2-D trilateration function
% Inputs: Readers 1-3 (x,y) and Distances to Tag
%
% x_n1 = (d1^2 - d2^2)-(x1^2 - x2^2)-(y1^2 - y2^2)*2*(y3 - y1)
% x_n2 = 2*(y2 - y1)*(d1^2 - d3^2) - (x1^2 - x3^2) - (y1^2 - y3^2)
% x_d = 2*(x2 - x1)*2*(y3 - y1) - 2*(y2 - y1)*2*(x3-x1)
% x = (x_n1 - x_n2)/x_d
% y = 2;
%
x_n11 = (d1^2 - d2^2) - (x1^2 - x2^2) - (y1^2 - y2^2);
x_n21 = (d1^2 - d3^2) - (x1^2 - x3^2) - (y1^2 - y3^2);
x_n12 = 2*(y2-y1);
x_n22 = 2*(y3-y1);
d11 = 2*(x2-x1);
d21 = 2*(x3-x1);
d12 = 2*(y2-y1);
d22 = 2*(y3-y1);
x_n = [x_n11, x_n12; x_n21, x_n22]
d = [d11, d12; d21, d22]
x = x_n/d
x = det(x)
y_n11 = d11
y_n21 = d21
y_n12 = x_n11
y_n22 = x_n21
y_n = [y_n11, y_n12; y_n21, y_n22]
y = y_n/d
y = det(y)
end

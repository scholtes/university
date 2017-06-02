function [ X, Y, Z ] = plotfield(xmin, xmax, ymin, ymax, step, field)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[X, Y] = meshgrid(xmin:step:xmax,ymin:step:ymax);
[rows,cols] = size(X);
Z = zeros(rows,cols);
for row = 1:rows
    for col = 1:cols
        z = X(row,col)+1i*Y(row,col);
        Z(row,col) = feval(inline(field,'z'), z);
    end
end
end


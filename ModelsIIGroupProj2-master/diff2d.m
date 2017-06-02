function [ dtX, dtY, dtMag ] = diff2d( x, y, time )
%VELOCITY computes the velocity of a path, given an array of x-positions,
%y-positions, and time.
%   Assume that length of positionX, positionY, and time are the same
%   Returns three arrays

dtX = num_der(x, time);
dtY = num_der(y, time);
dtMag = sqrt(dtX.^2 + dtY.^2);

end
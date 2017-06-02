% Garrett Scholtes

function [ positionX, positionY ] = position(mass, charge, init_pos, init_vel, time, field)
%POSITION - given information about an electric field, this function
%returns the path trace of a test particle
%   mass - double - the mass of a test particle
%   charge - double - the charge of a test particle
%   init_pos - 1x2 double array - the initial x and y position of the test
%       particle
%   time - double array - the times to compute the position of the test
%       charge for
%   field - equation for the field

complex_pos = zeros(1, length(time));
complex_pos(1) = init_pos(1) + 1i*init_pos(2);
complex_vel = init_vel(1) + 1i*init_vel(2);

for k = 2:length(time)
    z = complex_pos(k-1);
    dt = time(k)-time(k-1);
    complex_acc = (charge/mass)*feval(inline(field,'z'), z);
    complex_vel = complex_vel+dt*complex_acc;
    complex_pos(k) = complex_pos(k-1)+dt*complex_vel;
end

positionX = real(complex_pos);
positionY = imag(complex_pos);

end 
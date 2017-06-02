function [ ] = doPlotActions(mass,charge,time_init,dt,time_final,init_pos,init_vel,field,handles)
%doPlotActions This plots a path and vector field for the electromagnetism GUI
%    This just does plot... you still need to determine the context of the
%    plot

axes(handles.charge_field) % Makes charge_field the selected plot window
cla;                       % Clears charge_field

%%% Perform calculations %%%
time = time_init:dt:time_final;
[posx, posy] = position(mass, charge, init_pos, init_vel, time, field);
step = 0.2;
sf = 1;

%%% Perform plotting %%%
% Do the vector field and particle trace
cla;
[X,Y,Fields] = plotfield(-2, 2, -2, 2, step, field);
hold on;
quiver(X(sf:sf:end),Y(sf:sf:end),real(Fields(sf:sf:end)), imag(Fields(sf:sf:end)), 'k-');
hold on;
plot(posx,posy,'r-');
axis([-2,2,-2,2]);

% Do position versus time
axes(handles.position) % Makes charge_field the selected plot window
cla;                       % Clears charge_field
plot(time, posx, 'r-', time, posy, 'b-');
h1 = legend('X', 'Y');
legPos = get(h1, 'position');
set(h1, 'position', legPos+[12.4 -8.8 0 0]);
% Do velocity versus time
axes(handles.velocity) % Makes charge_field the selected plot window
cla;                       % Clears charge_field
[velx, vely, velMag] = diff2d(posx, posy, time);
plot(time, velx, 'r-', time, vely, 'b-', time, velMag, 'g-');
h1 = legend('X', 'Y', 'Magnitude');
legPos = get(h1, 'position');
set(h1, 'position', legPos+[21.3 -7.8 0 0]);
% Do acceleration versus time
axes(handles.acceleration) % Makes charge_field the selected plot window
cla;                       % Clears charge_fields
[accelx, accely, accelMag] = diff2d(velx, vely, time);
plot(time, accelx, 'r-', time, accely, 'b-', time, accelMag, 'g-');
h1 = legend('X', 'Y', 'Magnitude');
legPos = get(h1, 'position');
set(h1, 'position', legPos+[21.3 -7.75 0 0]);
end


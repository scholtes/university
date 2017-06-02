% This contains values to be set for various "example" plots
% someone can take them and put them in the callback for the
% sample menu 
clear all;
close all;


        % SAMPLE 1: Particle near infinite charged plate
        list_name = 'Infinite charged plate';
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 8;
        init_pos = [1.3, -0.7];
        init_vel = [-0.45, 0.2];
        field = '2*(z>0)-1';

        % SAMPLE 2: Particle near a charged spherical shell
        list_name = 'Particle outside charged spherical shell';
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 30;
        init_pos = [1.3, -0.7];
        init_vel = [0.185, 0.185];
        field = '-(abs(z)>0.75^2)*abs(1/z^2)*z/abs(z)';

        % SAMPLE 3: Particle in a charged spherical shell
        list_name = 'Particle inside charged spherical shell';
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 3;
        init_pos = [0.2, 0.2];
        init_vel = [-0.185, -0.075];
        field = '-(abs(z)>0.75^2)*abs(1/z^2)*z/abs(z)';

        % SAMPLE 4: Two similarly charged objects
        list_name = 'Two similarly charged objects';
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 8;
        init_pos = [1.5, 0.5];
        init_vel = [-0.4, 0.2];
        field = '-(abs(z-1)>0.6^2)*abs(1/(z-1)^2)*(z-1)/abs(z-1)-(abs(z+1)>0.6^2)*abs(1/(z+1)^2)*(z+1)/abs(z+1)';

        % SAMPLE 5: Two oppositely charged objects
        list_name = 'Two oppositely charged objects';
        mass = 1e-6;
        charge = 1e-7;
        time_init = 0;
        dt = 0.025;
        time_final = 12;
        init_pos = [1.8, 0.2];
        init_vel = [-0.125, 0.4];
        field = '-(abs(z-1)>0.6^2)*abs(1/(z-1)^2)*(z-1)/abs(z-1)+(abs(z+1)>0.6^2)*abs(1/(z+1)^2)*(z+1)/abs(z+1)';











doPlotActions(mass, charge, time_init, dt, time_final, init_pos, init_vel, field);
%%%%%%% WARNING: PROVING GROUNDS %%%%%%
%%%%%%%% UNEXPLODED AMUNITIONS%%%%%%%%%
%time = time_init:dt:time_final;
%[posx, posy] = position(mass, charge, init_pos, init_vel, time, field);
%figure;
%step = 0.2;
%sf = 1;
%[X,Y,Fields] = plotfield(-2, 2, -2, 2, step, field);
%%contour(X,Y,abs(Fields),linspace(min(min(abs(Fields))),5*min(min(abs(Fields))), 8).^2*4, 'b-');
%% Let's draw a reference circle!
%% someParam = 0:0.001:2*pi;
%% plot(cos(someParam),sin(someParam),'b-');
%% end of reference circle;
%% Let's draw a reference line!
%%plot([0 0], [-2, 2], 'b-');
%hold on;
%quiver(X(sf:sf:end),Y(sf:sf:end),real(Fields(sf:sf:end)), imag(Fields(sf:sf:end)), 'k-');
%hold on;
%plot(posx,posy,'r-');
%axis([-2,2,-2,2]);
%%%%%%%% WARNING: PROVING GROUNDS %%%%%%
%%%%%%%% UNEXPLODED AMUNITIONS%%%%%%%%%
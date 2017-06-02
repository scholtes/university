function [der] = num_der(dep, indep)
%my_num_der takes derivative of dep with respect to indep
dt = indep(2)-indep(1);
der = zeros(1, length(indep));
der(1) = (dep(2)-dep(1))/dt;
der(2:length(indep)-1) = (dep(3:length(indep)) - dep(1:length(indep)-2))/(2*dt);
der(length(indep)) = (dep(length(indep)) - dep(length(indep)-1))/dt;
end
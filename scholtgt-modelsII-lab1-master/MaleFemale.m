% Author:   Garrett Scholtes
% Date:     2015-01-18
% This script compares percentages of males and females in school
% for a given country.

%%% TEMP INPUTS %%%
load('Demographic_Data.mat');
country = 'Egypt';
%%% END INPUTS  %%%

%%% CONSTANTS  %%%
UNAVAILABLE = -9999;
%%% END CONSTS %%%

% Sift out data that isn't for this country
indicies = find(ismember(Demographic_Data.Country, country));
country_data = Demographic_Data(indicies, [1 2 4 5 6 7 8]);

% Sift out rows that have missing data for male percent or female percent
condition = country_data.School_F ~= UNAVAILABLE & country_data.School_M ~= UNAVAILABLE;
male_female = country_data(condition, [1 2 6 7]);

% Plot the data
plot(male_female.Year, male_female.School_M, 'b*', male_female.Year, male_female.School_F, 'r*');
axis([min(male_female.Year)-1 max(male_female.Year)+1 0 100]);
xlabel('Year')
ylabel('Percent gender in school');
title(sprintf('Percent %s Population in School by Gender', char(country)));
legend('% Male','% Female');
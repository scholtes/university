% Author:   Garrett Scholtes
% Date:     2015-01-14
% This script compares literacy rates to population of the poor and average
% incomes.

clear;

%%% TEMPORARY INPUTS %%%
% These should be changed to parameters in future... or something, just not
% hard coded in like this.
load('Demographic_Data.mat');
countries = {'China' 'Russian Federation' 'Pakistan'};
%%% END TEMPR INPUTS  %%%

%%% CONSTANTS %%%
UNAVAILABLE = -9999;
HEIGHT = ceil(length(countries)/2);
%%% END CONST %%%

figure;
subplotcount = 1;
for country = countries
    subplot(HEIGHT,2,subplotcount);
    subplotcount = subplotcount+1;
    
    %%% Analyze the data individually for each country
    indicies = find(ismember(Demographic_Data.Country, country));
    country_data = Demographic_Data(indicies, [1 2 4 5 6]);
    
    display(country_data);
    %%% Compare average income to literacy rate
    condition = country_data.Income ~= UNAVAILABLE & country_data.Literacy ~= UNAVAILABLE;
    income_literacy_data = country_data(condition, [1 2 3 5]);
    display(income_literacy_data);
    
    % Plot income vs year and literacy rate vs year on same plot
    [ax,p1,p2]=plotyy(income_literacy_data.Year, income_literacy_data.Income, income_literacy_data.Year, income_literacy_data.Literacy);
    xlabel(ax(1), 'Time');
    ylabel(ax(1), 'Average Icome (USD)');
    ylabel(ax(2), 'Literacy Rate (% population)');
    set(p1, 'marker', '*', 'color', 'b');
    set(p2, 'marker', '*', 'color', 'g');
    set(ax(1), 'YLim', [0 1.5*max(income_literacy_data.Income)]);
    set(ax(2), 'YLim', [0 100]);
    set(ax(1), 'XLim', [min(income_literacy_data.Year)-1, max(income_literacy_data.Year)+1]);
    set(ax(2), 'XLim', [min(income_literacy_data.Year)-1, max(income_literacy_data.Year)+1]);
    title(sprintf('Income and Literacy rate vs Year for %s',char(country)));
end
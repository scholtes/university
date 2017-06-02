% Authors: Thorin Rothenbuhler, Daniel Vonderhaar, Garrett Scholtes
% Date:    2015-01-21
% 
% This script is for Models II, Lab 1.  The script allows analysis of
% demographic data for various countries.
%
% 7/7 of the Lecture topics from Models 1 have been used in this
% script (5/7 were required).  These have been identified throughout the
% script in various comments.
%
% Good sample countries:
% 1. Fiji, China, Japan
% 2. China
% 3. China, Russian Federation, Pakistan
% 4. Egypt

clear;

load('Demographic_Data');

% This is the initial instruction dialogue
msgbox({'Instructions:','','1. Choose a dataset to analyze from the menu','2. Press "Okay" on the box that pops up','3. Go to the console and type in countries one line at a time.','4. A figure will pop up with the requested information','5. Repeat','','If a figure pops up blank, it is likely due to no data being available for that country in the requested dataset.','','See the script comments for examples of good countries to choose.'});

% Loops (For/While)
% Main loop
while 1
    
    % Ask which data to see
    data_choice = menu('Choose a dataset to analyze', 'Age Group Populations', 'Population by Year', 'Literacy Rate and Income', 'Education by Gender');
    % Conditional statements
    if data_choice == 0
        fprintf('Exiting... thank you\n');
        break;
    end
    number_countries = [2 1 2 1];
    number_countries = number_countries(data_choice);
    countries = {1:number_countries};

    msgbox('Go to MATLAB console to input countries');

    % Output statements
    fprintf('Input %d countrie(s) below (one on each line)\n', number_countries);
    for i = 1:number_countries
        % Input statements
        countries(i) = cellstr(input(sprintf('Country (%d/%d): ',i,number_countries),'s'));
    end
    
    % This selects which data to analyze.  Each case was written by a
    % different member of the team.
    figure;
    try
        % Conditional statements
        switch(data_choice)
            case 1
                % Age Group Population Trends - Thorin Rothenbuhler
                country = char(countries(1));
                country_2 = char(countries(2));

                c1 = find(ismember(Demographic_Data.Country,country));
                cty_data = Demographic_Data(c1, [1 2 9 10]);

                c2 = find(ismember(Demographic_Data.Country,country_2));
                cty_data_1 = Demographic_Data(c2, [1 2 9 10]);

                yr_c1 = cty_data.Year;
                o60_c1 = cty_data.Over60;
                u15_c1 = cty_data.Under15;

                yr_c2 = cty_data_1.Year;
                o60_c2 = cty_data_1.Over60;
                u15_c2 = cty_data_1.Under15;

                % Curve fitting
                lo_c1 = polyfit(yr_c1,o60_c1,1);
                lu_c1 = polyfit(yr_c1,u15_c1,1);

                lo_c2 = polyfit(yr_c2,o60_c2,1);
                lu_c2 = polyfit(yr_c2,u15_c2,1);

                trend_oc1 = polyval(lo_c1,yr_c1);
                trend_uc1 = polyval(lu_c1,yr_c1);

                trend_oc2 = polyval(lo_c2,yr_c2);
                trend_uc2 = polyval(lu_c2,yr_c2);

                % Graphing in MATLAB
                subplot(1,2,1);plot(yr_c1,o60_c1,'r*',yr_c1,u15_c1,'r.',yr_c1,o60_c2,'g*',yr_c2,u15_c2,'g.')
                title('Yearly Values for Percentage of the Population Under 15 and Above 60 Years Old')
                xlabel('Years')
                ylabel('Percentage of Under 15 and Above 60 Years Old')
                legend(sprintf('%s yearly Over 60 Population',country),sprintf('%s yearly Under 15 Population',country),sprintf('%s yearly Over 60 Population',country_2),sprintf('%s yearly Under 15 Population',country_2),'location','best')
                subplot(1,2,2);plot(yr_c1,trend_oc1,'r-',yr_c1,trend_uc1,'r--',yr_c2,trend_oc2,'g-',yr_c2,trend_uc2,'g--')
                title('Trend for the Percentage of the Population Under 15 and Above 60 Years Old')
                xlabel('Years')
                ylabel('Percentage of Under 15 and Above 60 Years Old')
                legend(sprintf('%s Trend for Over 60 Population',country),sprintf('%s Trend for Under 15 Population',country),sprintf('%s Trend for Above 60 Population',country_2),sprintf('%s Trend for Under 15 Population',country_2),'location','best')

            case 2
                % Total Population Trends - Daniel Vonderhaar
                CountryName = char(countries(1));
                L = find(strcmpi(Demographic_Data.Country, CountryName));

                plot(Demographic_Data.Year(L),Demographic_Data.Population(L),'bo');
                xlabel ('\bfYear');
                ylabel ('\bfPopulation');
                title (sprintf('%sPopulation of %s','\bf', char(CountryName)));

                coeffs = polyfit(Demographic_Data.Year(L),Demographic_Data.Population(L), 1);
                %Define the range where we want the line
                xFit = 1990:2012; 
                %Define the range where we want the line
                yFit = polyval(coeffs, xFit);

                %Plot the fitted line over the specified range.
                hold on; %Don't blow away prior plot
                plot(xFit, yFit,'r-');
                legend ('Population','Trend in Population', 'Location', 'NorthWest');

            case 3
                % Literacy Rate and Income Correlations - Garrett Scholtes
                %%% CONSTANTS %%%
                UNAVAILABLE = -9999;
                HEIGHT = ceil(length(countries)/2);
                %%% END CONST %%%

                subplotcount = 1;
                for country = countries
                    subplot(HEIGHT,2,subplotcount);
                    subplotcount = subplotcount+1;

                    %%% Analyze the data individually for each country
                    indicies = find(ismember(Demographic_Data.Country, country));
                    country_data = Demographic_Data(indicies, [1 2 4 5 6]);

                    %%% Compare average income to literacy rate
                    condition = country_data.Income ~= UNAVAILABLE & country_data.Literacy ~= UNAVAILABLE;
                    income_literacy_data = country_data(condition, [1 2 3 5]);

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

            case 4
                % Gender Equality by Education Trends - Garrett Scholtes
                country = char(countries(1));
                %%% CONSTANTS  %%%
                UNAVAILABLE = -9999;
                %%% END CONSTS %%%

                % Array Functions
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
        end
    catch err
        fprintf('Error occured.  Likely due to no data available for those countries.\n');
    end

end
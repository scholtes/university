% Team Project 1
% Danny Vonderhaar, Garrett Sholtes, Thorin Rothenbuhler
% Dr. Rost
%% Population vs. Year
clear all;
clc;
load Demographic_Data
pick = menu ('Please select the data of interest:','Population','Literacy rate vs. Annual Income','Gender Percentages in primary education','Population Percentages over the age of 60')
%This prompts the user to pick the topic of interest
Choice = char(pick);
switch Choice
     case 1; %Population
         x=0
        while x==0;
        %Ask user for the desired country they want to know about
        CountryName = input('Please enter the country of interst (Example: Japan): \n', 's');
        %Input the country of interest, (not case sensitive)
        %If it asks again, that means there was no match for the entire matrix of the loop
        L = find(strcmpi(Demographic_Data.Country, CountryName)); 
        %Finds the correct country name inputed by user and its length L
        if length(L)==0;
            x=0;
        else
            x=1;
        end
        end

plot(Demographic_Data.Year(L),Demographic_Data.Population(L),'bo')
xlabel ('Year')
ylabel ('Population')
title (sprintf('Population of %s', char(CountryName)))
legend ('Population','Trend in Population')

coeffs = polyfit(Demographic_Data.Year(L),Demographic_Data.Population(L), 1)
%Define the range where we want the line
xFit = 1990:2012; 
%Define the range where we want the line
yFit = polyval(coeffs, xFit);

%Plot the fitted line over the specified range.
hold on; %Don't blow away prior plot
plot(xFit, yFit,'r-');
legend ('Population','Trend in Population')
end

        





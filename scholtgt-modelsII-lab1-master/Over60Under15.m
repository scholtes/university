load Demographic_Data;

country = 'Fiji';
country_2 = 'China';

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

lo_c1 = polyfit(yr_c1,o60_c1,1);
lu_c1 = polyfit(yr_c1,u15_c1,1);

lo_c2 = polyfit(yr_c2,o60_c2,1);
lu_c2 = polyfit(yr_c2,u15_c2,1);

trend_oc1 = polyval(lo_c1,yr_c1);
trend_uc1 = polyval(lu_c1,yr_c1);

trend_oc2 = polyval(lo_c2,yr_c2);
trend_uc2 = polyval(lu_c2,yr_c2);


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
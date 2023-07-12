# Bayesian-Analysis-of-Change-Point-Problems

Water level (depth of lake) of lakes in Minnesota State has experienced abrupt change. This study uses the Bayesian change point analysis methods given in Wang and Emerson (2015) to detect the change point in water level.  

Data: Prcp_Level.csv

valid_lake_level.R: read the Data, user needs to input parameter y to indicate which year should be performed the change point analysis.

get_water_level.R: convert the water level value into a list. 

create_month_year: input the start year, end year, start month, and end month to generate a list of DateTime.

change_point.R: implement the change point pattern analysis. 

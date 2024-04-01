# Load necessary libraries
library(dplyr)
library(lubridate)
library(ggplot2)

# Read the datasets
food_bank_usage <- read.csv('food bank usage.csv')
business_bankruptcies <- read.csv('Number of Business Bankruptcies for the City of Toronto.csv')

# Convert Period to a date format that includes the year and month
food_bank_usage$Date <- as.Date(paste(food_bank_usage$Year, food_bank_usage$Period, "1", sep="-"), format="%Y-%b-%d")
business_bankruptcies$Date <- as.Date(paste(business_bankruptcies$Year, business_bankruptcies$Period, "1", sep="-"), format="%Y-%b-%d")

# Filter the data for the period from Jan 2018 to Nov 2023
food_bank_usage <- food_bank_usage %>% filter(Date >= as.Date("2018-01-01") & Date <= as.Date("2023-11-30"))
business_bankruptcies <- business_bankruptcies %>% filter(Date >= as.Date("2018-01-01") & Date <= as.Date("2023-11-30"))

# Merge datasets by Date
merged_data <- merge(food_bank_usage, business_bankruptcies, by="Date")
# Reformat the dataset to reduce the number of columns
merged_data <- merged_data %>%
  select(Date, year = Year.x, month = Period.x, food_bank_usage = Value.x, num_of_bankruptcies = Value.y)

write.csv(merged_data, "inputs/cleaned_data.csv", row.names = FALSE)
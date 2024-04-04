#### Simulate data ####
# set the seed
set.seed(200)

# Load necessary library
library(tibble)
library(lubridate)
library(arrow)
# Define the start and end dates of the simulated period
start_date <- ymd("2018-01-01")
end_date <- ymd("2023-11-01")

# Create a sequence of months between the start and end dates
date_seq <- seq(from = start_date, to = end_date, by = "month")

# Generate random values between 50000 and 300000 to simulate usage of food bank
sim_food_bank_usage_values <- runif(length(date_seq), min = 50000, max = 300000)

# Generate random values between 10 and 40 to simulate the number of bankrupcies
sim_num_of_bankruptcies <- runif(length(date_seq), min = 10, max = 40)

# Create the simulated dataframe
simulated_dataset <- tibble(
  year = year(date_seq),
  month = month(date_seq, label = TRUE, abbr = TRUE),
  food_bank_usage = round(sim_food_bank_usage_values),
  num_of_bankruyptcies = round(sim_num_of_bankruptcies)
)

# Write the simulated dataset into a parquet file
write_parquet(simulated_dataset, "inputs/simulated.parquet")
# Write the simulated dataset into a csv file as well
write.csv(simulated_dataset, file = "inputs/simulated.csv", row.names = FALSE)


# Function to test if year is a legal year
validate_year <- function(data) {
  current_year <- as.numeric(format(Sys.Date(), "%Y"))  # Get the current year
  
  # Check if 'year' column exists
  if (!"year" %in% names(data)) {
    return(FALSE)
  }
  
  # Check if all year values are integers within the range 1900 to current year
  return(all(data$year >= 1900 & data$year <= current_year & data$year == as.integer(data$year)))
}
# Funciton to test if month column falls within Jan to Dec.
validate_month <- function(data) {
  # Check if 'month' column exists
  if (!"month" %in% names(data)) {
    return(FALSE)
  }
  
  # Define the expected month abbreviations
  expected_months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  
  # Check if all month values are in the expected set of abbreviations
  return(all(data$month %in% expected_months))
}

# Function to check if all values in "food_bank_usage" are non-negative integers
validate_food_bank_usage <- function(data) {
  if (!"food_bank_usage" %in% names(data)) {
    return(FALSE)
  }
  return(all(data$food_bank_usage >= 0 & data$food_bank_usage == as.integer(data$food_bank_usage)))
}

# Function to check if all values in 'num_of_bankruptcies' are non-negative integers
validate_num_of_bankruptcies <- function(data) {
  if (!"num_of_bankruptcies" %in% names(data)) {
    return(FALSE)
  }
  return(all(data$num_of_bankruptcies >= 0 & data$num_of_bankruptcies == as.integer(data$num_of_bankruptcies)))
}

# Read the dataset
library(readr)
data <- read_csv("inputs/cleaned_data.csv", show_col_types = FALSE) 

# apply all the tests
year_testing_result <- validate_year(data)
month_testing_result <- validate_months(data)
bankruptcies_testing_result <- validate_num_of_bankruptcies(data)
food_bank_usage_testing_result <- validate_food_bank_usage(data)

# Combining results
test_results <- c(year_testing_result, month_testing_result, 
                  bankruptcies_testing_result, food_bank_usage_testing_result)
# Print results
print(test_results)
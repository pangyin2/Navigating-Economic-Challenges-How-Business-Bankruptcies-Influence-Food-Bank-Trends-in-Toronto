# Load necessary libraries
library(dplyr)
library(lubridate)
library(ggplot2)

# Read the datasets
merged_data <- read.csv('inputs/cleaned_data.csv')
# Convert 'Date' to Date object if it is not already
merged_data$Date <- as.Date(merged_data$Date)

# Linear Regression Model
model <- lm(food_bank_usage ~ num_of_bankruptcies, data = merged_data)

# Summary of the linear model
model_summary <- summary(model)

# Capture the coefficients to a data frame
coefficients_df <- as.data.frame(coef(model_summary))

# Save the coefficients to a CSV file
write.csv(coefficients_df, "linear_model_coefficients.csv", row.names = TRUE)

# If you want to capture more details from the summary, you can manually create a data frame
# Here we capture the coefficients, their standard errors, t-values, and p-values
summary_df <- data.frame(
  Estimate = coef(model_summary)[, "Estimate"],
  StdError = coef(model_summary)[, "Std. Error"],
  tValue = coef(model_summary)[, "t value"],
  Pr = coef(model_summary)[, "Pr(>|t|)"]
)
summary_df
# Save the detailed summary to a CSV file
write.csv(summary_df, "linear_model_detailed_summary.csv", row.names = FALSE)

# Plot the graph of business bankruptcies across time
ggplot(data = merged_data, aes(x = Date, y = num_of_bankruptcies)) +
  geom_line() +
  labs(title = "Number of Business Bankruptcies over Time", x = "Date", y = "Number of Bankruptcies")

# Save the plot
ggsave("business_bankruptcies_over_time.png", width = 10, height = 6)

# Plot the graph of food bank usage across time
ggplot(data = merged_data, aes(x = Date, y = food_bank_usage)) +
  geom_line() +
  labs(title = "Food Bank Usage over Time", x = "Date", y = "Food Bank Usage")

# Save the plot
ggsave("food_bank_usage_over_time.png", width = 10, height = 6)


# Load necessary libraries

# Linear Regression Model
model <- lm(food_bank_usage ~ num_of_bankruptcies, data = merged_data)

# Creating the plot
ggplot(merged_data, aes(x = num_of_bankruptcies, y = food_bank_usage)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(x = "Number of Business Bankruptcies", y = "Food Bank Usage", title = "Linear Model of Food Bank Usage vs. Business Bankruptcies") +
  theme_minimal()

# Save the plot
ggsave("linear_model_plot.png", width = 10, height = 6)


# Enhancement: API for the linear model
#install.packages("plumber")
library(plumber)
function(num_of_bankruptcies) {
  if (missing(num_of_bankruptcies)) {
    return(list(error = "num_of_bankruptcies is missing"))
  }
  
  # Ensure input is a number
  num_of_bankruptcies <- as.numeric(num_of_bankruptcies)
  
  # Make prediction
  prediction <- predict(model, newdata = data.frame(num_of_bankruptcies = num_of_bankruptcies))
  
  return(list(prediction = prediction))
}
# To run the API, uncomment the following line
# plumb("model_api.R")$run(port=8000)
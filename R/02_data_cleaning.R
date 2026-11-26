install.packages(c(
  "tidyverse",
  "here",
  "skimr",
  "naniar"
))

library(tidyverse)
library(here)
library(skimr)
library(naniar)

raw_data <- read_csv(
  here("data", "raw", "smartwatch_uncleaned.csv"),
  show_col_types = FALSE
)

dim(raw_data)
names(raw_data)
str(raw_data)
summary(raw_data)
skim(raw_data)

missing_summary <- data.frame(
  Variable = names(raw_data),
  Missing_Count = colSums(is.na(raw_data)),
  Missing_Percentage = round(
    colMeans(is.na(raw_data)) * 100, 2
  )
)

print(missing_summary)

write_csv(
  missing_summary,
  here("outputs", "tables", "missing_values_before.csv")
)

missing_plot <- vis_miss(raw_data)

ggsave(
  here("outputs", "plots", "missing_values_before.png"),
  plot = missing_plot,
  width = 10,
  height = 6
)

# Investigate incorrect values 
# Sleep Duration Investigation
# Display unique sleep duration values
unique(raw_data$`Sleep Duration (hours)`)

# Store sleep duration values
sleep_values <- raw_data$`Sleep Duration (hours)`

# Identify invalid non-numeric values
sleep_invalid <- sleep_values[
  !is.na(sleep_values) &
    is.na(suppressWarnings(as.numeric(sleep_values)))
]

# Display invalid values
unique(sleep_invalid)

# Count invalid entries
length(sleep_invalid)

# Create a working copy
cleaned_data <- raw_data

# Convert Sleep Duration to numeric
cleaned_data <- cleaned_data %>%
  mutate(
    `Sleep Duration (hours)` =
      suppressWarnings(
        as.numeric(`Sleep Duration (hours)`)
      )
  )

summary(cleaned_data$`Sleep Duration (hours)`)

range(
  cleaned_data$`Sleep Duration (hours)`,
  na.rm = TRUE
)

# Activity Level Investigation

# Display unique activity categories
unique(raw_data$`Activity Level`)

# Count each category
raw_data %>%
  count(`Activity Level`, sort = TRUE)

cleaned_data <- cleaned_data %>%
  mutate(
    `Activity Level` = str_to_lower(
      str_trim(`Activity Level`)
    ),
    
    `Activity Level` = str_replace_all(
      `Activity Level`, "_", " "
    ),
    
    `Activity Level` = case_when(
      
      `Activity Level` %in%
        c("seddentary", "sedentary") ~ "Sedentary",
      
      `Activity Level` %in%
        c("actve", "active") ~ "Active",
      
      `Activity Level` == "highly active" ~ "Highly Active",
      
      TRUE ~ str_to_title(`Activity Level`)
    )
  )

cleaned_data %>%
  count(`Activity Level`, sort = TRUE)

activity_level_summary <- cleaned_data %>%
  count(`Activity Level`, name = "Frequency")

write_csv(
  activity_level_summary,
  here("outputs", "tables", "activity_level_summary.csv")
)

# Stress Level Investigation

# Display unique values
unique(raw_data$`Stress Level`)

# Count frequencies
raw_data %>%
  count(`Stress Level`, sort = TRUE)

cleaned_data <- cleaned_data %>%
  mutate(
    `Stress Level` = str_trim(
      as.character(`Stress Level`)
    )
  )

stress_level_summary <- cleaned_data %>%
  count(`Stress Level`, name = "Frequency")

write_csv(
  stress_level_summary,
  here("outputs", "tables", "stress_level_summary.csv")
)

# Identify duplicate records

# Count exact duplicate rows in original dataset
sum(duplicated(raw_data))

# Count occurrences of each User ID
raw_data %>%
  count(`User ID`, sort = TRUE)

# Count exact duplicates in cleaned dataset
sum(duplicated(cleaned_data))

# Outlier investigation
# Heart Rate

# Statistical summary
summary(cleaned_data$`Heart Rate (BPM)`)

# Create boxplot
heart_rate_plot <- ggplot(
  cleaned_data,
  aes(y = `Heart Rate (BPM)`)
) +
  geom_boxplot() +
  labs(
    title = "Heart Rate Outlier Investigation",
    y = "Heart Rate (BPM)"
  ) +
  theme_minimal()

# Display plot
print(heart_rate_plot)

ggsave(
  here("outputs", "plots", "heart_rate_boxplot.png"),
  plot = heart_rate_plot,
  width = 8,
  height = 6
)

# Blood Oxygen Level

summary(cleaned_data$`Blood Oxygen Level (%)`)

blood_oxygen_plot <- ggplot(
  cleaned_data,
  aes(y = `Blood Oxygen Level (%)`)
) +
  geom_boxplot() +
  labs(
    title = "Blood Oxygen Outlier Investigation",
    y = "Blood Oxygen Level (%)"
  ) +
  theme_minimal()

print(blood_oxygen_plot)

ggsave(
  here("outputs", "plots", "blood_oxygen_boxplot.png"),
  plot = blood_oxygen_plot,
  width = 8,
  height = 6
)

# Step Count

summary(cleaned_data$`Step Count`)

step_count_plot <- ggplot(
  cleaned_data,
  aes(y = `Step Count`)
) +
  geom_boxplot() +
  labs(
    title = "Step Count Outlier Investigation",
    y = "Step Count"
  ) +
  theme_minimal()

print(step_count_plot)

ggsave(
  here("outputs", "plots", "step_count_boxplot.png"),
  plot = step_count_plot,
  width = 8,
  height = 6
)

# Sleep Duration

summary(cleaned_data$`Sleep Duration (hours)`)

sleep_duration_plot <- ggplot(
  cleaned_data,
  aes(y = `Sleep Duration (hours)`)
) +
  geom_boxplot() +
  labs(
    title = "Sleep Duration Outlier Investigation",
    y = "Sleep Duration (hours)"
  ) +
  theme_minimal()

print(sleep_duration_plot)

ggsave(
  here("outputs", "plots", "sleep_duration_boxplot.png"),
  plot = sleep_duration_plot,
  width = 8,
  height = 6
)

# IQR outlier identification function

identify_outliers <- function(data, variable_name) {
  
  values <- data[[variable_name]]
  
  Q1 <- quantile(values, 0.25, na.rm = TRUE)
  Q3 <- quantile(values, 0.75, na.rm = TRUE)
  
  IQR_value <- IQR(values, na.rm = TRUE)
  
  lower_limit <- Q1 - 1.5 * IQR_value
  upper_limit <- Q3 + 1.5 * IQR_value
  
  outliers <- data %>%
    filter(
      .data[[variable_name]] < lower_limit |
        .data[[variable_name]] > upper_limit
    ) %>%
    mutate(
      Variable = variable_name,
      Lower_Limit = as.numeric(lower_limit),
      Upper_Limit = as.numeric(upper_limit)
    )
  
  return(outliers)
}

heart_rate_outliers <- identify_outliers(
  cleaned_data, "Heart Rate (BPM)"
)

blood_oxygen_outliers <- identify_outliers(
  cleaned_data, "Blood Oxygen Level (%)"
)

step_count_outliers <- identify_outliers(
  cleaned_data, "Step Count"
)

sleep_duration_outliers <- identify_outliers(
  cleaned_data, "Sleep Duration (hours)"
)

potential_outliers <- bind_rows(
  heart_rate_outliers,
  blood_oxygen_outliers,
  step_count_outliers,
  sleep_duration_outliers
)

write_csv(
  potential_outliers,
  here("outputs", "tables", "potential_outliers.csv")
)


# Misssing value handling decisions
cleaning_decisions <- data.frame(
  
  Variable = c(
    "User ID",
    "Heart Rate (BPM)",
    "Blood Oxygen Level (%)",
    "Step Count",
    "Sleep Duration (hours)",
    "Activity Level",
    "Stress Level"
  ),
  
  Problem = c(
    "Missing identifiers",
    "Missing measurements",
    "Missing measurements",
    "Missing measurements",
    "Missing and invalid text values",
    "Inconsistent spelling",
    "Mixed representations"
  ),
  
  Proposed_Action = c(
    "Investigate suitability for user-level analysis",
    "Evaluate suitable imputation or analysis-specific handling",
    "Evaluate separately",
    "Evaluate separately",
    "Convert invalid text to NA and investigate imputation",
    "Standardise known spelling variations",
    "Investigate meaning before standardisation"
  )
)

print(cleaning_decisions)

# Example: Median imputation for Heart Rate

heart_rate_median <- median(
  cleaned_data$`Heart Rate (BPM)`,
  na.rm = TRUE
)

cleaned_data$`Heart Rate (BPM)`[
  is.na(cleaned_data$`Heart Rate (BPM)`)
] <- heart_rate_median

# Final cleaned dataset

# Check dimensions
dim(cleaned_data)

# Check structure
str(cleaned_data)

# Check summary
summary(cleaned_data)

# Check missing values
colSums(is.na(cleaned_data))

# Check duplicate records
sum(duplicated(cleaned_data))

write_csv(
  cleaned_data,
  here("data", "processed", "smartwatch_cleaned.csv")
)

# Check Activity Level
cleaned_data %>%
  count(`Activity Level`)

# Check Stress Level
cleaned_data %>%
  count(`Stress Level`)

# Supporting outputs
# Missing values after cleaning

missing_after <- data.frame(
  Variable = names(cleaned_data),
  
  Missing_Count = colSums(is.na(cleaned_data)),
  
  Missing_Percentage = round(
    colMeans(is.na(cleaned_data)) * 100, 2
  )
)

print(missing_after)

write_csv(
  missing_after,
  here("outputs", "tables", "missing_values_after.csv")
)

activity_level_summary <- cleaned_data %>%
  count(`Activity Level`, name = "Frequency")

write_csv(
  activity_level_summary,
  here("outputs", "tables", "activity_level_summary.csv")
)

stress_level_summary <- cleaned_data %>%
  count(`Stress Level`, name = "Frequency")

write_csv(
  stress_level_summary,
  here("outputs", "tables", "stress_level_summary.csv")
)

# Original and cleaned dataset dimensions

original_rows <- nrow(raw_data)
original_columns <- ncol(raw_data)

final_rows <- nrow(cleaned_data)
final_columns <- ncol(cleaned_data)

# Missing values
missing_before <- sum(is.na(raw_data))
missing_after_count <- sum(is.na(cleaned_data))

# Duplicate counts
duplicates_before <- sum(duplicated(raw_data))
duplicates_after <- sum(duplicated(cleaned_data))

# Create cleaning summary
cleaning_summary <- data.frame(
  Metric = c(
    "Original Rows",
    "Original Columns",
    "Missing Values Before Cleaning",
    "Missing Values After Cleaning",
    "Exact Duplicates Before Cleaning",
    "Exact Duplicates After Cleaning",
    "Potential Outlier Records Identified",
    "Final Rows",
    "Final Columns"
  ),
  
  Value = c(
    original_rows,
    original_columns,
    missing_before,
    missing_after_count,
    duplicates_before,
    duplicates_after,
    nrow(potential_outliers),
    final_rows,
    final_columns
  )
)

print(cleaning_summary)

# Export cleaning summary
write_csv(
  cleaning_summary,
  here("outputs", "tables", "cleaning_summary.csv")
)

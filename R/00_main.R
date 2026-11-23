
# PROJECT: Smartwatch Health Analytics
# SCRIPT: Main Workflow
# PURPOSE: Load packages, define paths and run project scripts

# 1. Load required libraries

library(tidyverse)
library(janitor)
library(skimr)
library(naniar)
library(here)

# 2. Define project paths

project_root <- here::here()

raw_data_path <- here::here(
  "data", "raw", "smartwatch_uncleaned.csv"
)

processed_data_path <- here::here(
  "data", "processed", "smartwatch_cleaned.csv"
)

# 3. Check whether the original dataset exists

if (!file.exists(raw_data_path)) {
  stop("Original dataset not found. Check the data/raw folder.")
}

# 4. Load the original dataset

raw_data <- readr::read_csv(
  raw_data_path,
  show_col_types = FALSE
)

# 5. Display basic dataset information

cat("SMARTWATCH HEALTH ANALYTICS PROJECT\n")

cat("Number of rows:", nrow(raw_data), "\n")
cat("Number of columns:", ncol(raw_data), "\n")

cat("\nColumn names:\n")
print(names(raw_data))

# 6. Run initial data validation

source(here::here("R", "01_data_validation.R"))

validate_dataset(raw_data)

# 7. Future workflow
# Additional scripts will be connected here as they are completed.

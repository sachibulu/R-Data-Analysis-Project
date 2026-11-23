
# ============================================================
# SCRIPT: Initial Data Validation
# RESPONSIBILITY: Member 1
# PURPOSE: Examine the dataset structure and basic data quality
# ============================================================

validate_dataset <- function(data) {
  
  # 1. Dataset dimensions
  cat("\n--- DATASET DIMENSIONS ---\n")
  print(dim(data))
  
  # 2. Column names
  cat("\n--- COLUMN NAMES ---\n")
  print(names(data))
  
  # 3. Variable data types
  cat("\n--- DATA TYPES ---\n")
  
  data_types <- vapply(
    data,
    function(x) paste(class(x), collapse = ", "),
    character(1)
  )
  
  print(data_types)
  
  # 4. Missing values
  cat("\n--- MISSING VALUES ---\n")
  
  missing_summary <- data.frame(
    Variable = names(data),
    Missing_Values = colSums(is.na(data))
  )
  
  print(missing_summary)
  
  # 5. Exact duplicate rows
  cat("\n--- EXACT DUPLICATE ROWS ---\n")
  
  duplicate_count <- sum(duplicated(data))
  
  print(duplicate_count)
  
  cat("\n--- VALIDATION COMPLETED ---\n")
}

#member3-feature engineering
library(ggplot2)
#load cleaned dataset
cleaned_data <- read.csv("data/processed/smartwatch_cleaned.csv")
#check dataset
head(cleaned_data)

#create step count group
cleaned_data$Step_Count_Group <- ifelse(
  cleaned_data[[4]] < 5000, "Lower",
  ifelse(cleaned_data[[4]] < 10000, "Middle", "Higher")
)

#check step count groups
table(cleaned_data$Step_Count_Group)

#create sleep category
cleaned_data$Sleep_Category <- ifelse(
  cleaned_data[[5]] < 7, "Short",
  ifelse(cleaned_data[[5]] <= 9, "Moderate", "Long")
)

#check sleep category
table(cleaned_data$Sleep_Category)


#create activity category
cleaned_data$Activity_Category <- cleaned_data[[6]]

#check activity category
table(cleaned_data$Activity_Category, useNA = "ifany")

#create heart rate group
cleaned_data$Heart_Rate_Group <- ifelse(
  cleaned_data[[2]] < 60, "Lower",
  ifelse(cleaned_data[[2]] <= 100, "Normal", "Higher")
)

#check heart rate group
table(cleaned_data$Heart_Rate_Group)

#create feature summary
feature_summary <- data.frame(
  Feature = c("Step Count Group", "Sleep Category",
              "Activity Category","Heart Rate Group"),
  Number_of_Categories = c(
    length(unique(na.omit(cleaned_data$Step_Count_Group))),
    length(unique(na.omit(cleaned_data$Sleep_Category))),
    length(unique(na.omit(cleaned_data$Activity_Category))),
    length(unique(na.omit(cleaned_data$Heart_Rate_Group)))
  
  )
)
print(feature_summary)


write.csv(
  feature_summary,
  "outputs/tables/feature_summary.csv",
  row.names = FALSE
)

#export final feature dataset
write.csv(
  cleaned_data,
  "data/processed/smartwatch_features.csv",
  row.names = FALSE
)








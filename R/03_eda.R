#EDA
#load package
library(ggplot2)
#load clean dataset
cleaned_data <- read.csv("data/processed/smartwatch_cleaned.csv")
#view dataset
head(cleaned_data)
#dataset structure
str(cleaned_data)
#summary of dataset
summary(cleaned_data)

#heart rate dis
ggplot(cleaned_data, aes(x=Heart.Rate..BPM.))+
  geom_histogram(bins = 30, fill = "lightblue", color="black") +
  labs(
    title="Heart Rate Distribution",
    x="Heart Rate (BPM)",
    y = "Frequency"
  )+
  theme_minimal()

#blood oxygen level distribution
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[3]]])) +
  geom_histogram(bins=30, fill ="lightgreen", color="black") +
  labs(
    title="Blood Oxygen Level Distribution",
    x="Blood Oxygen Level(%)",
    y ="Frequency"
) +
  theme_minimal()
#sleep duration distribution
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[5]]])) +
  geom_histogram(bins =30, fill ="lightpink", color = "black") +
  labs(
    title="Sleep Duration Distribution",
    x="Sleep Duration(hours)",
    y="Frequency"
  )+
  theme_minimal()
#step count distribution

ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[4]]])) +
  geom_histogram(bins = 30, fill = "orange", color = "black") +
  labs(
    title = "Step Count Distribution",
    x = "Step Count",
    y = "Frequency"
  ) +
  theme_minimal()


#activity level distribution

ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[6]]])) +
  geom_bar(fill = "lightblue", color = "black") +
  labs(
    title = "Activity Level Distribution",
    x = "Activity Level",
    y = "Frequency"
  ) 
  theme_minimal()
#stress level distribution
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[7]]])) +
  geom_bar(fill = "lightgreen", color = "black") +
  labs(
    title = "Stress Level Distribution",
    x = "Stress Level",
    y = "Frequency"
  ) +
  theme_minimal()
  
#step count,heart rate
ggplot(cleaned_data, aes(x=.data[[names(cleaned_data)[4]]],
                         y=.data[[names(cleaned_data)[2]]])) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se= TRUE) +
  labs(title="Step Count vs Heart Rate",
       x="Step Count",
       y= "Heart Rate(BPM)") +
  theme_minimal()

#step count, sleep duration
ggplot(cleaned_data, aes(x=.data[[names(cleaned_data)[4]]],
                         y=.data[[names(cleaned_data)[5]]])) +
  geom_point(alpha =0.5) +
  geom_smooth(method = "lm", se= TRUE) +
  labs(title = "Step Count vs Sleep Duration",
       x="Step Count",
       y = "Sleep Duration(hours)") +
  theme_minimal()

# sleep duration,blood oxygen level
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[5]]],
                         y = .data[[names(cleaned_data)[3]]])) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Sleep Duration vs Blood Oxygen Level",
       x = "Sleep Duration (hours)",
       y = "Blood Oxygen Level") +
  theme_minimal()
  
# stress level, sleep duration
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[7]]],
                         y = .data[[names(cleaned_data)[5]]])) +
  geom_boxplot() +
  labs(title = "Stress Level vs Sleep Duration",
       x = "Stress Level",
       y = "Sleep Duration (hours)") +
  theme_minimal()

#activity level,step Count
ggplot(cleaned_data, aes(x = .data[[names(cleaned_data)[6]]],
                         y = .data[[names(cleaned_data)[4]]])) +
  geom_boxplot() +
  labs(title = "Activity Level vs Step Count",
       x = "Activity Level",
       y = "Step Count") +
  theme_minimal()



#correlation analysis

numeric_data <- cleaned_data[, sapply(cleaned_data, is.numeric)]

#remove user id column
numeric_data <- numeric_data[, -1]

correlation_matrix <- cor(numeric_data, use = "pairwise.complete.obs")

print(correlation_matrix)

write.csv(correlation_matrix,
          "outputs/tables/correlation_matrix.csv")


#numeric summary

numeric_summary <- data.frame(
  Variable = names(cleaned_data)[2:5],
  Mean = sapply(cleaned_data[2:5], mean, na.rm = TRUE),
  Median = sapply(cleaned_data[2:5], median, na.rm = TRUE),
  SD = sapply(cleaned_data[2:5], sd, na.rm = TRUE),
  Minimum = sapply(cleaned_data[2:5], min, na.rm = TRUE),
  Maximum = sapply(cleaned_data[2:5], max, na.rm = TRUE)
)

print(numeric_summary)

write.csv(numeric_summary,
          "outputs/tables/numeric_summary.csv",
          row.names = FALSE)

#activity level frequency
table(cleaned_data[[6]])
#stress level frequency
table(cleaned_data[[7]])

table(cleaned_data[[6]],useNA="ifany")
table(cleaned_data[[7]],useNA="ifany")


#heart rate boxplot
ggplot(cleaned_data, aes(y = .data[[names(cleaned_data)[2]]])) +
  geom_boxplot() +
  labs(title = "Heart Rate Boxplot",
       y = "Heart Rate (BPM)") +
  theme_minimal()

#blood oxygen boxplot
ggplot(cleaned_data, aes(y = .data[[names(cleaned_data)[3]]])) +
  geom_boxplot() +
  labs(title = "Blood Oxygen Level Boxplot",
       y = "Blood Oxygen Level") +
  theme_minimal()

#step count boxplot
ggplot(cleaned_data, aes(y = .data[[names(cleaned_data)[4]]])) +
  geom_boxplot() +
  labs(title = "Step Count Boxplot",
       y = "Step Count") +
  theme_minimal()

#sleep duration boxplot
ggplot(cleaned_data, aes(y = .data[[names(cleaned_data)[5]]])) +
  geom_boxplot() +
  labs(title = "Sleep Duration Boxplot",
       y = "Sleep Duration (hours)") +
  theme_minimal()






# Smartwatch Health Analytics: Data Quality, Behavioural Pattern Discovery and Predictive Modelling

## 1. Project Overview

This project focuses on analysing smartwatch health and physical activity data using the R programming language.

The project aims to identify and address data-quality issues in an uncleaned smartwatch dataset, explore relationships between physical activity and health-related measurements, and apply statistical and machine learning techniques to discover meaningful patterns and make predictions.

The analysis will cover data cleaning, exploratory data analysis, feature engineering, clustering, regression, classification and association rule mining.

The findings will be used to develop evidence-based insights that could support data-driven wellness application development and improve the interpretation of smartwatch data.

## 2. Project Objectives

The main objectives are:

- Identify and investigate data-quality issues in the original dataset.
- Clean, transform and validate the smartwatch data using R.
- Perform exploratory data analysis to understand distributions, trends and relationships.
- Create meaningful visualisations to communicate analytical findings.
- Apply feature engineering to prepare suitable variables for modelling.
- Use clustering to discover groups with similar activity and health-measurement patterns.
- Apply regression and classification techniques for predictive analysis.
- Use association rule mining to discover frequently occurring combinations of characteristics.
- Evaluate and compare the performance of the selected models.
- Generate meaningful insights and evidence-based recommendations.

## 3. Dataset Description

**Dataset:** Smartwatch Health Data (Uncleaned)

**Source:** [Kaggle – Smartwatch Health Data Uncleaned](https://www.kaggle.com/datasets/mohammedarfathr/smartwatch-health-data-uncleaned)

The dataset contains approximately 10,000 observations and 7 variables related to smartwatch measurements.

The variables include:

- User ID
- Heart Rate (BPM)
- Blood Oxygen Level (%)
- Step Count
- Sleep Duration (hours)
- Activity Level
- Stress Level

The dataset contains data-quality issues such as missing values, inconsistent categorical labels, incorrect formats and unusual numerical values. These issues will be investigated and handled during the data preparation stage.

**Note:** The dataset is simulated. Findings will be interpreted as patterns within the supplied dataset and not as clinical or medical conclusions.

## 4. Research Questions

1. What data-quality issues are present in the original smartwatch dataset, and how can they be addressed?
2. What relationships exist between physical activity, sleep duration and available health-related measurements?
3. Can observations be grouped into meaningful activity and health-pattern clusters?
4. Can selected numerical measurements and activity categories be predicted using machine learning techniques?
5. What recurring combinations of activity, sleep and stress characteristics can be identified through association rule mining?
6. How effectively do the selected analytical and machine learning techniques perform?

## 5. Methodology

The project will follow these main stages:

### 5.1 Data Understanding and Cleaning
- Inspect the original dataset.
- Identify missing values, duplicates, inconsistent values and unusual observations.
- Perform data cleaning and transformation.
- Validate the cleaned dataset.

### 5.2 Exploratory Data Analysis
- Calculate descriptive statistics.
- Investigate variable distributions and relationships.
- Identify patterns and trends.
- Create visualisations using `ggplot2`.

### 5.3 Feature Engineering
- Create additional useful variables.
- Prepare numerical and categorical features.
- Scale or transform variables where required for modelling.

### 5.4 Machine Learning and Analytical Techniques

The following techniques are planned:

**Clustering**
- K-means clustering.
- Elbow method and silhouette analysis.

**Regression**
- Multiple Linear Regression.
- Random Forest Regression.

**Classification**
- Decision Tree Classification.
- Random Forest Classification.

**Association Rule Mining**
- Apriori algorithm.
- Support, confidence and lift evaluation.

### 5.5 Model Evaluation and Comparison

Appropriate evaluation measures will be selected based on each modelling technique. Model performance, limitations and relevant findings will be examined.

## 6. Technologies and Tools

- **Programming Language:** R
- **Development Environment:** RStudio / R
- **Version Control:** Git and GitHub
- **Data Manipulation:** tidyverse, dplyr, tidyr
- **Data Cleaning:** janitor, skimr, naniar
- **Visualisation:** ggplot2, factoextra
- **Machine Learning:** randomForest, rpart, cluster
- **Association Rule Mining:** arules, arulesViz

## 7. Project Structure

```text
R-Data-Analysis-Project/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── R/
│   ├── 00_main.R
│   ├── 01_data_validation.R
│   ├── 02_data_cleaning.R
│   ├── 03_eda.R
│   ├── 04_feature_engineering.R
│   ├── 05_clustering.R
│   ├── 06_association_rules.R
│   ├── 07_regression.R
│   ├── 08_classification.R
│   ├── 09_model_evaluation.R
│   └── 10_model_comparison.R
│
├── outputs/
│   ├── plots/
│   ├── tables/
│   └── model_results/
│
├── report/
│
├── README.md
└── .gitignore
```

## 8. Team Contributions

The project is divided into five main sections:

| Member | Assigned Responsibilities |
|---|---|
| Member 1 | Project coordination, data validation, project integration and final report |
| Member 2 | Dataset understanding, data inspection and data cleaning |
| Member 3 | Exploratory data analysis, visualisation and feature engineering |
| Member 4 | Clustering and association rule mining |
| Member 5 | Regression, classification and model evaluation |

All members are responsible for contributing to the R implementation and maintaining their assigned project components.

## 9. Expected Outcomes

At the completion of the project, the expected outcomes include:

- A cleaned and validated smartwatch dataset.
- Statistical summaries and exploratory visualisations.
- Meaningful features prepared for analytical modelling.
- Identified clusters of similar activity and health-measurement patterns.
- Regression and classification model results.
- Association rules highlighting recurring combinations of characteristics.
- Model evaluation and performance comparisons.
- Evidence-based findings and recommendations.
- A complete, documented and reproducible R project.

## 10. Project Disclaimer

This project is conducted for academic and educational purposes. The dataset is simulated, and the analysis does not provide medical diagnoses, establish clinical relationships or replace professional healthcare advice.

---

**Project Repository:** [R-Data-Analysis-Project](https://github.com/sachibulu/R-Data-Analysis-Project)

**Coursework Submission Deadline:** 14 December 2026

# Google_Analytics_Capstone_BellaBeat
##### Author: Mark Bozzo
Final project for the Google Data Analytics Professional Certificate. Case study for BellaBeat fitness company
##### Date: April 9th, 2024



## Scenario
Bellabeat has experienced success as a small company, and is looking to grow and hold a significan piece of the pie in the global smart device market. Creative Chief Officer, Urska Srsen, is looking to unlock new growth opportunities in this market by analyzing fitness data from smart devices. This analysis will focus on one of Bellabeat's products of our choosing. We will use publicly available data to gain insights on how customers use their smart devices in areas related to health. Using these insights, we will help develop high level recommendations for our marketing team 

## Business Task
### Background
Bellabeat, a high-tech company that manufactures health-focused smart products for women, is looking to expand its market presence and enhance its marketing strategies. The company offers a range of products designed to help women track their health and wellness data, including activity, sleep, stress, and hydration.

### Objective
The primary objective of this analysis is to leverage smart device usage data to gain insights into consumer behavior and preferences. By understanding how users interact with their smart devices, particularly those related to health and wellness tracking, Bellabeat aims to uncover patterns and trends that can inform strategic marketing decisions.

### Task
Analyze smart device usage data, focusing particularly on one of Bellabeat’s products. The analysis should uncover how consumers use their smart devices in their daily lives and how these usage patterns might influence Bellabeat’s marketing strategies. Key aspects to focus on include:
  1) Trends in smart device usage.
  2) Relationships between smart device data (like steps, sleep quality, and activity levels) and personal wellness.
  3) Insights that could potentially help tailor Bellabeat’s product offerings or marketing messages to better meet consumer needs.

### Company Products
  1) **Bellabeat App:** Provides users with health-related data that includes infromation about their activity levels, sleep, stress, menstrual cycle, and mindfulness habits. Connects to Bellabeat's line of smart wellness products
  2) **Leaf:** Wellness tracker that can be work as a bracelet, necklace, or clip
  3) **Time:** Wellness watch that tracks activity, sleep, and stress
  4) **Spring:** Water bottle that tracks daily water intakeand provides info on hydration levels


## Key Questions
### Here are the key questions we will be considering
  1) What are some trends in smart device usage?
  2) Houw could these trends apply to Bellabeat customers?
  3) How could these trends help influence Bellabeat marketing strategy?

### Stakeholders to consider when answering these questions
  1) **Urska Srsen:** Bellabeat's cofounder and Chief Creative Officer
  2) **Sando Mur:** Mathematician and Bellabeat's cofounder; key member of the Bellabeat executive team
  3) **Bellabeat marketing analytics team** 

### Project Deliverables
  1) Summary of business task
  2) Description of all data sources used
  3) Documentation of any cleaning or manipulation of data
  4) Summary of Analysis
  5) Supporting Visualizations and key findings

## Data Preparation
### Daily Data
##### First, load the data, transform, and combine where necessary. 
```
daily_activity_1 <- read.csv("~/fitness_data/dailyActivity_merged_1.csv")
daily_activity_1$ActivityDate <- as.Date(daily_activity_1$ActivityDate, format = "%m/%d/%Y")
daily_activity_2 <- read.csv("~/fitness_data/dailyActivity_merged_2.csv")
daily_activity_2$ActivityDate <- as.Date(daily_activity_2$ActivityDate, format = "%m/%d/%Y")
daily_activity_merged <- bind_rows(daily_activity_1, daily_activity_2)
daily_sleep <- read.csv("~/fitness_data/sleepDay_merged.csv")
daily_sleep$SleepDay <- as.Date(daily_sleep$SleepDay, format = "%m/%d/%Y")
daily_calories <- read.csv("~/fitness_data/dailyCalories_merged.csv")
daily_calories$ActivityDay <- as.Date(daily_calories$ActivityDay,
                                      format = "%m/%d/%Y")
daily_intensities <- read.csv("~/fitness_data/dailyIntensities_merged.csv")
daily_intensities$ActivityDay <- as.Date(daily_intensities$ActivityDay,
                                         format = "%m/%d/%Y")
daily_steps <- read.csv("~/fitness_data/dailySteps_merged.csv")
daily_steps$ActivityDay <- as.Date(daily_steps$ActivityDay, format = "%m/%d/%Y")
weightLog_1 <- read.csv("~/fitness_data/weightLogInfo_merged_1.csv")
weightLog_1$Date <- as.Date(weightLog_1$Date, format = "%m/%d/%Y")
weightLog_1$IsManualReport <- as.logical(weightLog_1$IsManualReport)
weightLog_2 <- read.csv("~/fitness_data/weightLogInfo_merged_2.csv")
weightLog_2$Date <- as.Date(weightLog_2$Date, format = "%m/%d/%Y")
weightLog_2$IsManualReport <- as.logical(weightLog_2$IsManualReport)
weightLog_merged <- bind_rows(weightLog_1, weightLog_2)
```
##### Check for duplicates in data
```
sum(duplicated(daily_activity_merged))
sum(duplicated(daily_calories))
sum(duplicated(daily_intensities))
sum(duplicated(daily_sleep))
sum(duplicated(daily_steps))
sum(duplicated(weightLog_merged)
```
Daily sleep has 3 duplicates, weight log has 2,  so we will remove those, changing names of other tables for naming consistency
```
daily_sleep_cleaned <- daily_sleep %>% 
  distinct()
daily_weightLog_cleaned <- weightLog_merged %>% 
  distinct()
daily_activity_cleaned <- daily_activity_merged
daily_calories_cleaned <- daily_calories
daily_intensities_cleaned <- daily_intensities
daily_steps_cleaned <- daily_steps
```
##### Combine tables where possible with full joins
```
daily_calories_intensity <- merge(daily_calories_cleaned, 
                                  daily_intensities_cleaned,
                                  by = c("Id", "ActivityDay"), all = TRUE)
daily_combined <- merge(daily_calories_intensity, daily_steps_cleaned,
                        by = c("Id", "ActivityDay"), all = TRUE)
sum(duplicated(daily_combined))
rm(daily_calories_cleaned)
rm(daily_intensities_cleaned)
rm(daily_calories_intensity)
rm(daily_steps_cleaned)
```
We removed the tables that we merged and checked the new table for duplicates
##### Add a day of week column for tables for analysis
```
daily_activity_cleaned$DayofWeek <- weekdays(daily_activity_cleaned$ActivityDate)
daily_combined$DayofWeek <- weekdays(daily_combined$ActivityDay)
daily_sleep_cleaned$DayofWeek <- weekdays(daily_sleep_cleaned$SleepDay)
daily_weightLog_cleaned$DayofWeek <- weekdays(daily_weightLog_cleaned$Date)
```
##### Check data for N/A values
```
sum(is.na(daily_activity_cleaned))
sum(is.na(daily_combined))
sum(is.na(daily_sleep))
sum(is.na(daily_weightLog_cleaned))
```
Weight log has 94 NA entries for "Fat" column because data was unrecorded, we will leave it in for now

**Now that the data is prepared, we can start to analyzing it and creating visuals**
Lets define each of our daily data tables first. 
##### Daily Combined Data
**Variables:** Id, ActivityDay, Calories, various activity minutes, distances, StepTotal, DayofWeek
**Description:** Records daily total steps, various activity levels, distances traveled, and calories burned
##### Daily Sleep Data
**Variables:** Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed, DayofWeek.
**Description:** Tracks sleep records, total minutes asleep, and total time in bed for each user.
##### Daily Weight Log Data
**Variables:** Id, Date, WeightKg, WeightPounds, Fat, BMI, IsManualReport, LogId, DayofWeek
**Description:** Contains user weight logs including body fat percentage and BMI
##### Daily Activity Data
**Variables:**  Id, ActivityDate, TotalSteps, TotalDistance, various distances, activity minutes, SedentaryMinutes, Calories, DayofWeek
**Description:** Details of daily activities including steps, distances, active minutes, and calories

### Data Integrity and Descriptive Statistics
##### Check for number of unique users in tables
```
n_unique(daily_activity_cleaned$Id) # 35 unique users
n_unique(daily_combined$Id) # 33 unique users
n_unique(daily_sleep_cleaned$Id) # 24 unique users
n_unique(daily_weightLog_cleaned$Id) # 13 unique users
```
Weight log has 13 unique users, so it will be hard to draw conclusions off that small of a sample size, the others are close enough or over 30 users, which is our threshold. 
##### Summary statistics
```
summary(daily_combined)
summary(daily_activity_cleaned)
summary(daily_sleep_cleaned)
summary(daily_weightLog_cleaned)
```

![DailySummary](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/c8d58e2e-b0e2-4f37-9a5f-cbf7de27f296)

#### 1) Daily Combined
**Calories** burned range from 0 to 4900 with an average of approximately 2304 per day
Average **Steps** per day are about 7638, with a significant range (0 to 36019)
#### 2) Daily Activity










library(tidyverse)
library(dplyr)
library(lubridate)
library(skimr)
library(ggplot2)
library(readr)
library(scales)


# Load, transform, and Merge daily activity from 4-11 and 5-12 folders
daily_activity_1 <- read.csv("~/fitness_data/dailyActivity_merged_1.csv")
daily_activity_1$ActivityDate <- as.Date(daily_activity_1$ActivityDate, format = "%m/%d/%Y")

daily_activity_2 <- read.csv("~/fitness_data/dailyActivity_merged_2.csv")
daily_activity_2$ActivityDate <- as.Date(daily_activity_2$ActivityDate, format = "%m/%d/%Y")

daily_activity_merged <- bind_rows(daily_activity_1, daily_activity_2)

# Load and transform daily sleep data
daily_sleep <- read.csv("~/fitness_data/sleepDay_merged.csv")
daily_sleep$SleepDay <- as.Date(daily_sleep$SleepDay, format = "%m/%d/%Y")

# Load and transform daily calorie data
daily_calories <- read.csv("~/fitness_data/dailyCalories_merged.csv")
daily_calories$ActivityDay <- as.Date(daily_calories$ActivityDay,
                                      format = "%m/%d/%Y")

# Load and transform daily intensity data
daily_intensities <- read.csv("~/fitness_data/dailyIntensities_merged.csv")
daily_intensities$ActivityDay <- as.Date(daily_intensities$ActivityDay,
                                         format = "%m/%d/%Y")

# Load and transform daily step data
daily_steps <- read.csv("~/fitness_data/dailySteps_merged.csv")
daily_steps$ActivityDay <- as.Date(daily_steps$ActivityDay, format = "%m/%d/%Y")

# Load, transform, and Merge heart rate data from 4-11 and 5-12 folders
heartRate_seconds_1 <- read.csv("~/fitness_data/heartrate_seconds_merged_1.csv")
heartRate_seconds_1$Time <- mdy_hms(heartRate_seconds_1$Time)

heartRate_seconds_2 <- read.csv("~/fitness_data/heartrate_seconds_merged_2.csv")
heartRate_seconds_2$Time <- mdy_hms(heartRate_seconds_2$Time)

heartRate_seconds_merged <- bind_rows(heartRate_seconds_1, heartRate_seconds_2)

# Load, transform, and Merge hourly calorie data from 4-11 and 5-12 folders
hourlyCalories_1 <- read.csv("~/fitness_data/hourlyCalories_merged_1.csv")
hourlyCalories_1$ActivityHour <- mdy_hms(hourlyCalories_1$ActivityHour)

hourlyCalories_2 <- read.csv("~/fitness_data/hourlyCalories_merged_2.csv")
hourlyCalories_2$ActivityHour <- mdy_hms(hourlyCalories_2$ActivityHour)

hourlyCalories_merged <- bind_rows(hourlyCalories_1, hourlyCalories_2)

# Load, transform, and Merge hourly intensity data from 4-11 and 5-12 folders
hourlyIntensities_1 <- read.csv("~/fitness_data/hourlyIntensities_merged_1.csv")
hourlyIntensities_1$ActivityHour <- mdy_hms(hourlyIntensities_1$ActivityHour)

hourlyIntensities_2 <- read.csv("~/fitness_data/hourlyIntensities_merged_2.csv")
hourlyIntensities_2$ActivityHour <- mdy_hms(hourlyIntensities_2$ActivityHour)

hourlyIntesities_merged <- bind_rows(hourlyIntensities_1, hourlyIntensities_2)

# Load, transform, and Merge hourly steps data from 4-11 and 5-12 folders
hourlySteps_1 <- read.csv("~/fitness_data/hourlySteps_merged_1.csv")
hourlySteps_1$ActivityHour <- mdy_hms(hourlySteps_1$ActivityHour)

hourlySteps_2 <- read.csv("~/fitness_data/hourlySteps_merged_2.csv")
hourlySteps_2$ActivityHour <- mdy_hms(hourlySteps_2$ActivityHour)

hourlySteps_merged <- bind_rows(hourlySteps_1, hourlySteps_2)

# Load, transform, and Merge minute calories data from 4-11 and 5-12 folders
minuteCalories_1 <- read.csv("~/fitness_data/minuteCaloriesNarrow_merged_1.csv")
minuteCalories_1$ActivityMinute <- mdy_hms(minuteCalories_1$ActivityMinute)

minuteCalories_2 <- read.csv("~/fitness_data/minuteCaloriesNarrow_merged_2.csv")
minuteCalories_2$ActivityMinute <- mdy_hms(minuteCalories_2$ActivityMinute)

minuteCalories_merged <- bind_rows(minuteCalories_1, minuteCalories_2)

# Load, transform, and Merge minute intensities data from 4-11 and 5-12 folders
minuteIntesities_1 <- read.csv("~/fitness_data/minuteIntensitiesNarrow_merged_1.csv")
minuteIntesities_1$ActivityMinute <- mdy_hms(minuteIntesities_1$ActivityMinute)

minuteIntesities_2 <- read.csv("~/fitness_data/minuteIntensitiesNarrow_merged_2.csv")
minuteIntesities_2$ActivityMinute <- mdy_hms(minuteIntesities_2$ActivityMinute)

minuteIntesities_merged <- bind_rows(minuteIntesities_1, minuteIntesities_2)

# Load, transform, and Merge minute METs data from 4-11 and 5-12 folders
minuteMETs_1 <- read.csv("~/fitness_data/minuteMETsNarrow_merged_1.csv")
minuteMETs_1$ActivityMinute <- mdy_hms(minuteMETs_1$ActivityMinute)

minuteMETs_2 <- read.csv("~/fitness_data/minuteMETsNarrow_merged_2.csv")
minuteMETs_2$ActivityMinute <- mdy_hms(minuteMETs_2$ActivityMinute)

minuteMets_merged <- bind_rows(minuteMETs_1, minuteMETs_2)

# Load, transform, and Merge minute sleep data from 4-11 and 5-12 folders
minuteSleep_1 <- read.csv("~/fitness_data/minuteSleep_merged_1.csv")
minuteSleep_1$date <- mdy_hms(minuteSleep_1$date)

minuteSleep_2 <- read.csv("~/fitness_data/minuteSleep_merged_2.csv")
minuteSleep_2$date <- mdy_hms(minuteSleep_2$date)

minuteSleep_merged <- bind_rows(minuteSleep_1, minuteSleep_2)

# Load, transform, and Merge minute step data from 4-11 and 5-12 folders
minuteSteps_1 <- read.csv("~/fitness_data/minuteStepsNarrow_merged_1.csv")
minuteSteps_1$ActivityMinute <- mdy_hms(minuteSteps_1$ActivityMinute)

minuteSteps_2 <- read.csv("~/fitness_data/minuteStepsNarrow_merged_2.csv")
minuteSteps_2$ActivityMinute <- mdy_hms(minuteSteps_2$ActivityMinute)

minuteSteps_merged <- bind_rows(minuteSteps_1, minuteSteps_2)

# Load, transform, and Merge weight log data from 4-11 and 5-12 folders
weightLog_1 <- read.csv("~/fitness_data/weightLogInfo_merged_1.csv")
weightLog_1$Date <- as.Date(weightLog_1$Date, format = "%m/%d/%Y")
weightLog_1$IsManualReport <- as.logical(weightLog_1$IsManualReport)

weightLog_2 <- read.csv("~/fitness_data/weightLogInfo_merged_2.csv")
weightLog_2$Date <- as.Date(weightLog_2$Date, format = "%m/%d/%Y")
weightLog_2$IsManualReport <- as.logical(weightLog_2$IsManualReport)

weightLog_merged <- bind_rows(weightLog_1, weightLog_2)

# Check for NA and Duplicates
sum(is.na(daily_activity_merged))
sum(is.na(daily_calories))
sum(is.na(daily_intensities))
sum(is.na(daily_sleep))
sum(is.na(daily_steps))
sum(is.na(heartRate_seconds_merged))
sum(is.na(hourlyCalories_merged))
sum(is.na(hourlyIntesities_merged))
sum(is.na(hourlySteps_merged))
sum(is.na(minuteCalories_merged))
sum(is.na(minuteIntesities_merged))
sum(is.na(minuteMets_merged))
sum(is.na(minuteSleep_merged))
sum(is.na(minuteSteps_merged))
sum(is.na(weightLog_merged))

sum(duplicated(daily_activity_merged))
sum(duplicated(daily_calories))
sum(duplicated(daily_intensities))
sum(duplicated(daily_sleep))
sum(duplicated(daily_steps))
sum(duplicated(heartRate_seconds_merged))
sum(duplicated(hourlyCalories_merged))
sum(duplicated(hourlyIntesities_merged))
sum(duplicated(hourlySteps_merged))
sum(duplicated(minuteCalories_merged))
sum(duplicated(minuteIntesities_merged))
sum(duplicated(minuteMets_merged))
sum(duplicated(minuteSleep_merged))
sum(duplicated(minuteSteps_merged))
sum(duplicated(weightLog_merged))

# Remove duplicates, NA's in weightlog is 
daily_activity_cleaned <- daily_activity_merged
daily_calories_cleaned <- daily_calories
daily_intensities_cleaned <- daily_intensities
daily_steps_cleaned <- daily_steps
daily_sleep_cleaned <- daily_sleep %>% 
  distinct()
heartRate_seconds_cleaned <- heartRate_seconds_merged %>% 
  distinct()
hourlyCalories_cleaned <- hourlyCalories_merged %>% 
  distinct()
hourlyIntesities_cleaned <- hourlyIntesities_merged %>% 
  distinct()
hourlySteps_cleaned <- hourlySteps_merged %>% 
  distinct()
minuteCalories_cleaned <- minuteCalories_merged %>% 
  distinct()
minuteIntesities_cleaned <- minuteIntesities_merged %>% 
  distinct()
minuteMets_cleaned <- minuteMets_merged %>% 
  distinct()
minuteSleep_cleaned <- minuteSleep_merged %>% 
  distinct()
minuteSteps_cleaned <- minuteSteps_merged %>% 
  distinct()
daily_weightLog_cleaned <- weightLog_merged %>% 
  distinct()

# Combine daily, hourly, and minute data tables with full joins
daily_calories_intensity <- merge(daily_calories_cleaned, 
                                  daily_intensities_cleaned,
                                  by = c("Id", "ActivityDay"), all = TRUE)
daily_combined <- merge(daily_calories_intensity, daily_steps_cleaned,
                        by = c("Id", "ActivityDay"), all = TRUE)
hourly_steps_calories <- merge(hourlySteps_cleaned, hourlyCalories_cleaned,
                               by = c("Id", "ActivityHour"), all = TRUE)
hourly_combined <- merge(hourly_steps_calories, hourlyIntesities_cleaned,
                         by = c("Id", "ActivityHour"), all = TRUE)
minute_cal_int <- merge(minuteCalories_cleaned, minuteIntesities_cleaned,
                        by = c("Id", "ActivityMinute"), all = TRUE)
minute_cal_int_met <- merge(minute_cal_int, minuteMets_cleaned,
                            by = c("Id", "ActivityMinute"), all = TRUE)
minute_combined <- merge(minute_cal_int_met, minuteSteps_cleaned,
                         by = c("Id", "ActivityMinute"), all = TRUE)

# Remove unneccesary data tables
rm(daily_activity_1)
rm(daily_activity_2)
rm(heartRate_seconds_1)
rm(heartRate_seconds_2)
rm(hourlyCalories_1)
rm(hourlyCalories_2)
rm(hourlyIntensities_1)
rm(hourlyIntensities_2)
rm(hourlySteps_1)
rm(hourlySteps_2)
rm(minuteCalories_1)
rm(minuteCalories_2)
rm(minuteIntesities_1)
rm(minuteIntesities_2)
rm(minuteMETs_1)
rm(minuteMETs_2)
rm(minuteSleep_1)
rm(minuteSleep_2)
rm(minuteSteps_1)
rm(minuteSteps_2)
rm(weightLog_1)
rm(weightLog_2)
rm(daily_activity_merged)
rm(heartRate_seconds_merged)
rm(hourlyCalories_merged)
rm(hourlyIntesities_merged)
rm(hourlySteps_merged)
rm(minuteCalories_merged)
rm(minuteIntesities_merged)
rm(minuteMets_merged)
rm(minuteSleep_merged)
rm(minuteSteps_merged)
rm(weightLog_merged)
rm(daily_calories)
rm(daily_intensities)
rm(daily_sleep)
rm(daily_steps)
rm(daily_calories_cleaned)
rm(daily_intensities_cleaned)
rm(daily_calories_intensity)
rm(daily_steps_cleaned)
rm(hourlySteps_cleaned)
rm(hourlyCalories_cleaned)
rm(hourly_steps_calories)
rm(hourlyIntesities_cleaned)
rm(minuteCalories_cleaned)
rm(minuteIntesities_cleaned)
rm(minute_cal_int)
rm(minuteMets_cleaned)
rm(minute_cal_int_met)
rm(minuteSteps_cleaned)

# Add day of week column for tables
daily_activity_cleaned$DayofWeek <- weekdays(daily_activity_cleaned$ActivityDate)
daily_combined$DayofWeek <- weekdays(daily_combined$ActivityDay)
daily_sleep_cleaned$DayofWeek <- weekdays(daily_sleep_cleaned$SleepDay)
daily_weightLog_cleaned$DayofWeek <- weekdays(daily_weightLog_cleaned$Date)
hourly_combined$DayofWeek <- weekdays(hourly_combined$ActivityHour)
minute_combined$DayofWeek <- weekdays(minute_combined$ActivityMinute)
minuteSleep_cleaned$DayofWeek <- weekdays(minuteSleep_cleaned$date)

# check tables of number of unique users
n_unique(daily_activity_cleaned$Id) # 35 unique users
n_unique(daily_combined$Id) # 33 unique users
n_unique(daily_sleep_cleaned$Id) # 24 unique users
n_unique(daily_weightLog_cleaned$Id) # 13 unique users
n_unique(heartRate_seconds_cleaned$Id) # 15 unique users
n_unique(hourly_combined$Id) # 35 unique users
n_unique(minute_combined$Id) # 35 unique users
n_unique(minuteSleep_cleaned$Id) # 25 unique users

View(daily_activity_cleaned)
View(daily_combined)
View(daily_sleep_cleaned)
View(daily_weightLog_cleaned)
View(heartRate_seconds_cleaned)
View(hourly_combined)
View(minute_combined)
View(minuteSleep_cleaned)


#Save table for tableau visualization
write_csv(daily_activity_cleaned, "~/OtherAnalysis/daily_activity_cleaned.csv")
write_csv(daily_combined, "~/OtherAnalysis/daily_combined.csv")
write_csv(daily_sleep_cleaned, "~/OtherAnalysis/daily_sleep_cleaned.csv")
write_csv(daily_weightLog_cleaned, "~/OtherAnalysis/daily_weightLog_cleaned.csv")
write_csv(heartRate_seconds_cleaned, "~/OtherAnalysis/heartRate_seconds_cleaned.csv")
write_csv(hourly_combined, "~/OtherAnalysis/hourly_combined.csv")
write_csv(minute_combined, "~/OtherAnalysis/minute_combined.csv")
write_csv(minuteSleep_cleaned, "~/OtherAnalysis/minuteSleep_cleaned.csv")

minuteCalories_1 <- read.csv("~/fitness_data/minuteCaloriesNarrow_merged_1.csv")

#Basic Summary Statistics
summary(daily_combined)
summary(daily_activity_cleaned)
summary(daily_sleep_cleaned)
summary(daily_weightLog_cleaned)

#Correlations
cor(daily_activity_cleaned$TotalSteps, daily_activity_cleaned$Calories)
cor(daily_activity_cleaned$SedentaryMinutes, daily_activity_cleaned$Calories)
cor(daily_activity_cleaned$VeryActiveMinutes, daily_activity_cleaned$Calories)
cor(daily_activity_cleaned$VeryActiveMinutes, daily_activity_cleaned$TotalSteps)

# Summary Statistics by Day of the Week
WeekOrder <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
               "Friday", "Saturday")

dow_AverageSteps <- daily_combined %>% 
  group_by(DayofWeek) %>% 
  summarise(AverageSteps = mean(StepTotal))

dow_AverageSleep <- daily_sleep_cleaned %>% 
  group_by(DayofWeek) %>% 
  summarise(AverageSleep = mean(TotalMinutesAsleep))


# Other Summary statistics

# What percent of time did users sleep while in bed
user_sleepPortion <- daily_sleep_cleaned %>% 
  group_by(Id) %>% 
  mutate(sleepPercentage = mean(TotalMinutesAsleep/TotalTimeInBed)*100) %>% 
  select(Id, sleepPercentage) %>% 
  summarise(avg_sleepPerc = mean(sleepPercentage)) %>% 
  arrange(avg_sleepPerc)

# Is there a correlation between average calories burned and percentage you sleep
user_averageSleepTime <- daily_sleep_cleaned %>% 
  group_by(Id) %>% 
  summarise(avg_sleepTime = mean(TotalMinutesAsleep)) %>% 
  arrange(avg_sleepTime)

user_averageCalBurn <- daily_activity_cleaned %>% 
  group_by(Id) %>% 
  summarise(avg_calBurn = mean(Calories))


sleepTime_vs_calBurn <- merge(user_averageSleepTime, user_averageCalBurn,
                              by = "Id", all.x = TRUE)
sleepPortion_vs_calBurn <- merge(user_sleepPortion, user_averageCalBurn,
                                 by = "Id", all.x = TRUE)

View(sleepTime_vs_calBurn)
cor(sleepTime_vs_calBurn$avg_sleepTime, sleepTime_vs_calBurn$avg_calBurn)

# Data Visualizations

ggplot(sleepPortion_vs_calBurn, aes(x = avg_calBurn, y = avg_sleepPerc)) +
  geom_point() + geom_smooth(method = "lm")


  
ggplot(dow_AverageSleep, aes(
  x = factor(DayofWeek, levels = WeekOrder), y = AverageSleep)) + 
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Day of the Week", y = "Average Minutes Asleep", 
       title = "Average Sleep Time by Day of the Week") +
  theme_minimal()

ggplot(dow_AverageSteps, aes(
  x = factor(DayofWeek, levels = WeekOrder), y = AverageSteps)) + 
  geom_bar(stat = "identity", fill = "salmon") +
  labs(x = "Day of the Week", y = "Average Steps", 
       title = "Average Steps by Day of the Week") +
  theme_minimal()

ggplot(daily_sleep_cleaned, aes(x = TotalMinutesAsleep)) + 
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  ggtitle("Distribution of Total Minutes Asleep") +
  xlab("Total Minutes Asleep") +
  ylab("Frequency") +
  theme_minimal()

# Reshape the data from wide to long format
activity_long <- pivot_longer(daily_activity_cleaned, cols = c(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes),
                              names_to = "ActivityType", values_to = "Minutes")

# Calculate the total minutes for each activity type to get proportions
activity_summary <- activity_long %>%
  group_by(ActivityType) %>%
  summarize(TotalMinutes = sum(Minutes)) %>%
  mutate(Proportion = TotalMinutes / sum(TotalMinutes),
         Label = percent(Proportion))

# Create the pie chart
ggplot(activity_summary, aes(x = "", y = Proportion, fill = ActivityType)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +  # This transforms the bar chart into a pie chart
  scale_fill_brewer(palette = "Pastel1") + # Apply a color palette and add labels to legend
  labs(fill = "Activity Type", title = "Proportion of Activity Minutes") +
  theme_void()  # This removes the background grid and labels

# Print the activity type and the corresponding percentage
activity_summary %>% select(ActivityType, Label)

ggplot(daily_activity_cleaned, aes(x=factor(DayofWeek, levels=WeekOrder), y=VeryActiveMinutes)) +
  geom_boxplot(aes(fill=DayofWeek)) +
  labs(title='Very Active Minutes by Day of the Week', x='Day of the Week', y='Very Active Minutes') +
  theme_minimal()

ggplot(daily_activity_cleaned, aes(x = VeryActiveMinutes, y = Calories)) +
  geom_point(aes(color = VeryActiveMinutes), alpha = 0.6) +  
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  
  labs(title = "Correlation between Very Active Minutes and Calories Burned",
       x = "Very Active Minutes",
       y = "Calories Burned") +
  theme_minimal() +
  scale_color_gradient(low = "yellow", high = "red")  

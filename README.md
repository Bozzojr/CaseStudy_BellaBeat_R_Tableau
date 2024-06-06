# CaseStudy_BellaBeat_R_Tableau
##### Author: Mark Bozzo
Final project for the Google Data Analytics Professional Certificate. Case study for BellaBeat fitness company
##### Date: April 9th, 2024

##### [Tableau Dashboard](https://public.tableau.com/views/BellaBeatFitnessDashboard/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)
#
### ℹ️ Intro(#introduction)
### 📁 Data Prep(#data-preparation)
### 📈 Statistical Analysis(#data-integrity-and-descriptive-statistics)
### 📊 Data Viz(#data-viz)
### 🔎 Key Findings(#key-findings-and-recommendations)

## Introduction
As a thriving small company, Bellabeat is poised to expand its footprint in the global smart device market. Under the guidance of Chief Creative Officer, Urska Srsen, this analysis will leverage publicly available smart device data to uncover insights that will inform strategic marketing decisions for one of Bellabeat’s products.

## Business Task
### Background
Bellabeat manufactures health-focused smart products for women, aimed at helping them track various wellness metrics such as activity, sleep, stress, and hydration.

### Objective
The goal is to utilize smart device usage data to identify consumer behavior and preferences, providing insights into how users interact with their devices in relation to their health and wellness.

### Task
Analyze smart device usage data, focusing particularly on one of Bellabeat’s products. The analysis should uncover how consumers use their smart devices in their daily lives and how these usage patterns might influence Bellabeat’s marketing strategies. Key aspects to focus on include:
  1) Trends in smart device usage.
  2) Relationships between smart device data and personal wellness.
  3) Insights to tailor Bellabeat’s marketing strategies and product offerings.

### Company Products
  1) **Bellabeat App:** Provides users with health-related data that includes infromation about their activity levels, sleep, stress, menstrual cycle, and mindfulness habits. Connects to Bellabeat's line of smart wellness products
  2) **Leaf:** Wellness tracker that can be work as a bracelet, necklace, or clip
  3) **Time:** Wellness watch that tracks activity, sleep, and stress
  4) **Spring:** Water bottle that tracks daily water intakeand provides info on hydration levels


## Key Questions
### Here are the key questions we will be considering
  1) What are the prevalent trends in smart device usage?
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
  4) Supporting Visualizations and key findings
  5) Recommendations for Bellabeat Marketing Team

## Data Preparation
### Daily Data
#### First, load the data, transform, and combine where necessary. 
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
#### Check for duplicates in data
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
#### Combine tables where possible with full joins
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
#### Add a day of week column for tables for analysis
```
daily_activity_cleaned$DayofWeek <- weekdays(daily_activity_cleaned$ActivityDate)
daily_combined$DayofWeek <- weekdays(daily_combined$ActivityDay)
daily_sleep_cleaned$DayofWeek <- weekdays(daily_sleep_cleaned$SleepDay)
daily_weightLog_cleaned$DayofWeek <- weekdays(daily_weightLog_cleaned$Date)
```
#### Check data for N/A values
```
sum(is.na(daily_activity_cleaned))
sum(is.na(daily_combined))
sum(is.na(daily_sleep))
sum(is.na(daily_weightLog_cleaned))
```
Weight log has 94 NA entries for "Fat" column because data was unrecorded, we will leave it in for now

**Now that the data is prepared, we can start to analyzing it and creating visuals**

Lets define each of our daily data tables first. 
## Data Definition
### Daily Combined Data
**Variables:** Id, ActivityDay, Calories, various activity minutes, distances, StepTotal, DayofWeek

**Description:** Records daily total steps, various activity levels, distances traveled, and calories burned
### Daily Sleep Data
**Variables:** Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed, DayofWeek.

**Description:** Tracks sleep records, total minutes asleep, and total time in bed for each user.
### Daily Weight Log Data
**Variables:** Id, Date, WeightKg, WeightPounds, Fat, BMI, IsManualReport, LogId, DayofWeek

**Description:** Contains user weight logs including body fat percentage and BMI
### Daily Activity Data
**Variables:**  Id, ActivityDate, TotalSteps, TotalDistance, various distances, activity minutes, SedentaryMinutes, Calories, DayofWeek

**Description:** Details of daily activities including steps, distances, active minutes, and calories

## Data Integrity and Descriptive Statistics
#### Check for number of unique users in tables
```
n_unique(daily_activity_cleaned$Id) # 35 unique users
n_unique(daily_combined$Id) # 33 unique users
n_unique(daily_sleep_cleaned$Id) # 24 unique users
n_unique(daily_weightLog_cleaned$Id) # 13 unique users
```
Weight log has 13 unique users, so it will be hard to draw conclusions off that small of a sample size, the others are close enough or over 30 users, which is our threshold. 
### Summary statistics
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
Average **Steps** per day are about 7281, similar to daily combined with matching range

**Very Active Minutes** average about 20 minutes per day
#### 3) Daily Sleep
Users **sleep on average** 419 minutes per night (about 7 hours), with a range of 58 to 796  

**Total Time in Bed** is at 548 minutes typically, suggesting users spend on average 39 minutes in bed awake
#### 4) Daily Weight
**Weight Lb:** Average weight is about 138 lb , ranging from 116 to 294. 

**BMI** average is around 25, indicating a mix of healthy and overweight indiviudals

#### Correlations
```
cor(daily_activity_cleaned$TotalSteps, daily_activity_cleaned$Calories) # = 0.5901599
cor(daily_activity_cleaned$SedentaryMinutes, daily_activity_cleaned$Calories) # = -0.06192441
cor(daily_activity_cleaned$VeryActiveMinutes, daily_activity_cleaned$Calories) # = 0.5820275
cor(daily_activity_cleaned$VeryActiveMinutes, daily_activity_cleaned$TotalSteps) # = 0.6765583
```
**Activity Correlations:** 
There is a strong positive correlation between total steps and calories burned (r = 0.59), which is expected as more activity should lead to higher energy expenditure. Also, very active minutes correlate strongly with both total steps (r = 0.68) and calories burned (r = 0.58).

**Sleep vs Calories Burned:** 
If users burn more calories in a day, will they get better sleep at night? Intuition would assume yes, because we are expending more energy, we would think that we would be more tired and, as a result, sleep more. Lets see if the numbers back this theory.
```
user_averageSleepTime <- daily_sleep_cleaned %>% 
  group_by(Id) %>% 
  summarise(avg_sleepTime = mean(TotalMinutesAsleep)) %>% 
  arrange(avg_sleepTime)

user_averageCalBurn <- daily_activity_cleaned %>% 
  group_by(Id) %>% 
  summarise(avg_calBurn = mean(Calories))


sleepTime_vs_calBurn <- merge(user_averageSleepTime, user_averageCalBurn,
                              by = "Id", all.x = TRUE)
cor(sleepTime_vs_calBurn$avg_sleepTime, sleepTime_vs_calBurn$avg_calBurn) # = -0.05078034
```
Contrary to our hypothesis, there is almost no correlation between the amount of calories and user burns during the day vs the amount of sleep they get at night!

## Data Viz
### Distribution of Sleep Time
```
ggplot(daily_sleep_cleaned, aes(x = TotalMinutesAsleep)) + 
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  ggtitle("Distribution of Total Minutes Asleep") +
  xlab("Total Minutes Asleep") +
  ylab("Frequency") +
  theme_minimal()
```

![DistributionOfSleep](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/51938a7d-f04d-45c8-864e-3d333247b7bb)

Our distribution shows a normal bell curve, increasing our confidence in the validity of the sample data taken for sleep. The peak of the curve sits right below 450 minutes of sleep per night..

### Proportion of Activity Levels
```
# Reshape the data from wide to long format
activity_long <- pivot_longer(daily_activity_cleaned, cols = c(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes),
                              names_to = "ActivityType", values_to = "Minutes")

# Calculate the total minutes for each activity type to get proportions
activity_summary <- activity_long %>%
  group_by(ActivityType) %>%
  summarize(TotalMinutes = sum(Minutes)) %>%
  ungroup() %>%
  mutate(Proportion = TotalMinutes / sum(TotalMinutes),
         Label = percent(Proportion))

# Create the pie chart
ggplot(activity_summary, aes(x = "", y = Proportion, fill = ActivityType)) +
  geom_bar(width = 1, stat = "identity", show.legend = FALSE) +
  coord_polar("y", start = 0) +  # Transform the bar chart into a pie chart
  scale_fill_brewer(palette = "Pastel1") + # Apply a color palette and add labels to legend
  labs(title = "Proportion of Activity Minutes", fill = "Activity Type") +
  theme_void()  

# Print the activity type and the corresponding percentage
activity_summary %>% select(ActivityType, Label)
```
![ActivityLevelGraph](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/31fd680a-06e6-4111-b468-6015094009c5)
![ActivityLevelPrint](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/36a7b8dc-d7bb-4900-a8f9-246df7df4c3a)

Over 80% of our time is spent Sedentary! Identifying the days where we are least active could help us choose when to engage with our customers to promote a healthy lifestyle.

## Sleep and Steps by Day of Week
```
# Set week order as variable to Order Graphs
WeekOrder <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
               "Friday", "Saturday")

# Create Tables for Average Sleep and Steps by Day of Week
dow_AverageSteps <- daily_combined %>% 
  group_by(DayofWeek) %>% 
  summarise(AverageSteps = mean(StepTotal))

dow_AverageSleep <- daily_sleep_cleaned %>% 
  group_by(DayofWeek) %>% 
  summarise(AverageSleep = mean(TotalMinutesAsleep))

# Make Bar graph
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
```
![dow_AverageSleepGraphic](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/549eec05-c2ab-4adf-9a4b-dbc409ae9109)
![dow_AverageStepsGraphic](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/bf270b25-ed44-4fe1-833a-e1c90acf32f5)

Users tend to be most active on Tuesdays and Saturday. Indicating higher app engagement on these days. Sunday is the day where users sleep the most, and take the least steps. 

## Correlation Between Activity Level and Calories Burned
Earlier we calculated a 0.58 correlation between our time spent being Very Active, and the amount of calories we burned. Lets visualize this: 
```
ggplot(daily_activity_cleaned, aes(x = VeryActiveMinutes, y = Calories)) +
  geom_point(aes(color = VeryActiveMinutes), alpha = 0.6) +  
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  
  labs(title = "Correlation between Very Active Minutes and Calories Burned",
       x = "Very Active Minutes",
       y = "Calories Burned") +
  theme_minimal() +
  scale_color_gradient(low = "yellow", high = "red")  
```
![VeryActivevsCalories](https://github.com/Bozzojr/Google_Analytics_Capstone_BellaBeat/assets/123130175/6cf4ac81-a1f3-494e-83f3-95732a2532c3)

Encouraging our users to spend just a small part of their day being very active, could result in huge benefits for their health and weight loss goals!

## Key Findings and Recommendations
  1) **Focus on Activity Encouragement**
      - Highlight Benefits of Increased Activity: The data shows a strong positive correlation between activity levels (specifically Very Active Minutes) and calories burned. Marketing should focus on campaigns that highlight the benefits of increased activity, such as improved fitness and weight management, using real user data as evidence.
      - Promote Active Wearables: Given the significant correlation between very active minutes and calorie expenditure, Bellabeat can promote products like the Leaf and Time that encourage more active lifestyles. Campaigns could showcase how easily these devices integrate into various types of activities (e.g., yoga, running, cycling)
  2) **Tailored Daily Goals**
      - Personalized Notifications: Use data insights to push personalized notifications to users encouraging them to move or complete their daily activity goals, especially during their least active periods, which we identified on average to be Sunday.
      - Activity Challenges: Develop weekly challenges or competitions among users to encourage more consistent activity levels throughout the week, addressing the observed variability in daily step counts.
  3) **Weekday and Weekend Targeting**
      - Optimize Engagement Strategies: Utilize the data showing different activity levels and sleep patterns across the week. For example, encourage activity on Sundays when step counts are lowest and promote relaxation and wellness activities on Saturdays when users are more active.
      - Special Promotions: Offer weekend promotions or special features accessible through the app to encourage higher engagement when users are most active (Tuesdays and Saturdays).
  4) **Wellness Tracking and Data Driven Personalization**
      - Integrate Wellness Tips: Offer integrated wellness tips within the app based on user activity levels, sleep patterns, and movement data, helping users to see Bellabeat as a holistic health partner
      - Enhanced User Profiles: Use the extensive data to create more detailed user profiles that can be used to tailor suggestions and notifications. For example, if a user tends to be sedentary, provide prompts and encouragement specific to their patterns.

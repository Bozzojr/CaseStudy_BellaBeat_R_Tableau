# Google_Analytics_Capstone_BellaBeat
##### Author: Mark Bozzo
Final project for the Google Data Analytics Professional Certificate. Case study for BellaBeat fitness company
##### Date: April 9th, 2024

## Company Info
Bellabeat is a high-tech manufacturer of health products for women. Founded in 2013, Bellabeat has experienced significant growth. In just 3 years, the company has opened offices around the world and launched multiple products. Bellabeat products became available through a growing number of online retailers in addition to their own e-commerce channel on their website. The company has invested in traditional advertising media, such as radio, out-of-home billboards, print, and television, but focuses on digital marketing extensively. Bellabeat invests year-round in Google Search, maintaining active Facebook and Instagram pages, and consistently engages consumers on Twitter. Additionally, Bellabeat runs video ads on Youtube and display ads on the Google Display Network to support campaigns around key marketing dates.


## Scenario
Bellabeat has experienced success as a small company, and is looking to grow and hold a significan piece of the pie in the global smart device market. Creative Chief Officer, Urska Srsen, is looking to unlock new growth opportunities in this market by analyzing fitness data from smart devices. This analysis will focus on one of Bellabeat's products of our choosing. We will use publicly available data to gain insights on how customers use their smart devices in areas related to health. Using these insights, we will help develop high level recommendations for our marketing team 

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

## Business Task
### Background
Bellabeat, a high-tech company that manufactures health-focused smart products for women, is looking to expand its market presence and enhance its marketing strategies. The company offers a range of products designed to help women track their health and wellness data, including activity, sleep, stress, and hydration.

### Objective
The primary objective of this analysis is to leverage smart device usage data to gain insights into consumer behavior and preferences. By understanding how users interact with their smart devices, particularly those related to health and wellness tracking, Bellabeat aims to uncover patterns and trends that can inform strategic marketing decisions.

## Task
Analyze smart device usage data, focusing particularly on one of Bellabeat’s products. The analysis should uncover how consumers use their smart devices in their daily lives and how these usage patterns might influence Bellabeat’s marketing strategies. Key aspects to focus on include:
  1) Trends in smart device usage.
  2) Relationships between smart device data (like steps, sleep quality, and activity levels) and personal wellness.
  3) Insights that could potentially help tailor Bellabeat’s product offerings or marketing messages to better meet consumer needs.

## Data
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

```







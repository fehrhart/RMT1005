#Step 0: Preparation
#clean work space
rm(list=ls())

#set working directory (if wanted)
setwd("C:/Users/friederike.ehrhart/Documents/Teaching/RMT1005/RMT1005 2024")

# Load required libraries
library(ggplot2)

# Step 1: Data Import
data <- read.csv("PBC_Patients.csv")
colnames(data) <- c('PatientID','Age','Sex','Weight','BPDia','BPSys','Glucose','HighGlucose')

#Inspect the data
head(data)
str(data)

# Step 2: Data Cleaning (Example: Removing Missing Values)
data <- na.omit(data)  

# Step 3: How many male and female participants and %
print(sum(data$Sex == 'M'))
print(sum(data$Sex == 'F'))
(NumberM/(NumberM + NumberF))*100

# Step 4: Subsetting normal and high glucose levels
dataNormal <- subset(data, Glucose <= 100)
dataHigh <- subset(data, Glucose > 100)

# Step 5: Data Export
write.csv(dataNormal, "GlucoseNormal.csv", row.names = FALSE)
write.csv(dataHigh, "GlucoseHigh.csv", row.names = FALSE)

#Step 0: Preparation
#clean work space
rm(list=ls())

#set working directory (if wanted)
setwd("C:/Users...")

# Load required libraries
library(ggplot2)

# Step 1: Data Import
data <- read.csv("PBC_Patients.csv")
colnames(data) <- c('PatientID','Age','Sex','Weight','BPDia','BPSys','Glucose','HighGlucose','Group')

#Inspect the data
head(data)
str(data)

# Step 2: Data Cleaning (Example: Removing Missing Values)
data <- na.omit(data)  

# Step 3: How many male and female participants and %
print(sum(data$Sex == 'M'))
print(sum(data$Sex == 'F'))
(NumberM/(NumberM + NumberF))*100

# Step 4: Subsetting control and experimental groups
dataControl <- subset(data, Group == 'C')
dataExp <- subset(data, Group == 'E')

# Step 5: Data Export
write.csv(dataControl, "Control.csv", row.names = FALSE)
write.csv(dataExp, "Exp.csv", row.names = FALSE)

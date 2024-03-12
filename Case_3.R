#Step 0: Preparation
#clean work space
rm(list=ls())

#set working directory (if wanted)
setwd("C:/...")

# Load required libraries
library(ggplot2)

# Step 1: Data Import, cleaning and applying headers
Patient_data <- read.csv("PBC_Patients.csv")
Patient_data <- na.omit(Patient_data)  
colnames(Patient_data) <- c('PatientID','Age','Sex','Weight','BPDia','BPSys','Glucose','HighGlucose','Group')
Study_data <- read.table("PBC_Study.txt", header = TRUE)

# Step 2: The plots

# Scatter plot age vs. weight for the entire participant population
ggplot(Patient_data, aes(x=Age, y=Weight)) + 
  geom_point()

# Scatter plot weight vs. glucose for the entire participant population before treatment
ggplot(Patient_data, aes(x=Weight, y=Glucose)) + 
  geom_point()

# Box plot showing the mean age with standard deviation for both the control and patient groups
ggplot(Patient_data, aes(x=as.factor(Group), y=Age)) + 
  geom_boxplot(fill="slateblue", alpha=0.5) + 
  xlab("Group")

# Pie chart of sex distribution
Pdata <- data.frame(
  group=c("M","F"),
  value=c(sum(Patient_data$Sex == 'M'),sum(Patient_data$Sex == 'F'))
)
#Basic plot
ggplot(Pdata, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)

#Better - remove numbers, white background
ggplot(Pdata, aes(x="", y=value, fill=group)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +  theme_void()

#Bar plot (including standard deviation) comparing glucose levels before and after the treatment between the groups.
#First, merge dataset again if not done yet and create subgroups
data <- merge(Patient_data, Study_data, by = 'PatientID')
head(data)
#Create subgroups
p_group <- subset(data, Group == 'P')
h_group <- subset(data, Group == 'H')

#Calculate mean and sd - same as before
#glucose levels before
pmeanG1 <- mean(p_group$Glucose.x)
psdG1 <- sd(p_group$Glucose.x)
hmeanG1 <- mean(h_group$Glucose.x)
hsdG1 <- sd(h_group$Glucose.x)
#glucose levels after
pmeanG2 <- mean(p_group$Glucose.y)
psdG2 <- sd(p_group$Glucose.y)
hmeanG2 <- mean(h_group$Glucose.y)
hsdG2 <- sd(h_group$Glucose.y)

Bdata <- data.frame(
 Name = c('P before','P after','H before','H after'),
 Mean = c(pmeanG1,pmeanG2,hmeanG1,hmeanG2),
 Std = c(psdG1,psdG2,hsdG1,hsdG2)
)

ggplot(Bdata) +
  geom_bar( aes(x=Name, y=Mean), stat="identity", fill="skyblue", alpha=0.7) +
  geom_errorbar( aes(x=Name, ymin=Mean-Std, ymax=Mean+Std), width=0.4, colour="black", alpha=0.9, size=0.5)


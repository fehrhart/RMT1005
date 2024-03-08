#Step 0: Preparation
#clean work space
rm(list=ls())

#set working directory (if wanted)
setwd("C:/Users/friederike.ehrhart/Documents/Teaching/RMT1005/RMT1005 2024/PBC")

# Step 1: Data Import, cleaning and applying headers
Patient_data <- read.csv("PBC_Patients.csv")
Patient_data <- na.omit(Patient_data)  
colnames(Patient_data) <- c('PatientID','Age','Sex','Weight','BPDia','BPSys','Glucose','HighGlucose','Group')
Study_data <- read.table("PBC_Study.txt", header = TRUE)

#Inspect the data
head(Study_data)

# Step 2: Merge the datasets based on Patient ID
data <- merge(Patient_data, Study_data, by = 'PatientID')
head(data)

# Step 3: Descriptive Statistics by parameter and group

#Create subgroups
p_group <- subset(data, Group == 'P')
h_group <- subset(data, Group == 'H')

# Calculate descriptive statistics values for the two groups

#Example for the whole population
meanAge <- mean(data$Age)
medianAge <- median(data$Age)
sdAge <- sd(data$Age)

#For the groups - add rounding function (optional - can also be at the end)
# Age
pmeanAge <- round(mean(p_group$Age),1)
psdAge <- round(sd(p_group$Age),1)

hmeanAge <- round(mean(h_group$Age),1)
hsdAge <- round(sd(h_group$Age),1)

#weight
pmeanWeight <- round(mean(p_group$Weight),1)
psdWeight <- round(sd(p_group$Weight),1)

hmeanWeight <- round(mean(h_group$Weight),1)
hsdWeight <- round(sd(h_group$Weight),1)

#blood pressure disastolic
pmeanBPDia <- round(mean(p_group$BPDia),1)
psdBPDia <- round(sd(p_group$BPDia),1)

hmeanBPDia <- round(mean(h_group$BPDia),1)
hsdBPDia <- round(sd(h_group$BPDia),1)

#blood pressure systolic
pmeanBPSys <- round(mean(p_group$BPSys),1)
psdBPSys <- round(sd(p_group$BPSys),1)

hmeanBPSys <- round(mean(h_group$BPSys),1)
hsdBPSys <- round(sd(h_group$BPSys),1)

#glucose levels before
pmeanG1 <- round(mean(p_group$Glucose.x),1)
psdG1 <- round(sd(p_group$Glucose.x),1)

hmeanG1 <- round(mean(h_group$Glucose.x),1)
hsdG1 <- round(sd(h_group$Glucose.x),1)

#glucose levels after
pmeanG2 <- round(mean(p_group$Glucose.y),1)
psdG2 <- round(sd(p_group$Glucose.y),1)

hmeanG2 <- round(mean(h_group$Glucose.y),1)
hsdG2 <- round(sd(h_group$Glucose.y),1)

#Create a table with the population description values
table <- matrix(c(pmeanAge, psdAge, hmeanAge, hsdAge, pmeanWeight, psdWeight, hmeanWeight, hsdWeight, pmeanBPDia, psdBPDia, hmeanBPDia, hsdBPDia,pmeanBPSys, psdBPSys, hmeanBPSys, hsdBPSys,pmeanG1,psdG1,hmeanG1,hsdG1,pmeanG2, psdG2,hmeanG2, hsdG2), ncol=4, byrow = TRUE)
colnames(table) = c('P mean', 'P sd', 'H mean', 'H sd')
rownames(table) = c('Age', 'Weight', 'Blood pressure dia', 'Blood pressure sys', 'Glucose before', 'Glucose after')
tableAge = as.table(table)

table

#Question: What subset of students do I have from a pre-requisite course based on performance? 
#Exploration of Distribution Comparisons

#Get Data
PlotData <- readRDS(file.path("data", "V11A.rds"))

#Transofrm and Derive
PlotData <- PlotData %>%
            mutate(Previous_Course_Subset = ifelse(In_current_course,Previous_Course,NA)) # Taking advantage of na.rm

EntireMean <- mean(PlotData$Previous_Course)
SubsetMean <- mean(PlotData$Previous_Course_Subset, na.rm = TRUE)

#Plot Data
binCount = 20
g <- ggplot(PlotData) +
  geom_histogram(mapping = aes(x = Previous_Course, fill = "b"), bins = binCount) +
  geom_histogram(mapping = aes(x = Previous_Course_Subset, fill = "g"), bins = binCount, alpha=0.7, position = position_dodge(width=0.5), na.rm=TRUE) + 
  geom_vline(xintercept = EntireMean, color = "blue") + 
  geom_vline(xintercept = SubsetMean, color = "grey") + 
  scale_fill_manual(name=NULL, values=c("b"="blue", "g"="grey"), labels=c("b"="Entire Prior Course", "g"="Students in Current Course")) + 
  labs(x = "Grade", y = "Student Count") + 
  theme(legend.position = "bottom")

plot(g)
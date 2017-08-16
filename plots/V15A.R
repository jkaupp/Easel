#Question: How does attendance to a specific class affect performance on an assessment? 
#Exploration of Class Identification

#Get Data
PlotData <- readRDS(file.path("data", "V15A.rds"))

#Summarize Data for each class
Summary <- PlotData %>%
           melt(id.vars = c("Student_ID","Assessment_Grade"), value.name="Attended") %>%
           mutate(meanAttended = ifelse(Attended==1,Assessment_Grade,NaN),
                 meanMissed = ifelse(Attended!=1,Assessment_Grade,NaN)) %>%
           group_by(variable) %>%
           summarize(Mean_Attended=mean(meanAttended, na.rm = TRUE), 
                     Mean_Missed=mean(meanMissed, na.rm = TRUE),
                     Num_Attended=sum(Attended)) %>%
           setNames(., c("Class", "Mean_Attended", "Mean_Missed", "Num_Attended")) 

Summary_L <- Summary %>%
             melt(id.vars = c("Class", "Num_Attended"), value.name="Mean")

#Plot Data
g<-ggplot(Summary_L) +
  geom_bar(mapping = aes(x = Class, y = Mean, fill=Num_Attended), stat='identity') + 
  facet_wrap(~variable, ncol=1) +
  scale_x_discrete(labels=c(1:12)) + 
  scale_fill_continuous(name="Students\nattended") +
  labs(x="Class #", y="Mean of Students who\nAttended/Aissed that Class")

plot(g)
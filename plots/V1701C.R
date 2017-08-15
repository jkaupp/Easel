#Question: What is the relationship between being in a mutually exclusive group X and a student’s assessment result? 
#Communication/Exploration of groups withour order

#Get Data
PlotData <- readRDS(file.path("data", "V1701A.rds"))

#Create 'Other' group for categories whose counts are under a certain threshold
Threshold = 20 #Threshold for smaller categories
PlotData <- PlotData %>% group_by(Academic_Program) %>% mutate(Academic_Program_T = ifelse(n()<Threshold,as.character("OTHER"),Academic_Program))

#Summarize Results
SummaryData <- PlotData %>% group_by(Academic_Program_T) %>% 
  summarize(GradeMean = mean(Assessment_Result), 
            GradeSD = sd(Assessment_Result), 
            StudentCount = n())

#Arrange Data by Student Count for visualization
SummaryData <- arrange(SummaryData,desc(StudentCount))
SummaryData$Academic_Program_T <- factor(SummaryData$Academic_Program_T, 
                                         levels=(SummaryData$Academic_Program_T)[order(SummaryData$StudentCount, decreasing = TRUE)])
PlotData$Academic_Program_F <- factor(PlotData$Academic_Program_T, 
                                      levels=(SummaryData$Academic_Program_T)[order(SummaryData$StudentCount, decreasing = TRUE)])

#Create Width and Mid-Point Data for Plots
SummaryData <- SummaryData %>%
  mutate(ColWidth = StudentCount/sum(StudentCount)/2, 
         d2 = lag(ColWidth, default=0)+ColWidth, 
         Midpoint = cumsum(d2))

#Plot Data
g1 <- ggplot(SummaryData, mapping = aes(width=ColWidth*2)) + 
  geom_bar(mapping = aes(x = Midpoint, y = GradeMean, fill = Academic_Program_T), stat="identity") + 
  geom_errorbar(mapping = aes(x = Midpoint, ymin=GradeMean-GradeSD, ymax=GradeMean+GradeSD), alpha=0.25) +
  coord_polar(theta = "x") + # Remove if rectangular coordinates is prefered
  labs(x = "Percentage of Class", y = "Assessment Mean\n(and Standard Deviation)", fill = "Academic Program") +
  theme(legend.position = "none")
  
g2 <- ggplot(PlotData, mapping=aes(fill=Academic_Program_F)) + 
  geom_histogram(mapping = aes(x=Assessment_Result), bins=15) + 
  facet_wrap(~Academic_Program_F, ncol=1) + 
  labs(x = "Assessment Result", y = "Student Count", fill = "Academic Program")

require(grid)
require(gridExtra)
grid.arrange(g1, g2, nrow=1)
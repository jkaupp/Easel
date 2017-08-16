#Question: What is the relationship between being in a mutually exclusive group X and a student’s assessment result? 
#Communication/Exploration of groups withour order

#Get Data
PlotData <- readRDS(file.path("data", "V1701B.rds"))

#Summarize Results
SummaryData <- PlotData %>% 
               group_by(Birth_Year) %>% 
               summarize(GradeMean = mean(Assessment_Result), 
                         GradeSD = sd(Assessment_Result),
                         StudentCount = n())

#Data is usually arranged by the factored variable by default

#Create Width and Mid-Point Data for Plots
SummaryData <- SummaryData %>%
  mutate(ColWidth = StudentCount/sum(StudentCount)/2, d2 = lag(ColWidth, default=0)+ColWidth, Midpoint = cumsum(d2))

#Plot Data
g <- ggplot(SummaryData, mapping = aes(width=ColWidth*2)) + 
  geom_bar(mapping = aes(x = Midpoint, y = GradeMean, fill = Birth_Year), stat="identity") + 
  geom_text(aes(x = Midpoint, y = GradeMean, label = Birth_Year)) + 
  geom_errorbar(mapping = aes(x = Midpoint, ymin=GradeMean-GradeSD, ymax=GradeMean+GradeSD), alpha=0.25) +
  scale_fill_brewer(palette = "Purples") + 
  coord_polar(theta = "x") + # Remove if rectangular coordinates is prefered
  labs(x = "Percentage of Class", y = "Mean for Group", fill = "Birth Year")

plot(g)
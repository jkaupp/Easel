library(reshape2)
#Question: Identifying special students from prior course. 
#Exploration of Extremes

#Get Data
PlotData <- readRDS(file.path("data", "V06A.rds"))
PlotData <- PlotData[1:100,] # Pick a section of students to look at

#Transofrm and Derive
PlotData$Difference <- (PlotData$Current_Course - PlotData$Prior_Course)
PlotData$Student_ID <- factor(PlotData$Student_ID, levels=(PlotData$Student_ID)[order(PlotData$Difference)])
PlotData <- arrange(PlotData, desc(PlotData$Difference))

PlotData_L = melt(PlotData[1:3], id.vars = "Student_ID", value.name = "Grade")
PlotData_L$Diff2 <- c(PlotData$Difference,PlotData$Difference)

#Plot Parallel coordinates
g <-ggplot(PlotData_L, aes(x = variable, y = Grade, group = Student_ID)) +  
  geom_path(aes(color = Diff2)) + 
  scale_color_gradient2("Grade Difference", midpoint = 0) +
  theme(legend.position = "bottom") + 
  labs(x = NULL)

plot(g)

#Interactive Plot
#require(plotly)
#ggplotly(g, tooltip = c("Student_ID","Grade"))
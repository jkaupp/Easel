#Question: How are students performing between assessments? 
#Exploration of Trends

#Get Data
PlotData <- readRDS(file.path("data", "V02A.rds"))

# Arrange vis by this column
ArrangedAssessment <- PlotData$Assessment_1
PlotData$Student_ID <- factor(PlotData$Student_ID, levels=(PlotData$Student_ID)[order(ArrangedAssessment)])

# Turn into long form for ggplot
PlotData_L <- melt(PlotData, id="Student_ID", value.name = "Grade")

#Plot heatmap
g <- ggplot(PlotData_L) + 
  geom_tile(mapping = aes(x = variable, y = Student_ID, fill = Grade)) + 
  scale_fill_gradientn("GPA", colours = RColorBrewer::brewer.pal(5,"Blues"), limits = c(0,4.3)) +
  labs(x = NULL, y = "Student")

plot(g)

#Interactive version: 
#require(plotly)
#ggplotly(g, tooltip = c("Student_ID","Grade"))
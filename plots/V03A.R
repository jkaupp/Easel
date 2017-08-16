#Question: Are students of a particular grouping improving between assessments? 
#Exploration of Students

#Get Data
PlotData <- readRDS(file.path("data", "V03A.rds"))

#Transofrm and Derive
PlotData <- PlotData[1:50,] %>%
            group_by(Group) %>%
            mutate(derived1 = row_number())

#Convert to Long Form
PlotData_L <- melt(PlotData, id.vars = c("Student_ID","Group", "derived1"), value.name = "Grade")

#Plot Data
g <-ggplot(PlotData_L, aes(x = variable, y = Grade, group = Student_ID)) +  
  geom_line(mapping = aes(color = derived1), alpha = 0.9) +
  scale_color_gradientn("Student", colours = RColorBrewer::brewer.pal(9,"Blues"), limits = c(max(PlotData_L$derived1),0)) +
  facet_grid(~Group) +
  theme(axis.text.x = element_blank()) +
  labs(x = "Assessment")

plot(g)

# Interactive Version: 
#require(plotly)
#plotly::ggplotly(g, tooltip = c( "Grade", "Student_ID"))
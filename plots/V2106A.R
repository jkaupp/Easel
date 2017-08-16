#Question: What are the typical selection of elective courses for students of a particular demographic group?
#Exploration of Extremes

#Get Data
PlotData <- readRDS(file.path("data", "V2106A.rds"))

# Calculate proportional enrollment in each course

PlotData <- PlotData %>%
  mutate(Group_prop = Group_took/30, # Number of students in group
         Total_prop = Total_took/84, # Total number of students in program
         year = factor(year, 2:4, c("Second Year","Third Year","Fourth Year"))) %>% # Create new names for each course year
  group_by(year) %>%
  mutate(dr1 = row_number())

# Plot
g <- ggplot(PlotData, aes(x = dr1, y = 1)) +
  geom_col(aes(fill = Group_prop, color = Total_prop), lwd = 3) +
  geom_text(aes(label = courses), color = "white", vjust = 5) +
  scale_fill_gradientn("Group Proportion (Fill)", colours = RColorBrewer::brewer.pal(5,"Blues"), limits = c(0,1), labels = scales::percent) +
  scale_color_gradientn("Total Proportion (Outline)", colours = RColorBrewer::brewer.pal(5,"Blues"), limits = c(0,1), labels = scales::percent) +
  facet_wrap(~year, ncol = 1) +
  coord_equal() +
  theme_void() +
  theme(legend.position = "bottom")

plot(g)

#Interactive Version: 
#require(plotly)
#ggplotly(g, tooltip = c("courses", "Group_prop", "Total_prop"))

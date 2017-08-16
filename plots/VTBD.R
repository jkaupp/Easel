# We have not yet created the code for this visualization

# It will be available in the final version of Easel
PlotData <- readRDS(file.path("data", "VTBD.rds"))

#Plot Data
g <- ggplot(PlotData) +
  geom_bar(mapping = aes(x = ID, y = Sample), stat="identity", fill = "grey") + 
  annotate("text", label = "Still in Progress\nPlot will be here\nin final version of Easel", 
           x = 5.5, y = 5, color = "red", size = 6)

plot(g)

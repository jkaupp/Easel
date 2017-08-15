#Question: How many students don’t meet a threshold? 
#Communication of Distributions

#Get Data
PlotData <- readRDS(file.path("data", "V12A.rds"))

#Choose Threshold:
threshold <- 3.5 

#Transofrm and Derive
PlotData <- PlotData %>%
            mutate(AboveBelow = ifelse(Assessment_Measure >= threshold,"Above","Below"))

AboveBelow <- table(PlotData$AboveBelow)

#Plot Data
g <- ggplot(PlotData, mapping = aes(fill = AboveBelow)) +
     geom_histogram(mapping = aes(x = Assessment_Measure), bins = 30) +
     scale_fill_manual(values = c("#91CF60", "#FC8D59")) + # Manually selects colors 
     labs(x = "Assessment Measure", y = "Student Count") + # Renames Axis labels
     theme(legend.position = "none") + # Removes legend
     # Might require manual editing: 
     annotate("text", label=paste("Below: ", as.character(AboveBelow["Below"])), x=1, y = 35, size = 6, color = "#FC8D59") + 
     annotate("text", label=paste("Above: ", as.character(AboveBelow["Above"])), x=4, y = 35, size = 6, color = "#91CF60")

plot(g)
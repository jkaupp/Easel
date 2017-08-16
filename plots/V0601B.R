#Question: Comparing class knowledge to prior course. 
#Exploration of Distribution Comparisons

#Get Data
PlotData <- readRDS(file.path("data", "V0601A.rds"))

#Choose number of bins
bNum <- 15

#Option 1 (Superimposed Histograms):  
#g <- ggplot(PlotData) +
#  geom_histogram(mapping = aes(x = Prior_Course, fill = "b"), bins = bNum) +
#  geom_histogram(mapping = aes(x = Current_Course, fill = "g"), bins = bNum, alpha=0.8, position = position_dodge(width=0.5)) + 
#  scale_fill_manual(name=NULL, values=c("b"="blue", "g"="grey"), labels=c("b"="Prior Course", "g"="Current Course")) +
#  theme(legend.position = "bottom")
#  labs(x = "Grade", y = "Student Count")

#Option 2 (Facetted Histograms):
#First need to convert to long form data: 
PlotData_L <- melt(PlotData, id.vars = "Student_ID", value.name = "Grade")
levels(PlotData_L$variable) <- c("Prior Course", "Current Course")

#Plot histograms: 
g <- ggplot(PlotData_L) + 
     geom_histogram(mapping = aes(x = Grade), bins = bNum) + # Choose number of bins to use
     facet_wrap(~variable, ncol = 1) + 
     labs(x = "Grade", y = "Student Count")

plot(g)

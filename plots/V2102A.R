#Question: Do under-represented groups have the same graduating rate as highly represented groups?
#Communication of Trends

#Get Data
PlotData <- readRDS(file.path("data", "V2102A.rds"))

#Transofrm to Summarized Table
gy <- 2011:2017 # Graduation years to look at
gr <- levels(PlotData$Residential_Status) #Grouping categories

SummData <- data.frame(matrix(0, ncol = length(gr)+1, nrow = length(gy)))
SummData[,1] <- gy
for (y in gy) {
  for (g in gr) {
    window <- PlotData$Enrolment_Year < y-4 & PlotData$Enrolment_Year >= y-7 & PlotData$Residential_Status == g
    SummData[which(gy==y),which(gr==g)+1] <-sum(filter(PlotData,window)$Graduation_Year < y, na.rm=TRUE)/sum(window)
  }
}
colnames(SummData) <- c("Graduation_Year", gr)

#Melt into longform data
PlotData_L <- melt(SummData, id.vars = "Graduation_Year", value.name = "Graduation_Rate")

#Plot Data
g <- ggplot(PlotData_L) +
  geom_line(mapping = aes(x=Graduation_Year, y = Graduation_Rate, color=variable)) + 
  theme(legend.position = "bottom") + 
  scale_y_continuous(labels = scales::percent, limits = c(0,1)) +
  labs(x = "Graduation Year", y = "Graudation Rate\n(Graudated within 7 years of enrolment)") +
  guides(color=guide_legend(title="Residential Status"))

plot(g)

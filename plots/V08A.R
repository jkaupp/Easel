#Question: How are student ratings for other students changing over time? 
#Exploration of Distributions over Time

#Get Data
PlotData <- readRDS(file.path("data", "V08A.rds"))

# Calculate difference of measures; then sort positive, negative difference and find lower measure
PlotData <- PlotData %>% 
            mutate(Difference = PeerAssessment_2 - PeerAssessment_1,
                   PDiff = (Difference>=0)*Difference, 
                   NDiff = (Difference<0)*Difference, 
                   Low = ifelse(Difference>=0,PeerAssessment_1,PeerAssessment_2),
                   Self = ifelse(Student_Rating==Rated_Student,0,-1))

# Select appropriate columns in order and melt into long-form data
PlotData_L <- select(PlotData,1:2,9,8,7,6) %>% melt(id.vars = c("Student_Rating", "Rated_Student", "Self"))

#Plot Data
g <- ggplot(PlotData_L, aes(x = Rated_Student, y = value, fill=variable)) +
  geom_bar(mapping = aes(size=Self), stat='identity', position=position_stack(), color="blue") + # Plot stacked
     facet_wrap(~Student_Rating, nrow = 1) + # Have chart for each team rater
     scale_fill_manual(guide = FALSE, name = NULL, values=c("grey","#D55E00","#009E73")) + # Use grey for neutral, red for negative, and green for positive
     scale_size_continuous(guide = FALSE, limits=c(0,1)) + # Controls border around bars to show self-ratings
     labs(x = "Rated Team Member", y = "Rating")

plot(g)

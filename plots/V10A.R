#Question: How has the university/department changed since the last benchmark? 
#Exploration of Trends

#Get Data
PlotData <- readRDS(file.path("data", "V10A.rds"))

#Clean up Measure names and melt into Longform data
PlotData_L <- PlotData %>% 
              mutate(Measure_p = stringr::str_wrap(Measure, width = 20),                #Create multi-line names
                    Measure_f = factor(Measure_p, levels = as.vector(Measure_p))) %>%  #Make sure ordering is the same
              select(8,2:6) %>%
              melt(id.vars = c("Measure_f", "Category"), 
                   value.name = "Measurement")
#Plot Data
g<-ggplot(PlotData_L) + 
  geom_bar(mapping = aes(x=variable, y=Measurement, fill = Category), stat='identity') + 
  facet_wrap(~Measure_f) + 
  labs(x = "Year") +
  theme(axis.text.x = element_text(angle=45), axis.ticks.x = element_blank(), 
        strip.text = element_text(size=7),
        legend.position = "bottom") +
  guides(fill=guide_legend(nrow=2,byrow=TRUE))

plot(g)
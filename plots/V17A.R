#Question: What is the relationship between being in a non-mutually exclusive group X and a student’s assessment result? 
#Summary of Data

#Get Data
PlotData <- readRDS(file.path("data", "V17A.rds"))

#creating subset with only information on if students are in the BEd option or not, and grades
#piping to calculating the mean of each group and group size
BEd <- group_by(PlotData, Bed_option) %>%
  summarise(nstudents = length(Bed_option), avg_grade = mean(grade)) %>%
  set_names(., c("group", "nstudents", "avg_grade"))

#creating subset with only information on what program students are in
#piping to calculating the mean of each group and group size
Program <- group_by(PlotData, program) %>%
  summarise(nstudents = length(program), avg_grade = mean(grade)) %>%
  set_names(., c("group", "nstudents", "avg_grade"))

#Combine tables and order based on student count
SummaryData <- rbind(BEd,Program) %>%
  mutate(group=factor(group, 
                      levels=(group)[order(nstudents, decreasing = TRUE)]))

#calculating the mean of all the students
grand_mean <- mean(PlotData$grade)

#Plot Data
g <- ggplot(SummaryData) +
  geom_col(mapping = aes(x = group, y = avg_grade, fill = nstudents)) +
  geom_text(mapping = aes(label=group, x = group, y = avg_grade-10), color="white") +
  geom_text(mapping = aes(label=paste("N =",nstudents), x = group, y = avg_grade-15), color="white") +
  geom_hline(yintercept = grand_mean, color="red") + 
  labs(x = "Academic Program and Bachelor of Education Option", y = "Average Grade", fill = "Number of Students") + 
  theme(legend.position = "bottom")

plot(g)

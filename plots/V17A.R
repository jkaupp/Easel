#Question: What is the relationship between being in a non-mutually exclusive group X and a student’s assessment result? 
#Summary of Data

#Get Data
PlotData <- readRDS(file.path("data", "V17A.rds"))

#Transofrm and Derive
#creating subset with only information on if students are in the BEd option or not, and grades
#piping to calculating the mean of each group and group size
BEd <- group_by(PlotData, Bed_option) %>%
  summarise(nstudents = length(Bed_option), avg_grade = mean(grade))

#creating subset with only information on what program students are in
#piping to calculating the mean of each group and group size
Program <- group_by(PlotData, program) %>%
  summarise(nstudents = length(program), avg_grade = mean(grade))

#calculating the mean of all the students
grand_mean <- mean(PlotData$grade)

#Plot Data
g <- ggplot() +
  geom_col(BEd, mapping = aes(x = Bed_option, y = avg_grade, fill = nstudents)) +
  geom_col(Program, mapping = aes(x = program, y = avg_grade, fill = nstudents)) +
  geom_hline(yintercept = grand_mean, color="red") + 
  labs(x = "Academic Program and Bachelor of Education Option", y = "Average Grade", fill = "Number of Students") + 
  theme(legend.position = "bottom")

plot(g)

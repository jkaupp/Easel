Course <- readRDS("/Users/Ajay/Google Drive/Graduate School/Thesis/Toolkit/Data/Random/CourseEnrollment.rds")

# Calculate proportional enrollment in each course
Course$Group_prop <- Course$Group_took/30
Course$Total_prop <- Course$Total_took/84

# Plot
ggplot(Course, aes(x=courses, y = 1)) +
  geom_bar(stat='identity', mapping = aes(fill=Group_prop, color = Total_prop, label = courses), lwd = 3) +
  geom_text(aes(x=courses, y=1, label=courses), color="white", vjust=0.5, hjust=1.25, angle=90) +
  facet_wrap(~year, ncol = 1)
Course <- readRDS("/Users/Ajay/Google Drive/Graduate School/Thesis/Toolkit/Data/Random/CourseEnrollment.rds")

# Calculate proportional enrollment in each course
Course$Group_prop <- Course$Group_took/30
Course$Total_prop <- Course$Total_took/84

# Create new names for each course year
Course$dr1 <- 0
Course$dr1[Course$year==2] <- which(Course$year==2) - which(Course$year==2)[1] + 1
Course$dr1[Course$year==3] <- which(Course$year==3) - which(Course$year==3)[1] + 1
Course$dr1[Course$year==4] <- which(Course$year==4) - which(Course$year==4)[1] + 1

# Plot
ggplot(Course, aes(x=dr1, y = Group_prop))  +
  geom_bar(stat='identity', mapping = aes(label = courses)) +
  geom_point(stat='identity', mapping = aes(y = Total_prop)) + 
  geom_text(aes(x=dr1, y=1, label=courses), color = "white", vjust=8) +
  facet_wrap(~year, ncol = 1)
Course <- readRDS(file.path("data", "Q01A1.rds"))

# Calculate proportional enrollment in each course
Course$Group_prop <- Course$Group_took/30
Course$Total_prop <- Course$Total_took/84

# Create new names for each course year
Course$dr1 <- 0
Course$dr1[Course$year==2] <- which(Course$year==2) - which(Course$year==2)[1] + 1
Course$dr1[Course$year==3] <- which(Course$year==3) - which(Course$year==3)[1] + 1
Course$dr1[Course$year==4] <- which(Course$year==4) - which(Course$year==4)[1] + 1

# Plot
ggplot(Course, aes(x = dr1, y = 1)) +
  geom_bar(stat='identity', mapping = aes(fill=Group_prop, color = Total_prop, label = courses), lwd = 3) +
  geom_text(aes(x=dr1, y=1, label=courses), color="white", vjust=5) +
  facet_wrap(~year, ncol = 1)

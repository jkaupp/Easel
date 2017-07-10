Course <- readRDS(file.path("data", "Q01A1.rds"))

# Calculate proportional enrollment in each course
# Create new names for each course year
Course <- Course %>%
  mutate(Group_prop = Group_took/30,
         Total_prop = Total_took/84,
         year = factor(year, 2:4, c("Second Year","Third Year","Fourth Year"))) %>%
  group_by(year) %>%
  mutate(dr1 = row_number())

# Plot
ggplot(Course, aes(x = dr1, y = 1)) +
  geom_col(aes(fill = Group_prop, color = Total_prop), lwd = 3) +
  geom_text(aes(label = courses), color = "white", vjust = 5) +
  scale_fill_gradientn("Group Proportion", colours = RColorBrewer::brewer.pal(5,"Blues"), limits = c(0,1), labels = scales::percent) +
  scale_color_gradientn("Total Proportion", colours = RColorBrewer::brewer.pal(5,"Blues"), limits = c(0,1), labels = scales::percent) +
  coord_equal() +
  theme_void() +
  theme(legend.position = "bottom") +
  facet_wrap(~year, ncol = 1)

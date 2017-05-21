library(tidyverse)
library(jkmisc)
library(waffle)
library(scales)

quiver <- RSQLServer::src_sqlserver("FEAS", database = "Quiver")
qarch <- RSQLServer::src_sqlserver("FEAS", database = "qarchives")

# Difference Bar Chart (Not sure what it’s called: But the one where it shows a positive or negative change among different attributes)
# Learning Outcomes Tree Map (I think I’ve seen this on the wall)
# Histogram (I’m not sure if you have any with extra information on it)
# Heat Map (could be for anything

# Waffle (Square Pie) ----

map_data <- quiver %>%
  tbl("curriculum_maps") %>%
  filter(dept == "CHEE") %>%
  collect() %>%
  count(level) %>%
  mutate(level = factor(level, c("Introduce", "Develop","Apply"))) %>%
  arrange(level)

plot_data <- setNames(map_data$n, map_data$level)

waffle <- waffle(plot_data, colors = .tol3qualitative, rows = 15, size = 1, legend_pos = "bottom",
       xlab = "1 Square = 1 Learing Outcome",
       title = "Waffle Chart") +
  theme(text = element_text(family = "Oswald-Light"))

ggsave("Waffle Chart.png", plot = waffle)

# Column Chart comparing groups/time periods over a number of different attributes-----

plot_data <- qarch %>%
  tbl("frozen") %>%
  filter(Term %in% c(2129,2139,2149,2159,2169), ACAD_CAREER == "UGRD", ACAD_GROUP == "ENG") %>%
  select(Term, ACAD_PLAN, CONC1) %>%
  collect() %>%
  filter(CONC1 %in% c("CHEE","CIVIL","MINE","MECH","ELEC","CMPE")) %>%
  count(Term, CONC1)

column_chart <- ggplot(plot_data, aes(x = Term, y = n, fill = reorder(CONC1, n))) +
  geom_col(position = "dodge") +
  labs(x = NULL, y = NULL, title = "Bar Chart comparing groups over time periods", subtitle = "Counts over 5 years") +
  scale_x_discrete(labels = sprintf("20%s", substr(c(2129,2139,2149,2159,2169),2,3)), breaks = c(2129,2139,2149,2159,2169)) +
  scale_y_continuous(breaks = pretty_breaks()) +
  scale_fill_manual("Categories", values = .tol5qualitative, labels = sprintf("Category %s", 1:5)) +
  theme_jk()

ggsave("Column Chart.png", plot = column_chart)

# Difference Bar Chart (Not sure what it’s called: But the one where it shows a positive or negative change among different attributes)

balance <- data.frame(desc = sprintf("Category %s", 1:8), amount = c(.20, .34, -.11, -.21, -.66, .38, .14, .28)) %>%
  mutate(desc = factor(desc, desc),
         id = seq_along(amount),
         type = ifelse(amount > 0, "Positive", "Negative"),
         end = cumsum(amount))



pd_bar <- ggplot(balance, aes(x = desc, y = amount, fill = type)) +
  geom_col() +
  scale_fill_manual("Change", values = setNames(.tol2qualitative, c("Positive","Negative"))) +
  scale_x_discrete() +
  labs(x = NULL, y = NULL, title = "Percent Difference Bar Chart", subtitle = "Percent Change by Category") +
  scale_y_continuous(labels = percent) +
  theme_jk()

ggsave("Percent Difference Bar.png", plot = pd_bar)

plot_data <- quiver %>%
  tbl("FEAS_outcomes") %>%
  filter(course_code == "APSC 101", academic_year == "2015-2016", assessment == "MEA1", indicator == "APSC-1-CO-2") %>%
  collect()

hist <- ggplot(plot_data, aes(x = plevel)) +
  geom_bar(fill = .tol1qualitative) +
  scale_x_discrete(limits = c("Not Demonstrated","Marginal","Meets Expectations","High Quality","Mastery")) +
  labs(x = NULL, y = NULL, title = "Histogram/Bar Chart of Student Performance", subtitle = "Number of students by performance level") +
  theme_jk()

ggsave("histogram.png", plot = hist)


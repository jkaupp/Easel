ggplot(head(diamonds, 50), aes(x = carat, y = price)) +
  geom_point(aes(color = cut)) +
  scale_color_brewer() +
  theme_minimal()

library(animint2)
data(mtcars)
mtcars$car <- rownames(mtcars)
mtcars$cyl <- factor(mtcars$cyl)
large_theme <- theme_bw(base_size = 18) +
  theme(
    plot.title = element_text(size = 22, face = "bold"),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    legend.title = element_text(size = 18),
    legend.text = element_text(size = 16),
    plot.margin = margin(15, 20, 15, 20)
  )

# Scatter plot (controls selection)
scatter_plot <- ggplot(
  mtcars,
  aes(wt, mpg, color = cyl)
) +
  geom_point(
    size = 5,
    clickSelects = "cyl"
  ) +
  large_theme +
  labs(
    title = "MPG vs Weight by Cylinder",
    x = "Weight",
    y = "Miles per Gallon",
    color = "Cylinders"
  )

# Create MPG bins manually (no stat_bin)
breaks <- seq(
  floor(min(mtcars$mpg)),
  ceiling(max(mtcars$mpg)),
  by = 5
)
mtcars$mpg_bin <- cut(
  mtcars$mpg,
  breaks = breaks,
  include.lowest = TRUE
)

# Count cars per bin per cylinder
count_data <- as.data.frame(
  table(mtcars$mpg_bin, mtcars$cyl)
)
colnames(count_data) <- c("mpg_bin", "cyl", "count")

# Bar chart
bar_plot <- ggplot(
  count_data,
  aes(x = mpg_bin, y = count, fill = cyl)
) +
  geom_bar(
    stat = "identity",
    position = "identity",
    alpha = 0.8,
    showSelected = "cyl"
  ) +
  large_theme +
  labs(
    title = "MPG Distribution by Cylinder",
    x = "MPG Range",
    y = "Count",
    fill = "Cylinders"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

easy_viz <- animint(
  scatter = scatter_plot,
  bars = bar_plot,
  first = list(cyl = "4"),  # FIX: select cyl=4 by default so bars visible on load
  title = "Linked mtcars Visualization (Easy Test)",
  source = "https://github.com/ashishtiwari03/animint2-tests"
)

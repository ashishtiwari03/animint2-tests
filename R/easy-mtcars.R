library(animint2)

data(mtcars)

mtcars$car <- rownames(mtcars)
mtcars$cyl <- factor(mtcars$cyl)

large_theme <- theme_bw(base_size = 16) +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 14),
    legend.title = element_text(size = 16),
    legend.text = element_text(size = 14)
  )

scatter_plot <- ggplot(mtcars,
                       aes(wt, mpg, color = cyl)) +
  geom_point(clickSelects = "cyl", size = 4) +
  large_theme +
  labs(title = "MPG vs Weight by Cylinder",
       x = "Weight",
       y = "Miles per Gallon",
       color = "Cylinders")

hist_plot <- ggplot(mtcars,
                    aes(mpg, fill = cyl)) +
  geom_histogram(bins = 10,
                 alpha = 0.7,
                 showSelected = "cyl") +
  large_theme +
  labs(title = "Distribution of MPG",
       x = "Miles per Gallon",
       y = "Count",
       fill = "Cylinders")

options(
  animint.width = 900,
  animint.height = 500,
  animint.css = "
    button { font-size: 18px !important; }
    select { font-size: 18px !important; }
    body { font-size: 18px !important; }
  "
)

viz <- animint(
  scatter = scatter_plot,
  histogram = hist_plot,
  source = "https://github.com/ashishtiwari03/animint2-tests"
)

viz
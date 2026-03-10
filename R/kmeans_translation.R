library(animint2)
set.seed(123)

# Create 3-cluster synthetic dataset
x1 <- matrix(rnorm(100, mean = 0, sd = 0.4), ncol = 2)
x2 <- matrix(rnorm(100, mean = 3, sd = 0.4), ncol = 2)
x3 <- matrix(rnorm(100, mean = 6, sd = 0.4), ncol = 2)
data_mat <- rbind(x1, x2, x3)
colnames(data_mat) <- c("x", "y")
data_points <- data.frame(
  id = 1:nrow(data_mat),
  x = data_mat[, 1],
  y = data_mat[, 2]
)

k <- 3
max_iter <- 10
# Random initial centers
centers <- data_points[sample(1:nrow(data_points), k), c("x", "y")]

points_list <- list()
centers_list <- list()
objective_list <- list()

for (iter in 1:max_iter) {

  # Compute squared distances
  dist_matrix <- sapply(1:k, function(j) {
    (data_points$x - centers$x[j])^2 +
      (data_points$y - centers$y[j])^2
  })

  cluster_assign <- apply(dist_matrix, 1, which.min)
  total_ss <- sum(apply(dist_matrix, 1, min))

  points_list[[iter]] <- data.frame(
    iteration = iter,
    id = data_points$id,
    x = data_points$x,
    y = data_points$y,
    cluster = factor(cluster_assign)
  )

  objective_list[[iter]] <- data.frame(
    iteration = iter,
    total_ss = total_ss
  )

  # Update centers
  new_centers <- aggregate(
    cbind(x, y) ~ cluster,
    data = data.frame(
      x = data_points$x,
      y = data_points$y,
      cluster = cluster_assign
    ),
    mean
  )

  centers <- new_centers[, c("x", "y")]
  centers_list[[iter]] <- data.frame(
    iteration = iter,
    cluster = factor(1:k),
    x = centers$x,
    y = centers$y
  )
}

points_iter <- do.call(rbind, points_list)
centers_iter <- do.call(rbind, centers_list)
objective_iter <- do.call(rbind, objective_list)

theme_large <- theme_bw(base_size = 16)

# FIX 1 & 2: Use same aesthetics (color + fill) on both geoms to unify into
# one legend. scale_color_discrete(guide="none") drops the duplicate.
cluster_plot <- ggplot() +
  geom_point(
    aes(x = x, y = y, color = cluster, fill = cluster),
    data = points_iter,
    showSelected = "iteration",
    shape = 21,
    size = 2
  ) +
  geom_point(
    aes(x = x, y = y, color = cluster, fill = cluster),
    data = centers_iter,
    showSelected = "iteration",
    shape = 21,
    size = 7,
    stroke = 1.5
  ) +
  scale_color_discrete(guide = "none") +  # drop duplicate color legend
  theme_large +
  labs(
    title = "K-means Clustering (Iterations)",
    fill = "Cluster"
  )

# FIX 3: Use geom_tallrect with clickSelects for iteration selection —
# this is the idiomatic animint2 way to click along an x-axis variable.
objective_plot <- ggplot(objective_iter, aes(x = iteration, y = total_ss)) +
  geom_tallrect(
    aes(xmin = iteration - 0.5, xmax = iteration + 0.5),
    clickSelects = "iteration",
    alpha = 0.3
  ) +
  geom_line() +
  geom_point(size = 3) +
  theme_large +
  labs(
    title = "Objective Function (click bar to select iteration)",
    x = "Iteration",
    y = "Total Within-Cluster SS"
  )

kmeans_viz <- animint(
  cluster = cluster_plot,
  objective = objective_plot,
  time = list(
    variable = "iteration",
    ms = 1200
  ),
  title = "K-means Animation (Medium Test)",
  source = "https://github.com/ashishtiwari03/animint2-tests"
)

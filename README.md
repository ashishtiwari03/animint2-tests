# animint2-tests

This repository contains practice ports and interactive visualizations built using the **animint2** package in R.

The goal is to translate examples from the `animation` package into interactive web-based visualizations using the grammar of graphics.

---

## ✅ Easy Test – Linked mtcars Visualization

This visualization demonstrates the use of:

- `clickSelects`
- `showSelected`
- linked plots without Shiny
- deployment via `animint2pages()`

### 🔗 Live Demo

https://ashishtiwari03.github.io/animint2-easy-pages/

### 📁 Source Code

```
R/easy-mtcars.R
```

---

## ✅ Medium Test – K-means Clustering Animation

This visualization recreates the `kmeans.ani()` animation using animint2.

Features:

- Manual implementation of K-means algorithm
- Iterative cluster center updates
- Animated iteration control using `time`
- Objective function tracking (Within-Cluster Sum of Squares)
- Dual-panel visualization (cluster + objective)

### 🔗 Live Demo

https://ashishtiwari03.github.io/animint2-medium-pages/

### 📁 Source Code

```
R/kmeans_translation.R
```

---

## ✅ Medium-Hard – Animint Gallery

A dynamic gallery website built using **R Markdown**, listing all deployed animint visualizations.

Features:

- Data-driven structure via `meta.csv`
- Screenshot previews
- Direct demo links
- Source code links
- Clean Bootstrap layout
- GitHub Pages deployment via `gh-pages`

### 🔗 Live Gallery

https://ashishtiwari03.github.io/animint-gallery/

### 📁 Gallery Repository

https://github.com/ashishtiwari03/animint-gallery

---

## 🧠 Note on ggplot2 Masking

If both `ggplot2` and `animint2` are loaded together:

```r
library(ggplot2)
library(animint2)
```

R will display masking messages because `animint2` provides modified versions of ggplot functions.

For these implementations, only:

```r
library(animint2)
```

is used to avoid namespace conflicts.

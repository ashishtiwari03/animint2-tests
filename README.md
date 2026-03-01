# animint2-tests

This repository contains practice ports and interactive visualizations built using the **animint2** package in R.

The objective is to translate examples from the `animation` package into interactive, web-based visualizations using the grammar of graphics and animint2’s interactive features.

---

## Repository Structure

All source code lives in the `R/` directory.  
Each visualization is deployed to a separate GitHub Pages repository using `animint2pages()`.

---

# Easy Test – Linked mtcars Visualization

This visualization demonstrates:

- `clickSelects`
- `showSelected`
- linked plots without Shiny
- static GitHub Pages deployment

### Live Demo

https://ashishtiwari03.github.io/animint2-easy-pages

### Source Code

### Description

The visualization consists of two linked plots:

1. **Scatter plot – MPG vs Weight**
   - Clicking a cylinder group selects that category.
   - Implemented using `clickSelects = "cyl"`.

2. **Bar chart – MPG distribution by cylinder**
   - Updates dynamically based on selection.
   - Implemented using `showSelected = "cyl"`.

The bar chart uses `stat="identity"` and `position="identity"` because `showSelected` does not work with `stat_bin`.

---

# Medium Test – K-means Animation

This visualization translates the iterative behavior of `animation::kmeans.ani()` into animint2.

It demonstrates:

- Iterative algorithm translation
- Construction of per-iteration data frames
- `time = list(variable = "iteration")`
- Linked multi-panel animation
- Objective function tracking

### Live Demo

https://ashishtiwari03.github.io/animint2-medium-pages

### Source Code

### Description

The implementation manually reproduces the k-means clustering steps:

1. Initialize random cluster centers.
2. Assign each point to the nearest center.
3. Update centers using cluster means.
4. Repeat for multiple iterations.

For each iteration:

- Point assignments are stored.
- Cluster centers are stored.
- Total within-cluster sum of squares is computed.

Two linked plots are rendered:

- **Cluster visualization** (points + moving centers)
- **Objective function plot** (total SS vs iteration)

The animation is controlled using:

```r
time = list(variable = "iteration")

# animint2-tests

This repository contains practice ports and interactive visualizations built using the **animint2** package in R.

The goal is to translate examples from the `animation` package into interactive web-based visualizations using the grammar of graphics.

---

## Easy Test – Linked mtcars Visualization

This visualization demonstrates the use of:

- `clickSelects`
- `showSelected`
- linked plots without shiny
- deployment via `animint2pages()`

### Live Demo

https://ashishtiwari03.github.io/animint2-easy-pages

### Source Code

The implementation can be found in:

```
R/easy-mtcars.R
```

---

## Description

The visualization consists of two linked plots:

1. **Scatter plot – MPG vs Weight**
   - Clicking on a cylinder group selects that category.
   - Implemented using `clickSelects = "cyl"`.

2. **Bar chart – MPG distribution by cylinder**
   - Updates dynamically based on selection.
   - Implemented using `showSelected = "cyl"`.

The bar chart uses `stat="identity"` and `position="identity"` since `showSelected` does not work with `stat_bin`.

---

## Note on ggplot2 Masking

If both `ggplot2` and `animint2` are loaded together:

```r
library(ggplot2)
library(animint2)
```

R will show masking messages because `animint2` provides modified versions of ggplot functions.

For this project, visualization scripts load only:

```r
library(animint2)
```

to avoid namespace conflicts.

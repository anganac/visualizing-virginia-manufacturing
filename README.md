# The Long Decline: Manufacturing Job Loss in Southwest Virginia

**Visualizing Virginia Numbers — Trial Submission**  
Virginia Tech | Agricultural and Applied Economics

---

## Project Summary

This project visualizes two decades of manufacturing job loss across five Southwest Virginia counties — Wise, Lee, Scott, Dickenson, and Buchanan — from 2000 to 2022. Between 2000 and 2022, the region lost nearly half its manufacturing workforce, reflecting both long-run deindustrialization and the acute shock of the Great Recession.

> **Note:** The dataset used here is synthetic, generated to illustrate realistic patterns of manufacturing decline. In a full analysis, data would be sourced from the U.S. Census Bureau County Business Patterns (CBP), NAICS sector 31–33.

---

## Repository Structure

```
visualizing-virginia-manufacturing/
├── data/
│   ├── raw/
│   │   └── sw_virginia_manufacturing.csv      # Raw synthetic employment data
│   └── processed/
│       ├── sw_virginia_summary.csv            # County-level 2000 vs. 2022 comparison
│       ├── sw_virginia_yoy.csv                # Year-over-year changes by county
│       └── sw_virginia_region_totals.csv      # Region-wide annual totals
├── code/
│   └── process_data.R                         # R script: raw → processed data
├── index.html                                 # Integrated data story webpage
└── README.md
```

---

## Data

| File | Description |
|------|-------------|
| `data/raw/sw_virginia_manufacturing.csv` | Annual manufacturing job counts for 5 counties, 2000–2022 |
| `data/processed/sw_virginia_summary.csv` | Jobs in 2000 vs. 2022, total loss, and % loss per county |
| `data/processed/sw_virginia_yoy.csv` | Year-over-year job change and % change per county |
| `data/processed/sw_virginia_region_totals.csv` | Region-wide totals and annual change, 2000–2022 |

---

## How to Reproduce

### Requirements
- R (version 4.0 or higher)
- R packages: `tidyverse`

Install dependencies:
```r
install.packages("tidyverse")
```

### Run the pipeline
1. Clone this repository
2. Open `code/process_data.R` in RStudio
3. Set your working directory to the repo root:
```r
setwd("path/to/visualizing-virginia-manufacturing")
```
4. Run the script — it will read from `data/raw/` and write three CSVs to `data/processed/`

### View the data story
Open `index.html` in any web browser, or visit the live page at:  
**https://anganac.github.io/visualizing-virginia-manufacturing/**

---

## Key Findings

- The five-county region lost **~48% of manufacturing jobs** between 2000 and 2022
- All counties show a consistent pattern: gradual decline in the early 2000s, a sharp drop in 2008–2010, a brief partial recovery, then resumed decline
- **Buchanan County** experienced the steepest proportional loss (~50%)
- The Great Recession accelerated an already ongoing structural decline

---

## Live Data Story

👉 [View the integrated data story](https://anganac.github.io/visualizing-virginia-manufacturing/)

---

*Submitted to Visualizing Virginia Numbers | Virginia Tech, 2024*

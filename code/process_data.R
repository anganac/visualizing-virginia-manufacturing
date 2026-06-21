# ============================================================
# process_data.R
# Southwest Virginia Manufacturing Job Loss
# Visualizing Virginia Numbers — Trial Submission
#
# Input:  data/raw/sw_virginia_manufacturing.csv
# Output: data/processed/sw_virginia_summary.csv
#         data/processed/sw_virginia_pct_change.csv
# ============================================================

library(tidyverse)

# ── 1. Load raw data ─────────────────────────────────────────
raw <- read_csv("data/raw/sw_virginia_manufacturing.csv")

# ── 2. Compute year-over-year change ────────────────────────
yoy <- raw %>%
  arrange(county, year) %>%
  group_by(county) %>%
  mutate(
    jobs_prev_year  = lag(manufacturing_jobs),
    yoy_change      = manufacturing_jobs - jobs_prev_year,
    yoy_pct_change  = round((yoy_change / jobs_prev_year) * 100, 2)
  ) %>%
  ungroup()

# ── 3. County-level summary (2000 vs 2022) ──────────────────
county_summary <- raw %>%
  filter(year %in% c(2000, 2022)) %>%
  pivot_wider(
    id_cols   = county,
    names_from  = year,
    values_from = manufacturing_jobs,
    names_prefix = "jobs_"
  ) %>%
  mutate(
    jobs_lost     = jobs_2000 - jobs_2022,
    pct_loss      = round((jobs_lost / jobs_2000) * 100, 1),
    peak_year     = map_int(county, function(c) {
      raw %>% filter(county == c) %>% slice_max(manufacturing_jobs, n = 1) %>% pull(year)
    }),
    trough_year   = map_int(county, function(c) {
      raw %>% filter(county == c) %>% slice_min(manufacturing_jobs, n = 1) %>% pull(year)
    })
  )

# ── 4. Region-wide totals by year ───────────────────────────
region_totals <- raw %>%
  group_by(year) %>%
  summarise(
    total_jobs     = sum(manufacturing_jobs),
    n_counties     = n_distinct(county),
    .groups        = "drop"
  ) %>%
  mutate(
    total_prev     = lag(total_jobs),
    total_yoy_chg  = total_jobs - total_prev,
    total_yoy_pct  = round((total_yoy_chg / total_prev) * 100, 2)
  )

# ── 5. Write outputs ─────────────────────────────────────────
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

write_csv(county_summary,  "data/processed/sw_virginia_summary.csv")
write_csv(yoy,             "data/processed/sw_virginia_yoy.csv")
write_csv(region_totals,   "data/processed/sw_virginia_region_totals.csv")

# ── 6. Quick sanity check ────────────────────────────────────
cat("\n── County summary ──────────────────────────────────────\n")
print(county_summary %>% select(county, jobs_2000, jobs_2022, jobs_lost, pct_loss))

cat("\n── Region totals (first and last) ──────────────────────\n")
print(region_totals %>% filter(year %in% c(2000, 2009, 2022)))

cat("\nDone. Processed files written to data/processed/\n")

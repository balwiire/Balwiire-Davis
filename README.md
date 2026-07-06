# Cost-of-Illness Toolkit

Small, reusable pipeline for estimating direct medical costs from routine facility-level visit data — the kind of calculation used in health economics cost-of-illness studies.

## What it does

- **Unit costing** (`unit_costing.py`): applies per-visit outpatient/inpatient unit costs to facility-month visit counts, with a CPI-adjustment helper to bring historical unit costs into a target price year
- **Winsorization** (`winsorize.py`): caps outlier facility-month observations (e.g. data-entry spikes) at configurable percentiles, and reports exactly how many rows were affected so the adjustment is auditable rather than silent
- **Summaries**: aggregate total cost, and outpatient/inpatient cost share, by any grouping (district, facility type, year)

## Why this matters

Cost-of-illness estimates are sensitive to a few decisions that are easy to get wrong or leave undocumented: which unit cost source to use, how to adjust it for inflation, and how to handle outliers. This toolkit makes each of those steps an explicit, testable function rather than an ad hoc notebook cell.

## Structure

```
src/unit_costing.py   # unit cost application + CPI adjustment
src/winsorize.py       # outlier capping with reporting
requirements.txt
```

## Example

**Python:**
```python
from unit_costing import UnitCosts, cpi_adjust, estimate_costs, summarize
from winsorize import winsorize_column

costs_2022 = UnitCosts(outpatient=5.84, inpatient=19.77, price_year=2022)
costs_2024 = cpi_adjust(costs_2022, cpi_multiplier=1.099, target_year=2024)

df = winsorize_column(df, "op_episodes")
df = estimate_costs(df, costs_2024)
summary = summarize(df, group_cols=["district", "year"])
```

**R** (equivalent implementation in `r/`):
```r
source("r/unit_costing.R")
source("r/winsorize.R")

costs_2022 <- make_unit_costs(outpatient = 5.84, inpatient = 19.77, price_year = 2022)
costs_2024 <- cpi_adjust(costs_2022, cpi_multiplier = 1.099, target_year = 2024)

df <- winsorize_column(df, "op_episodes")
df <- estimate_costs(df, costs_2024)
summary <- summarize_costs(df, group_cols = c("district", "year"))
```

Uses only base R — no extra packages required.

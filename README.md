# GitHub Portfolio Scaffold

Four ready-to-push repos:

1. **profile-repo/** — your GitHub profile README (rename to your username when creating the repo)
2. **malaria-forecasting-pipeline/** — ML disease forecasting demo (synthetic data, XGBoost/RF/Poisson, leakage guard)
3. **cost-of-illness-toolkit/** — health economics unit costing + CPI adjustment + winsorization
4. **results-table-automation/** — CSV → Markdown/Word results table CLI

All three code projects have been run end-to-end and work as-is, in **both Python and R**. Each project's `src/` folder has the Python version; each has a sibling `r/` folder with an equivalent R implementation (using `randomForest`/`gbm` in place of scikit-learn/XGBoost, and `knitr`/`officer` in place of pandas/python-docx). Both language versions were tested and produce consistent results — see each project's README for run instructions in either language.

## Quick start

```bash
export GITHUB_USERNAME=your-github-username
./setup.sh
```

This git-inits each folder, makes an initial commit, and — if you have the
GitHub CLI (`gh`) installed and logged in (`gh auth login`) — creates the
repo on GitHub and pushes it automatically. Without `gh`, it prints the
manual `git remote add` / `push` steps instead.

## Before you push

- Edit `profile-repo/README.md`: fill in your email/LinkedIn, remove the
  `(#)` placeholder links in the project table once repos are live
- Double check no real/confidential data ever gets committed — these repos
  are pre-loaded with synthetic data generators, not your real datasets

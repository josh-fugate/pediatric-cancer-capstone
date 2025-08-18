# Pediatric Cancer Capstone Project

This project explores pediatric cancer incidence in the United States using data from the CDC WONDER database (1999–2021).  
The goal was to clean and standardize the raw data, then build an **interactive Tableau dashboard** to highlight national and state-level trends across demographics such as age, sex, and race.

---

## 🔗 Dashboard
View the live dashboard here:  
[![Dashboard Preview](dashboard_preview.png)](https://public.tableau.com/app/profile/josh.fugate/viz/PediatricCancerIncidenceRates/MapDashboard)

---

## 📂 Repository Structure

```text
data/
└── incidence/
    └── clean/      # Processed .csv files ready for analysis
scripts/
└── clean_incidence_data.R  # R script to clean raw files
.gitignore                   # Excludes raw data and temp files
Pediatric Cancer Capstone.Rproj  # R project file
README.md                    # Project documentation
```

---

## ⚙️ Data Cleaning
The raw CDC WONDER extracts were cleaned using R (`tidyverse`, `janitor`):
- Dropped metadata columns (e.g., *_code, Notes).
- Converted crude rates from per million to per 100,000.
- Preserved special values (`Suppressed`, `Missing`, etc.).
- Standardized column names.
- Sorted rows and exported clean `.csv` files.

👉 See the script here: [`scripts/clean_incidence_data.R`](scripts/clean_incidence_data.R)

---

## 📊 Dashboard Features
- **U.S. Map** → National overview of pediatric cancer incidence.
- **Drill-down** → Select a state to view detailed trends.
- **Demographic tabs** → Breakdowns by Age Group, Sex, and Race.
- **Interactive tooltips** → Year-over-year trends, incidence counts, and crude rates.
- **KPI banners** → Compare state-level incidence to national averages.

---

## 🛠️ Tools Used
- **R** (tidyverse, janitor) – Data cleaning and preprocessing  
- **Tableau** – Interactive dashboard creation  
- **Git & GitHub** – Version control and portfolio hosting  

---

## 📌 About
This project was completed as part of my **Google Data Analytics Capstone**.  
It demonstrates skills in data cleaning, analysis, and visualization, and provides a foundation for healthcare-focused analytics work.

Author: **Josh Fugate**  
📧 [joshua.fugate@outlook.com](mailto:joshua.fugate@outlook.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/josh-fugate/)

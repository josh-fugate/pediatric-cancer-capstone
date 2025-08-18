# ----------------------------------------------
# Pediatric Cancer Capstone - CDC WONDER Dataset
# Script: clean_incidence_data.R
# Purpose:
# Clean and standardize raw pediatric cancer incidence CSVs from CDC WONDER.
# - Drop unused metadata columns (e.g., *_code, Notes)
# - Convert crude rate from per million to per 100,000
#     - Preserve special string values like "Suppressed", "Missing", "Not Applicable"
# - Rename and standardize column names
# - Apply consistent row sorting (Cancer Site, Year, State, etc.)
# - Save cleaned files to the /clean/ folder
# Author: Josh Fugate
# Date: 07/28/2025
# ----------------------------------------------

library(tidyverse)
library(janitor)

raw_folder   <- "data/incidence/raw"
clean_folder <- "data/incidence/clean"
files <- list.files(raw_folder, pattern = "\\.txt$", full.names = TRUE)

# Clean each raw file
for (path in files) {
  df <- read_tsv(path, show_col_types = FALSE) %>%
    clean_names()
  
  # Rename key columns if they exist
  if ("childhood_cancers" %in% names(df)) df <- rename(df, cancer_site = childhood_cancers)
  if ("states" %in% names(df)) df <- rename(df, state = states)
  if ("age_groups" %in% names(df)) df <- rename(df, age_group = age_groups)

  # Drop metadata columns
  df <- select(df, -any_of(c("notes", "states_code", "year_code", "sex_code", "age_groups_code", "race_code")))
  
  # Convert crude rate to per 100k 
  df <- df %>%
    mutate(crude_rate_text = as.character(crude_rate)) %>%
    mutate(rate_num = suppressWarnings(as.numeric(crude_rate_text))) %>%
    
    mutate(
      crude_rate_100k = ifelse(
        !is.na(rate_num),
        as.character(rate_num * 0.1),
        crude_rate_text
      )
    ) %>%
    select(-crude_rate_text, -rate_num) %>%
    relocate(crude_rate_100k, .after = crude_rate)
  
  # Sort rows
  sort_cols <- intersect(
    c("childhood_cancers_code", "year", "state", "sex", "age_group", "race"),
    names(df)
  )
  
  df <- df %>%
    arrange(across(all_of(sort_cols))) %>%
    select(-any_of("childhood_cancers_code"))
  
  # Write cleaned CSV
  output_name <- basename(path) %>% str_replace("\\.txt$", ".csv")
  write_csv(df, file.path(clean_folder, output_name))
}
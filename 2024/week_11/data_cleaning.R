## Challenge: #B2VB 2024 week 11
## Data:      Use Color Purposefully
## Author:    Steven Ponce
## Date:      2024-05-28

## Data:      https://data.world/back2vizbasics/2024week-11-use-color-purposefully


## 1. LOAD PACKAGES & SETUP ----  
pacman::p_load(
  tidyverse,   # Easily Install and Load the 'Tidyverse'
  ggtext,      # Improved Text Rendering Support for 'ggplot2'
  showtext,    # Using Fonts More Easily in R Graphs
  janitor,     # Simple Tools for Examining and Cleaning Dirty Data
  skimr,       # Compact and Flexible Summaries of Data
  scales,      # Scale Functions for Visualization
  lubridate,   # Make Dealing with Dates a Little Easier
  MetBrewer,   # Color Palettes Inspired by Works at the Metropolitan Museum of Art
  MoMAColors,  # Color Palettes Inspired by Artwork at the Museum of Modern Art in New York City
  glue         # Interpreted String Literals
)

### |- figure size ---- 
camcorder::gg_record( 
  dir    = here::here("temp_plots"), 
  device = "png",
  width  =  6,
  height =  7.5,
  units  = "in",
  dpi    = 320) 

### |- resolution ---- 
showtext_opts(dpi = 320, regular.wt = 300, bold.wt = 800)


## 2. READ IN THE DATA ----
tdi_raw_data <- read_csv('../BACK 2 VIZ BASICS/2024/week_11/2024 World Economic Forum Travel & Tourism Development Index.csv') |> 
  clean_names() |> glimpse()


## 3. EXAMINING THE DATA ----
glimpse(tdi_raw_data )
colnames(tdi_raw_data)


## 4. TIDYDATA ----

### |- tidy data ---

tdi_longer_df <- tdi_raw_data |>
  pivot_longer(
    cols = starts_with("x"),
    names_to = c("year", "type"),
    names_pattern = "x(\\d{4})_(.*)"
    ) |>
  pivot_wider(names_from = type, values_from = value) |> 
  rename(index_average = value, rank = rank) |>
  arrange(year, desc(index_average))


## 5. SAVE ----

write_csv(
  x = tdi_longer_df,
  file = "2024/week_11/tdi_longer.csv"
  )

library(shiny)
library(dplyr)
library(DT)
library(lubridate)
library(tidyr)

ui <- fluidPage(
  titlePanel("SQL Logic Demo – Proper Snapshot Counts"),

  tabsetPanel(
    tabPanel("1️⃣ Raw Snapshot Data", DTOutput("raw")),
    tabPanel("2️⃣ Count per Snapshot", DTOutput("count_snapshot")),
    tabPanel("3️⃣ Daily Average Count", DTOutput("daily_avg")),
    tabPanel("4️⃣ Final (Last 5 Dates per Plant)", DTOutput("final"))
  )
)

server <- function(input, output, session) {

  set.seed(123)

  # -------------------------------------------------
  # STEP 1: Create Realistic Snapshot Data
  # -------------------------------------------------

  plants <- c("02", "06")

  snapshots <- seq.POSIXt(
    as.POSIXct("2026-02-01 08:00"),
    by = "12 hours",
    length.out = 15
  )

  # For each division & snapshot, generate multiple materials
  raw_data <- expand.grid(
    division = plants,
    date_time_snap = snapshots
  ) %>%
    rowwise() %>%
    mutate(
      material_count = sample(10:20, 1),  # random number of materials per snapshot
      item_list = list(sample(100:125, material_count))
    ) %>%
    unnest(item_list) %>%
    rename(MATL_NUM = item_list) %>%
    select(division, date_time_snap, MATL_NUM) %>%
    ungroup()

  output$raw <- renderDT(raw_data)


  # -------------------------------------------------
  # STEP 2: Count items per plant per snapshot
  # (SQL equivalent: COUNT(item))
  # -------------------------------------------------

  count_snapshot <- raw_data %>%
    group_by(division, date_time_snap) %>%
    summarise(cnt = n(), .groups = "drop")

  output$count_snapshot <- renderDT(count_snapshot)


  # -------------------------------------------------
  # STEP 3: Daily average per plant
  # (SQL: DATE_FORMAT + AVG(cnt))
  # -------------------------------------------------

  daily_avg <- count_snapshot %>%
    mutate(datem = as.Date(date_time_snap)) %>%
    group_by(division, datem) %>%
    summarise(avg_matl_count = round(mean(cnt)), .groups = "drop")

  output$daily_avg <- renderDT(daily_avg)


  # -------------------------------------------------
  # STEP 4: Rank latest 5 dates per plant
  # (SQL: ROW_NUMBER() OVER PARTITION BY ...)
  # -------------------------------------------------

  final_data <- daily_avg %>%
    arrange(division, desc(datem)) %>%
    group_by(division) %>%
    mutate(rn = row_number()) %>%
    filter(rn <= 10) %>%
    ungroup()

  output$final <- renderDT(final_data)
}

shinyApp(ui, server)
library(shiny)
library(dplyr)
library(DT)

original_data <- data.frame(
  REGION_NAME = c("North Zone", "East Zone", "West Zone"),
  CLUB_NAME = c("Science Club", "Art Club", "Music Club"),
  SUBJECT = c("Math", "History", "Physics"),
  TOTAL_MARKS = c(80, 75, 90),
  MAX_MARKS = c(100, 100, 100)
)

ui <- fluidPage(

  titlePanel("Learning dplyr::rename() with Clean Layout"),

  sidebarLayout(

    sidebarPanel(

      fluidRow(
        column(12,
               actionButton("reset", "Reset Data")
        )
      ),

      br(),

      fluidRow(
        column(12,
               actionButton("step1", "Step 1: Rename REGION_NAME → HOME_AREA")
        )
      ),

      br(),

      fluidRow(
        column(12,
               actionButton("step2", "Step 2: Rename CLUB_NAME → REGION_NAME + Calculate %", style = "display: ")
        )
      )

    ),

    mainPanel(

      fluidRow(
        column(12,
               h3("Current Dataset"),
               DTOutput("table")
        )
      ),

      hr(),

      fluidRow(
        column(12,
               h4("Learning Explanation"),
               verbatimTextOutput("notes")
        )
      )

    )
  )
)

server <- function(input, output, session) {



  current_data <- reactiveVal(original_data)

  observeEvent(input$reset, {
    current_data(original_data)
  })

  observeEvent(input$step1, {
    df <- current_data() %>%
      rename(HOME_AREA = REGION_NAME)
    current_data(df)
  })

  observeEvent(input$step2, {
    df <- current_data() %>%
      rename(REGION_NAME = CLUB_NAME) %>%
      mutate(PERCENTAGE = TOTAL_MARKS / MAX_MARKS)
    current_data(df)
  })

  output$table <- renderDT({
    datatable(current_data(), options = list(pageLength = 5))
  })

  output$notes <- renderPrint({
    cat("rename(new_name = old_name) changes only the column label.\n")
    cat("Values remain unchanged.\n\n")
    cat("Sequential rename means:\n")
    cat("Step 1: REGION_NAME becomes HOME_AREA.\n")
    cat("Step 2: CLUB_NAME becomes new REGION_NAME.\n\n")
    cat("mutate() creates calculated columns like PERCENTAGE.\n")
  })
}

shinyApp(ui, server)
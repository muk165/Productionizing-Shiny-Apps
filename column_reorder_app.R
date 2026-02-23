library(shiny)
library(bslib)
library(DT)
library(sortable)

ui <- page_sidebar(
  title = "Column Reorder App",
  sidebar = sidebar(
    fileInput("file", "Upload CSV File",
              accept = c(".csv", ".txt")),
    hr(),
    helpText("Drag and drop column names below to reorder them"),
    uiOutput("column_order_ui"),
    hr(),
    downloadButton("download", "Download Reordered Data")
  ),
  card(
    card_header("Data Preview"),
    DTOutput("preview")
  ),
  card(
    card_header("Column Order"),
    verbatimTextOutput("current_order")
  )
)

server <- function(input, output, session) {
  # Reactive value to store uploaded data
  data <- reactiveVal(NULL)

  # Reactive value to store column order
  col_order <- reactiveVal(NULL)

  # Read uploaded file
  observeEvent(input$file, {
    req(input$file)
    df <- read.csv(input$file$datapath, stringsAsFactors = FALSE)
    data(df)
    col_order(names(df))
  })

  # Create sortable column list
  output$column_order_ui <- renderUI({
    req(col_order())

    rank_list(
      text = "Drag to reorder columns:",
      labels = col_order(),
      input_id = "column_rank",
      options = sortable_options(
        onSort = sortable_js_capture_input(input_id = "column_rank")
      )
    )
  })

  # Update column order when user reorders
  observeEvent(input$column_rank, {
    req(input$column_rank)
    col_order(input$column_rank)
  })

  # Get reordered data
  reordered_data <- reactive({
    req(data(), col_order())
    data()[, col_order(), drop = FALSE]
  })

  # Display data preview
  output$preview <- renderDT({
    req(reordered_data())
    datatable(
      reordered_data(),
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })

  # Display current column order
  output$current_order <- renderText({
    req(col_order())
    paste("Current order:", paste(col_order(), collapse = " -> "))
  })

  # Download reordered data
  output$download <- downloadHandler(
    filename = function() {
      paste0("reordered_data_", Sys.Date(), ".csv")
    },
    content = function(file) {
      req(reordered_data())
      write.csv(reordered_data(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui, server)

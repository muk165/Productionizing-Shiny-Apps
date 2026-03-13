library(shiny)

dataset_objects <- ls("package:datasets")

dataframe_datasets <- dataset_objects[
  sapply(dataset_objects, function(x) {
    is.data.frame(get(x, "package:datasets"))
  })
]

# -----------------------------
# Module UI
# -----------------------------
datasetModuleUI <- function(id) {

  ns <- NS(id)

  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(
          ns("dataset"),
          "Select Dataset",
          choices = dataframe_datasets
        )
      ),
      mainPanel(
        tableOutput(ns("columns_table"))
      )
    )
  )
}

# -----------------------------
# Module Server
# -----------------------------
datasetModuleServer <- function(id) {

  moduleServer(id, function(input, output, session) {

    # reactive dataset
    dataset_reactive <- reactive({
      get(input$dataset, "package:datasets")
    })

    # table of column names
    output$columns_table <- renderTable({
      data.frame(
        ColumnNames = names(dataset_reactive())
      )
    })

  })
}

# -----------------------------
# Main UI
# -----------------------------
ui <- fluidPage(

  titlePanel("Modular Dataset Explorer"),
  datasetModuleUI("dataset_module")

)

# -----------------------------
# Main Server
# -----------------------------
server <- function(input, output, session) {

  datasetModuleServer("dataset_module")

}

shinyApp(ui, server)
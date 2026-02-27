library(shiny)

ui <- fluidPage(

  tags$head(
    tags$style(HTML("
      body { background-color: #f5f7fa; }
      .card {
        background: white;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        margin-bottom: 20px;
      }
      h3 { color: #2c3e50; }
    "))
  ),

  titlePanel("renderText() vs renderPrint() Demo"),

  fluidRow(
    column(6,
           div(class="card",
               h3("renderText() + textOutput()"),
               textOutput("text_style")
           )
    ),

    column(6,
           div(class="card",
               h3("renderPrint() + verbatimTextOutput()"),
               verbatimTextOutput("print_style")
           )
    )
  )
)

server <- function(input, output) {

  sample_object <- reactive({
    list(
      Sales_Org = c("BE01", "IT02", "FR03"),
      Material = "MAT123",
      Quantity = 150
    )
  })

  # renderText requires manual conversion
  output$text_style <- renderText({
    paste(capture.output(str(sample_object())), collapse = "\n")
  })

  # renderPrint prints object directly
  output$print_style <- renderPrint({
    sample_object()
  })
}

shinyApp(ui, server)
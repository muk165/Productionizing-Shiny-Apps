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
    column(4,
           div(class="card",
               h3("renderText() + textOutput()"),
               textOutput("text_style")
           )
    ),

    column(4,
           div(class="card",
               h3("renderPrint() + verbatimTextOutput()"),
               verbatimTextOutput("print_style")
           )
    ),

    column(4,
           div(class="card",
               h3("renderPrint() + textOutput() (Mismatch)"),
               textOutput("mismatch_style")
           )
    )
  )
)

server <- function(input, output) {

  sample_object <- reactive({
    list(
      Sales_Org = c("12A", "13b", "11C"),
      Material = "MAT123",
      Quantity = 150
    )
  })

  # 1️⃣ Simple text rendering
  output$text_style <- renderText({
    sample_object()
    # browser()
  })

  # 2️⃣ Proper console-style rendering
  output$print_style <- renderPrint({
    sample_object()
  })

  # 3️⃣ Intentional mismatch
  output$mismatch_style <- renderPrint({
    sample_object()
  })
}

shinyApp(ui, server)
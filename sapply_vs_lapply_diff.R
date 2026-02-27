library(shiny)
library(stringr)

ui <- fluidPage(

  tags$head(
    tags$style(HTML("
      body { background-color: #f4f6f9; }
      .box {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        margin-bottom: 20px;
      }
      h2 { color: #2c3e50; }
    "))
  ),

  titlePanel("Understanding sapply() Visually"),

  fluidRow(
    column(6,
           div(class="box",
               h3("Input Data"),
               textAreaInput("input_text",
                             "Enter comma separated groups (use | to separate rows)",
                             value = "we12 , qw02 | IN03, ge | @12",
                             rows = 3),
               actionButton("process", "Apply sapply()",
                            class = "btn-primary")
           )
    ),

    column(6,
           div(class="box",
               h3("What str_split() Produces (List)"),
               verbatimTextOutput("list_output")
           )
    )
  ),

  fluidRow(
    column(6,
           div(class="box",
               h3("Result Using lapply()"),
               verbatimTextOutput("lapply_output")
           )
    ),

    column(6,
           div(class="box",
               h3("Result Using sapply()"),
               verbatimTextOutput("sapply_output")
           )
    )
  )
)

server <- function(input, output) {

  observeEvent(input$process, {

    rows <- str_split(input$input_text, "\\|")[[1]]
    rows <- str_trim(rows)

    split_list <- str_split(rows, ",\\s*")

    output$list_output <- renderPrint({
      split_list
    })

    output$lapply_output <- renderPrint({
      lapply(split_list, function(x) {
        cleaned <- str_replace_all(x, "\\d+", "")
        paste(unique(cleaned), collapse=", ")
      })
    })

    output$sapply_output <- renderPrint({
      sapply(split_list, function(x) {
        cleaned <- str_replace_all(x, "\\d+", "")
        paste(unique(cleaned), collapse=", ")
      })
    })

  })
}

shinyApp(ui, server)
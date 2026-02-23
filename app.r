source("my_global.R")


ui <- fluidPage(

  titlePanel("Shiny Grid: Offset & Column Width Demo"),

  # Example 1: Two equal columns
  h3("Example 1: width = 6 + width = 6"),
  fluidRow(
    column(6, style="background-color:lightblue; padding:20px;",
           "Column width = 6 (50%)"),
    column(6, style="background-color:lightgreen; padding:20px;",
           "Column width = 6 (50%)")
  ),

  br(),

  # Example 2: Offset example
  h3("Example 2: width = 4 with offset = 4"),
  fluidRow(
    column(4, offset = 4,
           style="background-color:orange; padding:20px;",
           "Centered column using offset = 4")
  ),

  br(),

  # Example 3: Unequal layout
  h3("Example 3: width = 3 + width = 9"),
  fluidRow(
    column(3, style="background-color:pink; padding:20px;",
           "Column width = 3"),
    column(9, style="background-color:lightgray; padding:20px;",
           "Column width = 9")
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
library(shiny)
library(DT)

ui <- fluidPage(

  titlePanel("DT Proxy vs Full Re-render Demo"),

  fluidRow(
    column(6,
           h4("❌ Full Re-render Table"),
           DTOutput("table_full"),
           actionButton("update_full", "Update (Re-render)")
    ),

    column(6,
           h4("✅ Proxy Update Table"),
           DTOutput("table_proxy"),
           actionButton("update_proxy", "Update (Proxy)")
    )
  )
)

server <- function(input, output, session) {

  # Initial Data
  base_data <- reactiveVal(
    data.frame(
      ID = 1:10,
      Value = sample(1:100, 10)
    )
  )

  # -------- Full Re-render Table --------

  output$table_full <- renderDT({
    datatable(base_data(), options = list(pageLength = 5))
  })

  observeEvent(input$update_full, {
    new_data <- data.frame(
      ID = 1:10,
      Value = sample(1:100, 10)
    )
    base_data(new_data)   # This forces full re-render
  })


  # -------- Proxy Table --------

  output$table_proxy <- renderDT({
    datatable(base_data(), options = list(pageLength = 5))
  })

  proxy <- dataTableProxy("table_proxy")

  observeEvent(input$update_proxy, {
    new_data <- data.frame(
      ID = 1:10,
      Value = sample(1:100, 10)
    )

    replaceData(
      proxy = proxy,
      data = new_data,
      resetPaging = FALSE,
      rownames = FALSE
    )
  })

}

shinyApp(ui, server)
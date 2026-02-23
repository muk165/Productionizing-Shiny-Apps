📊 Shiny Learning Lab

A structured collection of Shiny concepts, experiments, and layout demonstrations built while mastering R Shiny development.

This repository is focused on understanding Shiny fundamentals deeply — from layout systems to reactive programming and dashboard structuring.

🚀 Purpose of This Repository

Learn Shiny systematically

Experiment with layout controls (width, offset, grid system)

Practice UI structuring

Build intuition for dashboard design

Create reusable mini examples

This repo will evolve as new concepts are explored.

📂 Current Topics Covered
1️⃣ Shiny Grid System – Width & Offset

Understanding Bootstrap’s 12-column layout system in Shiny.

Concepts Covered:

fluidRow()

column(width = )

offset =

Grid behavior when total width > 12

Examples Included:

6 + 6 column split

Centered column using offset

3 + 9 uneven layout

🧠 Key Learning Notes

Shiny uses a 12-column Bootstrap grid.

width defines how many units a column takes.

offset adds empty spacing before a column.

If total width in a row exceeds 12, layout wraps to next line.

Proper layout planning improves dashboard readability.

🛠️ Tech Stack

R

Shiny

Bootstrap (via Shiny grid system)

📌 How to Run
install.packages("shiny")
library(shiny)

# Open the specific app file
shinyApp(ui, server)

Or run from RStudio:

Run App
🔮 Upcoming Topics (Planned Additions)

Reactive expressions

observe vs observeEvent

isolate()

Modules

Dynamic UI

shinydashboard

bslib layouts

Theming

CSS customization

Performance optimization

Deployment (shinyapps.io / Posit Connect)

📈 Long-Term Vision

This repository will gradually become:

A personal Shiny knowledge base

A reference library of mini examples

A showcase of structured dashboard thinking

A foundation for production-level Shiny applications

👨‍💻 Author

Muktesh
R Shiny Developer | Statistical Programmer

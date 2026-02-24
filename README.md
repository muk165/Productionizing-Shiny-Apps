Shiny Learning Lab
================
Muktesh

- [📊 Shiny Learning Lab](#-shiny-learning-lab)
- [📌 About This Repository](#-about-this-repository)
  - [Goals](#goals)
- [🧱 Shiny Grid System: Width &
  Offset](#-shiny-grid-system-width--offset)
  - [🔹 Column Width Example](#-column-width-example)

# 📊 Shiny Learning Lab

> A structured journey to mastering **R Shiny** — from layout
> fundamentals to advanced reactive architecture.

------------------------------------------------------------------------

# 📌 About This Repository

This repository documents hands-on learning and experiments while
building strong intuition in Shiny development.

## Goals

- Understand Bootstrap 12-grid system
- Master layout engineering (width & offset)
- Build strong reactive fundamentals
- Develop clean dashboard structuring practices

------------------------------------------------------------------------

# 🧱 Shiny Grid System: Width & Offset

Shiny uses a **12-column Bootstrap grid system**.

Each `fluidRow()` can contain columns whose total width equals **12**.

------------------------------------------------------------------------

## 🔹 Column Width Example

\`\`\`{r width-example, echo=TRUE} library(shiny)

fluidPage( fluidRow( column(6, “Column width = 6”), column(6, “Column
width = 6”) ) )

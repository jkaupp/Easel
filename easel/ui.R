library(shiny)
library(shinyAce)

shinyUI(fluidPage(
  includeCSS("normalize.css"),
  includeCSS("skeleton.css"),

  # Application title
  titlePanel("Easel: Supporting Educational Data Visualization"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width = 3,
       selectInput("level_one",
                   "Are you looking at data from students or questions regarding curriculum?",
                   list("", "Students" = "students", "Curriculum" = "curriculum")),
       uiOutput("level_two"),
       uiOutput("level_three"),
       uiOutput("level_four")
    ),


    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(column(12, list(uiOutput("plot_title"), plotOutput("chart")))),
      fluidRow(column(6, htmlOutput("code_output")),
               column(6, uiOutput("desc")))


    )
  )
))

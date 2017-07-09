library(shiny)
library(shinyAce)

shinyUI(fluidPage(
  includeCSS(file.path("css", "normalize.css")),
  includeCSS(file.path("css", "skeleton.css")),

  # Application title
  titlePanel("Easel: Supporting Educational Data Visualization"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width = 3,
       selectInput("level_one",
                   "Do you have some idea of what you are looking for or just have data?",
                   list("", "I have some idea of what I am looking for" = "G1", "I just have data" = "G2")),
       uiOutput("level_two"),
       uiOutput("level_three"),
       uiOutput("level_four"),
       uiOutput("level_five")
    ),


    # Show a plot of the generated distribution
    mainPanel(tabsetPanel(
      tabPanel("Plot", plotOutput("chart")),
      tabPanel("Code", htmlOutput("code_output")),
      tabPanel("Description", uiOutput("desc"))
      )

  )
  )
))

library(shiny)

shinyUI(fluidPage(
  includeCSS("normalize.css"),
  includeCSS("skeleton.css"),

  # Application title
  titlePanel("Easel: Supporting Educational Data Visualization"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       selectInput("level_one",
                   "Are you looking at data from students or questions regarding curriculum?",
                   list("", "Students" = 21, "Curriculum" = 22)),
       uiOutput("level_two"),
       uiOutput("level_three"),
       uiOutput("level_four")
    ),


    # Show a plot of the generated distribution
    mainPanel(

    )
  )
))

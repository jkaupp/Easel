library(shinyjs)
library(shinyAce)
library(shiny)
library(ggplot2)
library(googlesheets)
library(dplyr)
library(purrr)


shinyUI(
  tagList(
    useShinyjs(),
    includeCSS(file.path("css", "normalize.css")),
    includeCSS(file.path("css", "skeleton.css")),

    div(
      id = "loading-content",
      h2("Loading...")
    ),

    hidden(
      div(
        id = "app-content",
  navbarPage(div(img(
    src = "Easel.svg",
    height = 50,
    style = "margin:-15px 0"
  )), windowTitle = "Easel: Supporting Educational Data Visualization",


   tabPanel("Instructions",
            mainPanel(includeMarkdown(file.path("data", "instructions.md"))), icon = icon("map-o")),
   tabPanel("Easel",

      sidebarLayout(
        sidebarPanel(id = "sidebar", width = 3,
                     #textOutput("debug"),
                     selectInput("level_one",
                                 "Do you have some idea of what you are looking for or just have data?",
                                 list("", "I have some idea of what I am looking for" = "G1", "I just have data" = "G2")),
                     uiOutput("level_two"),
                     uiOutput("level_three"),
                     uiOutput("level_four"),
                     uiOutput("level_five"),
                     uiOutput("level_six"),
                     uiOutput("level_seven"),
                     actionButton("reset", "Reset Choices")
        ),



        mainPanel(tabsetPanel(id = "outputs",
          tabPanel("Plot", list(plotOutput("chart"), uiOutput("desc"))),
          tabPanel("Code", htmlOutput("code_output")),
          tabPanel("Data", DT::dataTableOutput("data"))
        )
        )
      ), icon = icon("paint-brush")
    ),
  tabPanel("Selection Process", includeMarkdown(file.path("data", "selection.md")), icon = icon("clipboard"))
  

)
    )
  )
))



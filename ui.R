library(shiny)
library(shinyAce)
library(shinyjs)

loading <- c("640K ought to be enough for anybody", "the architects are still drafting", "the bits are breeding", "we\'re building the buildings as fast as we can", "would you prefer chicken, steak, or tofu?", "pay no attention to the man behind the curtain", "and enjoy the elevator music", "while the little elves draw your map", "a few bits tried to escape, but we caught them", "and dream of faster computers", "would you like fries with that?", "checking the gravitational constant in your locale", "go ahead -- hold your breath", "at least you\'re not on hold", "hum something loud while others stare", "you\'re not in Kansas any more", "the server is powered by a lemon and two electrodes", "we love you just the way you are", "while a larger software vendor in Seattle takes over the world", "we\'re testing your patience", "as if you had any other choice", "take a moment to sign up for our lovely prizes", "don\'t think of purple hippos", "follow the white rabbit", "why don\'t you order a sandwich?", "while the satellite moves into position", "the bits are flowing slowly today", "dig on the \'X\' for buried treasure... ARRR!", "it\'s still faster than you could draw it", "Do you suffer from ADHD? Me neith- oh look a bunny... What was I doing again? Oh, right. Here we go.", "The last time I tried this the monkey didn\'t survive. Let\'s hope it works better this time.", "Testing data on Timmy... ... ... We\'re going to need another Timmy.", "I should have had a V8 this morning.", "My other load screen is much faster. You should try that one instead.", "The version I have of this in testing has much funnier load screens.")


shinyUI(fluidPage(useShinyjs(),
  includeCSS(file.path("css", "normalize.css")),
  includeCSS(file.path("css", "skeleton.css")),

  # Loading message
  div(
    id = "loading-content",
    h2(sprintf("Loading... %s", loading[round(runif(1, 1, length(loading)))]))
  ),


  hidden(
    div(
      id = "app-content",

      tags$div(class = "header", tagList(tags$span(" Easel", class = "title"), tags$span(": Supporting Educational Data Visualization", class = "subtitle"))),


      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(id = "sidebar", width = 3,
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
    )
  )



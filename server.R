library(shinyAce)
library(shiny)
library(ggplot2)
library(googlesheets)
library(dplyr)
library(purrr)
library(shinyjs)
library(DT)
library(reshape2)

source("functions.R")

framework <- gs_key("1PF3TLyzURiaRKnllkrWpiQQfpQ1hBxK0gR8AaLKZEKE") %>%
  gs_read(ws = "application")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  # On load:
  level_flag <- reactiveVal(1)

  plot_flag <- reactiveVal(FALSE)
  hide("outputs")

  # Undo Button -------------
  observeEvent(input$reset, {

    plot_flag(FALSE)
    # Find label for current level and level above
    lvl_label <- levelLabel(level_flag())
    lvl_above_lbl <- levelLabel(level_flag(), 1)

    # Reset current level and level above
    reset(lvl_label)
    reset(lvl_above_lbl)

    # Find level above and enable all levels to current
    lvl_above_val <-  isolate(level_flag()) - 1
    walk(lvl_above_val:isolate(level_flag()), ~enable(levelLabel(.x)))

    # Change level flag and hide plot renders
    level_flag(lvl_above_val)
    hide("outputs")
  })


  # Level 2 ----
  output$level_two <- renderUI({

     lvl <- 2

    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {
    q2_data <- filter(framework,
                      level == lvl,
                      node_label == input[[labelAbove]])

    if (isolate(plot_flag() == FALSE)) {

      if (input[[labelAbove]] != "") {
        # Disable previous level and change flag
        disable(labelAbove)
        level_flag(lvl)

        plot_flag(q2_data[["terminal"]])

        options <- getOptions(q2_data)

        selectInput("level_two",
                    unique(q2_data[["description"]]),
                    options)
      }
    }
    }
  })

  # Level 3 ----
  output$level_three <- renderUI({

    lvl <- 3

    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {
      q3_data <- filter(framework,
                        level == lvl,
                        node_label == input[[labelAbove]])

      if (isolate(plot_flag() == FALSE)) {

        if (input[[labelAbove]] != "" ) {
          disable(labelAbove)
          level_flag(lvl)

          plot_flag(q3_data[["terminal"]])

          options <- getOptions(q3_data)

          selectInput("level_three",
                      unique(q3_data[["description"]]),
                      options)
        }
      }
    }
  })

  # Level 4 ----
  output$level_four <- renderUI({

    lvl <- 4

    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {
      q4_data <- filter(framework,
                        level == lvl,
                        node_label == input[[labelAbove]])

      if (isolate(plot_flag() == FALSE)) {

        if (input[[labelAbove]] != "" ) {
          disable(labelAbove)
          level_flag(lvl)

          plot_flag(q4_data[["terminal"]])

          options <- getOptions(q4_data)

          selectInput("level_four",
                      unique(q4_data[["description"]]),
                      options)
        }
      }
    }
  })

  # Level 5 ----
  output$level_five <- renderUI({

    lvl <- 5

    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {

      q5_data <- filter(framework,
                        level == lvl,
                        node_label == input[[labelAbove]])

      if (isolate(plot_flag() == FALSE)) {

        if (input[[labelAbove]] != "" ) {
          disable(labelAbove)
          level_flag(lvl)

          plot_flag(q5_data[["terminal"]])

          options <- getOptions(q5_data)

          selectInput("level_five",
                      unique(q5_data[["description"]]),
                      options)
        }
      }
    }
  })

  # Level 6 ----
  output$level_six <- renderUI({
    lvl <- 6
    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {

      q6_data <- filter(framework,
                        level == lvl,
                        node_label == input[[labelAbove]])

      if (isolate(plot_flag() == FALSE)) {

        if (input[[labelAbove]] != "" ) {
          disable(labelAbove)
          level_flag(lvl)

          plot_flag(q6_data[["terminal"]])

          options <- getOptions(q6_data)

          selectInput("level_six",
                      unique(q6_data[["description"]]),
                      options)
        }
      }
    }
  })

  # Level 7 ----
  output$level_seven <- renderUI({
    lvl <- 7
    labelAbove <- levelLabel(lvl,1)

    if (!is.null(input[[labelAbove]])) {

      q7_data <- filter(framework,
                        level == lvl,
                        node_label == input[[labelAbove]])

      if (isolate(plot_flag() == FALSE)) {

        if (input[[labelAbove]] != "" ) {
          disable(labelAbove)
          level_flag(lvl)

          plot_flag(q7_data[["terminal"]])

          options <- getOptions(q7_data)

          selectInput("level_seven",
                      unique(q7_data[["description"]]),
                      options)
        }
      }
    }
  })

  # Plot Renders ----------------------
  # Render Plot
  output$chart <- renderPlot({

    level <- levelLabel(level_flag())

    if (checkRender(input[[level]], isolate(plot_flag() == TRUE))) {
      show("outputs") # Show tabs

      # Find code
      plot_data <- sprintf("%s.R", input[[level]])
      plot <- source(file.path("plots", plot_data), local = TRUE)

      print(plot[["value"]]) # Execute code
    }
  })

  # Render Description
  output$desc <- renderUI({

    level <- levelLabel(level_flag())

    if (checkRender(input[[level]], isolate(plot_flag() == TRUE))) {
      md_file <- sprintf("%s.md", input[[level]]) # Find code

      includeMarkdown(file.path("data", md_file)) # Display description
    }
  })

  # Render Code
  output$code_output <- renderUI({

    level <- levelLabel(level_flag())

    if (checkRender(input[[level]], isolate(plot_flag() == TRUE))) {
      code <- sprintf("%s.R", input[[level]]) # Find code

      # Display code
      aceEditor("code",
                value = paste(readLines(file.path("plots", code)), collapse = "\n"),
                mode = "r",
                readOnly = TRUE,
                height = "600px")
    }
  })

  # Render Data
  output$data <- renderDataTable({

    level <- levelLabel(level_flag())

    if (checkRender(input[[level]], isolate(plot_flag() == TRUE))) {
      data <- readRDS(file.path("data", sprintf("%s.rds", input[[level]]))) # Find data

      DT::datatable(data,options = list(dom = "tp")) # Display data
    }
  })

  # On loading the app:
  hide(id = "loading-content", anim = TRUE, animType = "fade")
  show("app-content")

  # Debugging
  observeEvent(input$debugToggle, {

  })
  output$debug <- renderText(sprintf("Plot Flag = %s\nLevel Flag = %s", plot_flag(), level_flag()))

})


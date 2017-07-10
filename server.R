library(shiny)
library(ggplot2)
library(googlesheets)
library(shinyjs)
library(shinyAce)
library(feather)
library(dplyr)
library(purrr)

# framework2 <- readRDS(file.path("data", "framework.rds"))

framework <- gs_title("(17-06-20)DN") %>%
  gs_read(ws = "application")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

     plot_flag <- reactiveVal(FALSE)
     level_flag <- reactiveVal(1)

     output$level_two <- renderUI({

       level_flag(2)

       if (input$level_one != "") {

       q2_data <- filter(framework, level == 2, node_label == input$level_one)

       if (q2_data[["terminal"]]) {
         plot_flag(TRUE)
       }

       options <- if (!is.na(q2_data$node_targets)) {
         setNames(c("", unique(q2_data$node_targets) %>%
                      strsplit(",") %>%
                      flatten() %>%
                      map(trimws)), c("", unique(q2_data$options) %>%
                                        strsplit(",") %>%
                                        flatten() %>%
                                        map(trimws))) } else {
                                          setNames(c("", unique(q2_data$chart) %>%
                                                       strsplit(",") %>%
                                                       flatten() %>%
                                                       map(trimws)), c("", unique(q2_data$options) %>%
                                                                         strsplit(",") %>%
                                                                         flatten() %>%
                                                                         map(trimws)))
                                        }

       selectInput("level_two",
                   unique(q2_data$description),
                   options)

       }
     })

     output$level_three <- renderUI({

       level_flag(3)

       if (!is.null(input$level_two)) {

         if (input$level_two != "") {
         q3_data <- filter(framework, level == 3, node_label == input[["level_two"]])

         if (q3_data[["terminal"]]) {
           plot_flag(TRUE)
         }

         options <- if (!is.na(q3_data$node_targets)) {
           setNames(c("", unique(q3_data$node_targets) %>%
                        strsplit(",") %>%
                        flatten() %>%
                        map(trimws)), c("", unique(q3_data$options) %>%
                      strsplit(",") %>%
                      flatten() %>%
                        map(trimws))) } else {
                          setNames(c("", unique(q3_data$chart) %>%
                                       strsplit(",") %>%
                                       flatten() %>%
                                       map(trimws)), c("", unique(q3_data$options) %>%
                                                         strsplit(",") %>%
                                                         flatten() %>%
                                                         map(trimws)))
                      }

         selectInput("level_three",
                     unique(q3_data$description),
                     options) }
       }
     })


     output$level_four <- renderUI({

       level_flag(4)

       if (!is.null(input$level_three)) {

         if (input$level_three != "") {
           q4_data <- filter(framework, level == 4, node_label == input$level_three)

           if (q4_data[["terminal"]]) {
             plot_flag(TRUE)
           }

           options <- if (!is.na(q4_data$node_targets)) {
             setNames(c("", unique(q4_data$node_targets) %>%
                          strsplit(",") %>%
                          flatten() %>%
                          map(trimws)), c("", unique(q4_data$options) %>%
                                            strsplit(",") %>%
                                            flatten() %>%
                                            map(trimws))) } else {
                                              setNames(c("", unique(q4_data$chart) %>%
                                                           strsplit(",") %>%
                                                           flatten() %>%
                                                           map(trimws)), c("", unique(q4_data$options) %>%
                                                                             strsplit(",") %>%
                                                                             flatten() %>%
                                                                             map(trimws)))
                        }

           selectInput("level_four",
                       unique(q4_data$description),
                       options)


           }
       }
     })

     output$level_five <- renderUI({

       level_flag(5)

       if (!is.null(input$level_four)) {

         if (input$level_four != "") {
           q5_data <- filter(framework, level == 5, node_label == input$level_four)

           if (q5_data[["terminal"]]) {
             plot_flag(TRUE)
           }

           options <- if (!is.na(q5_data$node_targets)) {
             setNames(c("", unique(q5_data$node_targets) %>%
                          strsplit(",") %>%
                          flatten() %>%
                          map(trimws)), c("", unique(q5_data$options) %>%
                                            strsplit(",") %>%
                                            flatten() %>%
                                            map(trimws))) } else {
                                              setNames(c("", unique(q5_data$chart) %>%
                                                           strsplit(",") %>%
                                                           flatten() %>%
                                                           map(trimws)), c("", unique(q5_data$options) %>%
                                                                             strsplit(",") %>%
                                                                             flatten() %>%
                                                                             map(trimws)))
                                            }

           selectInput("level_five",
                       unique(q5_data$description),
                       options)


         }
       }
     })

    output$chart <- renderPlot({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five")

      if (!is.null(input[[level]])){

      if (plot_flag() & input[[level]] != "") {

        plot_data <- sprintf("%s.R", input[[level]])

        plot <- source(file.path("plots", plot_data), local = TRUE)

        print(plot$value)
      }
     }
    })


    output$code_output <- renderUI({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five")

      if (!is.null(input[[level]])) {

      if (plot_flag() & input[[level]] != "") {

         code <- sprintf("%s.R", input[[level]])

          list(tags$h2("Code"), aceEditor("code",
                    value = paste(readLines(file.path("plots", code)), collapse = "\n"),
                    mode = "r",
                    readOnly = TRUE,
                    height = "600px"))
        }
      }
    })

    output$desc <- renderUI({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five")

      if (!is.null(input[[level]])) {

      if (plot_flag() & input[[level]] != "") {

          md_file <- sprintf("%s.md", input$level_three)

          includeMarkdown(file.path("data", md_file))

        }
      }
    })

    # output$plot_title <- renderUI({
    #
    #   level <- switch(level_flag(), "level_one",
    #                   "level_two",
    #                   "level_three",
    #                   "level_four",
    #                   "level_five")
    #
    #     if (plot_flag() & input[[level]] != "") {
    #
    #       tags$h2(sprintf("%s Chart", tools::toTitleCase(input[[level]])))
    #
    #     }
    #
    # })
})

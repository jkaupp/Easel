library(shinyAce)
library(shiny)
library(ggplot2)
library(googlesheets)
library(dplyr)
library(purrr)
library(shinyjs)
library(DT)
library(reshape2)

framework <- gs_key("1PF3TLyzURiaRKnllkrWpiQQfpQ1hBxK0gR8AaLKZEKE") %>%
  gs_read(ws = "application")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

  observeEvent(input$reset, {

    lvl_label <- switch(level_flag(), "level_one",
                    "level_two",
                    "level_three",
                    "level_four",
                    "level_five",
                    "level_six",
                    "level_seven")

    lvl_above_lbl <- switch(level_flag() - 1, "level_one",
                    "level_two",
                    "level_three",
                    "level_four",
                    "level_five",
                    "level_six",
                    "level_seven")

    lvl_above_val <-  isolate(level_flag()) - 1



    reset(lvl_label)
    reset(lvl_above_label)

    walk(level_above_val:isolate(level_flag()), ~enable(switch(.x, "level_one",
                                       "level_two",
                                       "level_three",
                                       "level_four",
                                       "level_five",
                                       "level_six",
                                       "level_seven")))

    hide("outputs")
    level_flag(lvl_above_val)
    plot_flag(FALSE)
  })


     plot_flag <- reactiveVal(FALSE)
     level_flag <- reactiveVal(1)

     hide("outputs")

     output$level_two <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (input$level_one != "") {

         disable("level_one")
         level_flag(2)
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
     }
       })

     output$level_three <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (!is.null(input$level_two)) {

         if (input$level_two != "" ) {
           disable("level_two")
           level_flag(3)

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
       }
     })


     output$level_four <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (!is.null(input$level_three)) {

         if (input$level_three != "") {
           disable("level_three")
           level_flag(4)
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
       }
     })

     output$level_five <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (!is.null(input$level_four)) {

         if (input$level_four != "") {
           disable("level_four")
           level_flag(5)

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
       }
     })

     output$level_six <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (!is.null(input$level_five)) {

         if (input$level_five != "") {
           disable("level_five")
           level_flag(6)
           q6_data <- filter(framework, level == 6, node_label == input$level_five)

           if (q6_data[["terminal"]]) {
             plot_flag(TRUE)
           }

           options <- if (!is.na(q6_data$node_targets)) {
             setNames(c("", unique(q6_data$node_targets) %>%
                          strsplit(",") %>%
                          flatten() %>%
                          map(trimws)), c("", unique(q6_data$options) %>%
                                            strsplit(",") %>%
                                            flatten() %>%
                                            map(trimws))) } else {
                                              setNames(c("", unique(q6_data$chart) %>%
                                                           strsplit(",") %>%
                                                           flatten() %>%
                                                           map(trimws)), c("", unique(q6_data$options) %>%
                                                                             strsplit(",") %>%
                                                                             flatten() %>%
                                                                             map(trimws)))
                                            }

           selectInput("level_six",
                       unique(q6_data$description),
                       options)


         }
       }
       }
     })

     output$level_seven <- renderUI({

       if (isolate(plot_flag()) == FALSE) {

       if (!is.null(input$level_six)) {

         if (input$level_six != "") {
           disable("level_six")
           level_flag(7)

           q7_data <- filter(framework, level == 7, node_label == input$level_six)

           if (q7_data[["terminal"]]) {
             plot_flag(TRUE)
           }

           options <- if (!is.na(q7_data$node_targets)) {
             setNames(c("", unique(q7_data$node_targets) %>%
                          strsplit(",") %>%
                          flatten() %>%
                          map(trimws)), c("", unique(q7_data$options) %>%
                                            strsplit(",") %>%
                                            flatten() %>%
                                            map(trimws))) } else {
                                              setNames(c("", unique(q7_data$chart) %>%
                                                           strsplit(",") %>%
                                                           flatten() %>%
                                                           map(trimws)), c("", unique(q7_data$options) %>%
                                                                             strsplit(",") %>%
                                                                             flatten() %>%
                                                                             map(trimws)))
                                            }

           selectInput("level_seven",
                       unique(q7_data$description),
                       options)


         }
       }
       }
     })

    output$chart <- renderPlot({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five",
                      "level_six",
                      "level_seven")

      if (!is.null(input[[level]])) {

      if (isolate(plot_flag()) & input[[level]] != "") {

        show("outputs")

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
                      "level_five",
                      "level_six",
                      "level_seven")

      if (!is.null(input[[level]])) {

      if (isolate(plot_flag()) & input[[level]] != "") {

         code <- sprintf("%s.R", input[[level]])

          aceEditor("code",
                    value = paste(readLines(file.path("plots", code)), collapse = "\n"),
                    mode = "r",
                    readOnly = TRUE,
                    height = "600px")
        }
      }
    })

    output$data <- renderDataTable({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five",
                      "level_six",
                      "level_seven")

      if (!is.null(input[[level]])) {

      if (isolate(plot_flag()) & input[[level]] != "") {

          data <- readRDS(file.path("data", sprintf("%s.rds", input[[level]])))

          DT::datatable(data,options = list(dom = "tp"))


        }
      }
    })

    output$desc <- renderUI({

      level <- switch(level_flag(), "level_one",
                      "level_two",
                      "level_three",
                      "level_four",
                      "level_five",
                      "level_six",
                      "level_seven")

      if (!is.null(input[[level]])) {

        if (isolate(plot_flag()) & input[[level]] != "") {

          md_file <- sprintf("%s.md", input[[level]])

          includeMarkdown(file.path("data", md_file))

        }
      }
    })


    output$debug <- renderText(sprintf("Plot Flag = %s\nLevel Flag = %s", plot_flag(), level_flag()))

    hide(id = "loading-content", anim = TRUE, animType = "fade")
    show("app-content")

})

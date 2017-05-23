library(shiny)
library(ggplot2)
library(shinyjs)
library(shinyAce)
library(feather)

framework <- read_feather("framework.feather")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

     plot_flag <- reactiveVal(FALSE)
     level_flag <- reactiveVal()
     selection_flag <- reactiveVal()

     output$level_two <- renderUI({

       level_flag(2)

       if (input$level_one != "") {

       q2_data <- filter(framework, level == 2, node_label == input$level_one)

       selectInput("level_two",
                   unique(q2_data$description),
                   setNames(c("", unique(q2_data$node_targets) %>%
                     strsplit(",") %>%
                     flatten() %>%
                       map(trimws)), c("",unique(q2_data$options) %>%
                       strsplit(",") %>%
                       flatten() %>%
                         map(trimws)))) }
     })

     output$level_three <- renderUI({

       level_flag(3)

       if (!is.null(input$level_two)) {

         if (input$level_two != "") {
         q3_data <- filter(framework, level == 3, node_label == input$level_two)

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

       if (!is.null(input$level_three) && !plot_flag()) {

         if (input$level_three != "") {
           q4_data <- filter(framework, level == 4, node_label == input$level_three)

           options <- if (!is.na(q4_data$node_targets)) {
             setNames(unique(q4_data$node_targets) %>%
                        strsplit(",") %>%
                        flatten() %>%
                        map(trimws), unique(q4_data$options) %>%
                        strsplit(",") %>%
                        flatten() %>%
                        map(trimws)) } else {
                          unique(q4_data$options) %>%
                            strsplit(",") %>%
                            flatten() %>%
                            map(trimws)
                        }

           selectInput("level_four",
                       unique(q4_data$description),
                       options)


           }
       }
     })

    output$chart <- renderPlot({

      if (!is.null(input$level_three)) {

      if (plot_flag() && input$level_three != "") {

        plot_data <- sprintf("%s.R", input$level_three)

        plot <- source(plot_data, local = TRUE)

        print(plot$value)
      }}

    })


    output$code_output <- renderUI({

      if (!is.null(input$level_three)) {

        if (plot_flag() && input$level_three != "") {

         code <- sprintf("%s.R", input$level_three)

          list(tags$h2("Code"), aceEditor("code",
                    value = paste(readLines(code), collapse = "\n"),
                    mode = "r",
                    readOnly = TRUE,
                    height = "150px"))
        }
      }

    })

    output$desc <- renderUI({

      if (!is.null(input$level_three)) {

        if (plot_flag() && input$level_three != "") {

          md_file <- sprintf("%s.md", input$level_three)

          includeMarkdown(md_file)

        }}

    })

    output$plot_title <- renderUI({

      if (!is.null(input$level_three)) {

        if (plot_flag() && input$level_three != "") {

          tags$h2(sprintf("%s Chart", tools::toTitleCase(input$level_three)))

        }}

    })
})

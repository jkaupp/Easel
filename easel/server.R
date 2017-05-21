library(shiny)
library(shinyjs)
library(feather)

framework <- read_feather("framework.feather")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

     output$level_two <- renderUI({

       if (input$level_one != "") {

       q2_data <- filter(framework, level == 2, code == input$level_one)

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

       if (!is.null(input$level_two)) {

         if (input$level_two != "") {
         q3_data <- filter(framework, level == 3, node_label == input$level_two)

         options <- if (!is.na(q3_data$node_targets)) {
           setNames(c("", unique(q3_data$node_targets) %>%
                        strsplit(",") %>%
                        flatten() %>%
                        map(trimws)), c("", unique(q3_data$options) %>%
                      strsplit(",") %>%
                      flatten() %>%
                        map(trimws))) } else {
                        c("", unique(q3_data$options) %>%
                          strsplit(",") %>%
                          flatten() %>%
                            map(trimws))
                      }

         selectInput("level_three",
                     unique(q3_data$description),
                     options) }
       }
     })


     output$level_four <- renderUI({

       if (!is.null(input$level_three)) {

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
                       options) }
       }
     })

})

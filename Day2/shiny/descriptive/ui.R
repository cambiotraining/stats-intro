# This app provides a simple demonstration of various descriptive statistics.
# (UI-side code)
# written by Aaron Lun
# 12 November 2016

library(shiny)
plot.width <- 6

pageWithSidebar(
                headerPanel("Descriptive statistics", "Ramen eaten per year"),
                sidebarPanel(width=2,
                             actionButton("resample", "Add person"), br(), br(),
                             actionButton("outlier", "Add student"), br(), br(),
                             actionButton("reset", "Reset")
                             ),
                mainPanel(
                          fluidRow(column(width = 8, verbatimTextOutput("text_all")),
                                   column(width = 4, 
                                          h5("Sample mean:"),
                                          verbatimTextOutput("text_mean"),
                                          h5("Sample standard deviation:"),
                                          verbatimTextOutput("text_sd"),
                                          h5("Median:"),
                                          verbatimTextOutput("text_med"),
                                          h5("1st quartile"),
                                          verbatimTextOutput("text_1q"),
                                          h5("3rd quartile"),
                                          verbatimTextOutput("text_3q"),
                                          h5("Minimum"),
                                          verbatimTextOutput("text_min"),                               
                                          h5("Maximum"),
                                          verbatimTextOutput("text_max")
                                          )
                                   )
                          )
                )



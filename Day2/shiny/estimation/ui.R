## This app demonstrates the difference between the true and sample means.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
plot.width <- 6
plot.height <- 500
pageWithSidebar(
                headerPanel("Standard error vs standard deviation", "Cattle weight simulation"),
                sidebarPanel(
                             sliderInput("number", "Number of cattle:", min=5, max=200, value=50, step=5),
                             sliderInput("mean", "Mean weight (kg):", min = 600, max = 1000, value = 700, step=50),
                             sliderInput("sd", "Standard deviation (kg):", min = 50, max = 150, value = 100, step=10),
                             checkboxInput("overlay", "Overlay parameters and estimates"),
                             checkboxInput("ci", "Add 95% confidence interval"),
                             actionButton("resample", "Fresh cows, please")
                             ),
                mainPanel(
                          fluidRow(column(width = plot.width, plotOutput("plot1", height = plot.height)),
                                   column(width = plot.width, 
                                          h4("Sample mean:"),
                                          verbatimTextOutput("text1"),
                                          h4("Standard error of the mean:"),
                                          verbatimTextOutput("text2"),
                                          h4("Sample standard deviation:"),
                                          verbatimTextOutput("text3")
                                          )
                                   )
                          )
                )



## This app demonstrates the stochasticity of the p-value.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
source("reference.R")
plot.width <- 6
plot.height <- 400
pageWithSidebar(
                headerPanel("Stochasticity of the p-value", "Body temperature simulation"),
                sidebarPanel(
                             selectInput("hypothesis", "Type of test", choices=all.tests),
                             uiOutput("hypothesis_text"), br(),
                             selectInput("chosen", "Simulate under:", choices=all.hyp),
                             sliderInput("number", "Number of measurements:", min=50, max=200, value=100, step=10),
                             actionButton("resample", "Repeat experiment")
                             ),
                mainPanel(
                          fluidRow(
                                   column(width = plot.width, plotOutput("plot1", height = plot.height, click="plot1_click")),
                                   column(width = plot.width, plotOutput("plot2", height = plot.height))
                                   )
                          )
                )



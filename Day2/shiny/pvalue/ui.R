
## written by Aaron Lun
## 12 November 2016

library(shiny)
source("reference.R")
plot.width <- 6
plot.height <- 400
pageWithSidebar(
                headerPanel("Measuring people's body temperatures", "Body temperature simulation"),
                sidebarPanel(
                             selectInput("hypothesis", "Type of test", choices=all.tests),
                             uiOutput("hypothesis_text"), br(),
                             selectInput("chosen", "Simulate under:", choices=all.hyp),
                             sliderInput("number", "Number of people:", min=10, max=200, value=100, step=10),
                             actionButton("resample", "Measure new people!")
                             ),
                mainPanel(
                          fluidRow(
                                   column(width = plot.width, plotOutput("plot1", height = plot.height, click="plot1_click")),
                                   column(width = plot.width, plotOutput("plot2", height = plot.height))
                                   )
                          )
                )



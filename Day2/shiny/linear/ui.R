## This app performs a simple linear regression.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
plot.width <- 6
plot.height <- 500
pageWithSidebar(
                headerPanel("Examining real-valued data with covariates", "Energy/mass simulation"),
                sidebarPanel(
                             sliderInput("speed", HTML("Speed of light (m/s x 10<sup>8</sup>):"), min = 0, max = 10, value = 3, step=0.1),
                             sliderInput("noise", "Experimental noise:", min=0.1, max=5, value=1, step=0.1),
                             actionButton("resample", "Repeat experiment")
                             
                             ),
                mainPanel(
                          fluidRow(column(width = plot.width, plotOutput("plot1", height = plot.height)),
                                   column(width = plot.width, 
                                          fluidRow(
                                                   h4("Simple linear regression:"),
                                                   verbatimTextOutput("text1"),
                                                   h4(HTML("R<sup>2</sup>:")),
                                                   verbatimTextOutput("text2"),
                                                   h4("Pearson correlation:"),
                                                   verbatimTextOutput("text3")
                                                   )
                                          )
                                   )
                          )
                )


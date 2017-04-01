## This app demonstrates the difference between the true and sample means.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
plot.width <- 6
plot.height <- 500
pageWithSidebar(
                headerPanel("Weights of cattle in a feedlot", "Cattle weight simulation"),
                sidebarPanel(
                             sliderInput("number", "Number of animals:", min=2, max=50, value=10, step=2),
                             sliderInput("mean", "Mean weight (kg):", min = 600, max = 800, value = 700, step=20),
                             sliderInput("sd", "Standard deviation (kg):", min = 50, max = 250, value = 100, step=10),
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



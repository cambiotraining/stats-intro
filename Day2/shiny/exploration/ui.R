## This app generates descriptive plots of fishing data.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
plot.width <- 6
plot.height <- 500
pageWithSidebar(
                headerPanel("Exploring data with various plots", "Fishing simulation"),
                sidebarPanel(
                             sliderInput("alexmean", "Alex's average proficiency (fish/day):", min=0, max=40, value=30),
                             sliderInput("sammean", "Sam's average proficiency (fish/day):", min=0, max=40, value=10),
                             sliderInput("loumean", "Lou's average proficiency (fish/day):", min=0, max=40, value=20),
                             actionButton("resample", "Get monthly data")
                             ),
                mainPanel(
                          fluidRow(column(width = plot.width, h4("Histograms:"), plotOutput("plot1", height = plot.height)),
                                   column(width = plot.width, h4("Boxplots:"), plotOutput("plot2", height = plot.height))
#                                    ),
#                           fluidRow(column(width = plot.width, h4("Time course:"), plotOutput("plot3", height = plot.height*0.8)),
#                                    column(width = plot.width, h4("Temperature effect:"), plotOutput("plot4", height = plot.height*0.8))
                                   )
                          )
                )



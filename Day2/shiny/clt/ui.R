## An app to demonstrate how the Central Limit Theorem works.
## (UI-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
sub.width <- 3
sub.height <- 200
pageWithSidebar(
                headerPanel("Demonstrating the central limit theorem", "SAT simulation"),
                sidebarPanel(
                             sliderInput("math", "Math:", min=0, max=100, value=90),
                             sliderInput("literature", "Literature:", min=0, max=100, value=20),
                             sliderInput("history", "History:", min=0, max=100, value=50),
                             sliderInput("biology", "Biology:", min=0, max=100, value=60),
                             sliderInput("chemistry", "Chemistry:", min=0, max=100, value=30),
                             sliderInput("physics", "Physics:", min=0, max=100, value=70),
                             checkboxInput("overlay", "Overlay Normal PDF"),
                             actionButton("resample", "Resample")
                             ),
                mainPanel(
                          fluidRow(plotOutput("individual", height=500)),
                          fluidRow(plotOutput('overall', height=500))
                          )
                )


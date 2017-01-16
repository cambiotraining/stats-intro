## An app to demonstrate how the Central Limit Theorem works.
## (server-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)

server <- function(input, output) {
    collectData <- reactive({
        input$resample
        nstudents <- 10000
        supersim <- function(p) pmin(rnbinom(nstudents, mu=p, size=2), 100)
        data.frame(
                   math=supersim(p=input$math),
                   literature=supersim(p=input$literature),
                   history=supersim(p=input$history),
                   biology=supersim(p=input$biology),
                   chemistry=supersim(p=input$chemistry),
                   physics=supersim(p=input$physics)
                   )
    })
    
    output$individual <- renderPlot({
        collected <- collectData()
        par(mar=c(5.1, 4.2, 4.1, 0.2), mfrow=c(2,3))
        colors <- heat.colors(ncol(collected))
        names(colors) <- colnames(collected)
        for (testtype in colnames(collected)) { 
            hist(collected[,testtype], xlab="Student scores", xlim=c(0, 100), main=toupper(testtype), breaks=10, col=colors[[testtype]], cex.lab=1.4)
        }
    })

    output$overall <- renderPlot({
        collected <- as.vector(rowSums(collectData()))
        par(mar=c(5.1, 4.2, 4.1, 0.2))
        h <- hist(collected, xlab="Student scores", breaks=20, col="grey80", main="Combined SAT score")
        if (input$overlay) { 
            mult <- length(collected)*mean(diff(h$breaks))
            curve(dnorm(x, mean(collected), sqrt(var(collected))) * mult, add=TRUE, col="blue", lwd=2)
        }
    })
}


## This app generates descriptive plots of fishing data.
## (server-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
alxcol <- rgb(1, 0, 0, 0.5)
samcol <- rgb(0, 0, 1, 0.5)
loucol <- rgb(1, 0.6, 0, 0.5)

# Setting up the server actions.
server <- function(input, output) {
    collectData <- reactive({ 
        ndays <- 30
        input$resample
        data.frame(Alex=rpois(ndays, lambda=input$alexmean),
                   Sam=rnbinom(ndays, mu=input$sammean, size=2),
                   Lou=rnbinom(ndays, mu=input$loumean, size=1))
    })

    output$plot1 <- renderPlot({
        collected <- collectData()
        xlimits <- c(0, max(collected))
        breaks <- seq(xlimits[1], xlimits[2], length=10)
        ylimits <- NULL #<- c(0, 15)
        par(mfrow=c(3,1), mar=c(5.1, 4.1, 2.1, 0.2))
        adata <- collected$Alex
        hist(adata[adata <= xlimits[2]], col=alxcol, cex.lab=1.4, 
             xlim=xlimits, breaks=breaks, ylim=ylimits, main="Alex", xlab="Number of fish per day")
        sdata <- collected$Sam
        hist(sdata[sdata <= xlimits[2]], col=samcol, cex.lab=1.4,
             xlim=xlimits, breaks=breaks, ylim=ylimits, main="Sam", xlab="Number of fish per day")
        ldata <- collected$Lou
        hist(ldata[ldata <= xlimits[2]], col=loucol, cex.lab=1.4,
             xlim=xlimits, breaks=breaks, ylim=ylimits, main="Lou", xlab="Number of fish per day")
    })
 
    output$plot2 <- renderPlot({
        par(mar=c(5.1, 4.1, 1.1, 0.1))
        boxplot(collectData(), col=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5), rgb(1, 0.6, 0, 0.5)), range=0, ylab="Number of fish per day")
    })
    
#    output$plot3 <- renderPlot({
#        collected <- collectData()
#        alt <- collected$Lou + rpois(nrow(collected), lambda=2)
#        o <- order(alt)
#        par(mar=c(5.1, 4.1, 1.1, 0.1))
#        plot(collected$Lou[o], col=loucol, type="l", lwd=2, ylim=c(0, max(collected)), xlab="Day", ylab="Number of fish per day") 
#        lines(collected$Alex, col=alxcol, lwd=2)
#        lines(collected$Sam, col=samcol, lwd=2)
#    })
#
#    output$plot4 <- renderPlot({
#        collected <- collectData()
#        temp <- runif(nrow(collected), 20, 30)
#        o <- order(collected$Sam + rpois(nrow(collected), lambda=1))
#        par(mar=c(5.1, 4.1, 1.1, 0.1))
#        plot(temp, collected$Lou, col=loucol, pch=16, ylim=c(0, max(collected)), xlab=expression("Water temperature ("*degree*"C)"), ylab="Number of fish per day") 
#        points(temp, collected$Alex, col=alxcol, pch=16)
#        points(temp[order(-abs(temp-25))], collected$Sam[o], col=samcol, pch=16)
#    })
}


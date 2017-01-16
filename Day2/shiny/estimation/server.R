## This app demonstrates the difference between the true and sample means.
## (server-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
server <- function(input, output) {
    collectData <- reactive({
        input$resample
        out <- rgamma(input$number, shape=(input$mean/input$sd)^2, rate=input$mean/input$sd^2)
        pmin(pmax(out, 500), 1000)
    })
        
    output$plot1 <- renderPlot({
                collected <- collectData()
                par(mar=c(5.1, 4.2, 4.1, 0.2))
                h <- hist(collected, xlab="Cattle weights (kg)", main="", breaks=10, col="grey80", xlim=c(500, 1000), border="grey50")
                m <- mean(collected)
                upper <- max(h$counts)

                if (input$overlay) {
                    abline(v=input$mean, col="dodgerblue", lwd=2)
                    text(input$mean, upper, "True mean", pos=4, col="dodgerblue")
                    
                    abline(v=m, col="red", lwd=2, lty=2)
                    text(m, upper*0.8, "Sample mean", pos=4, col="red")

#                    arrows(input$mean, upper*0.5, input$mean + input$sd, col="dodgerblue", lwd=2)
#                    text(input$mean + input$sd, upper*0.5, pos=4, "True s.d.", col="dodgerblue")
#
#                    s <- sd(collected)
#                    arrows(input$mean, upper*0.4, input$mean + s, col="red", lty=2, lwd=2)
#                    text(input$mean + s, upper*0.4, pos=4, "Sample s.d.", col="red")
                }
                if (input$ci) {
                    s <- sd(collected)/sqrt(length(collected))
                    left <- m - s*1.96
                    right <- m + s*1.96
                    segments(left, upper * 0.1, right, upper*0.1, col="purple")
                    segments(left, upper * 0.12, left, upper*0.08, col="purple")
                    segments(right, upper * 0.12, right, upper*0.08, col="purple")
                    text(right, upper*0.1, "95% CI", col="purple", pos=4)
                }
    })

    output$text1 <- renderPrint({
        collected <- collectData()
        mean(collected)
    })

    output$text2 <- renderPrint({
        collected <- collectData()
        sqrt(var(collected)/length(collected))
    })

    output$text3 <- renderPrint({
        collected <- collectData()
        sqrt(var(collected))
    })
}


## This app performs a simple linear regression.
## (server-side code)
## written by Aaron Lun
## 12 November 2016

library(shiny)
server <- function(input, output) {
    collectData <- reactive({ 
        input$resample
        mass <- seq(0, 10, length=100)
        energy <- rgamma(length(mass), mass * input$speed^2 * 1/input$noise, 1/input$noise)
        data.frame(mass=mass,
                   energy=energy)
    })

    output$plot1 <- renderPlot({
        collected <- collectData()
        par(mar=c(5.1, 4.2, 4.1, 0.1))
        plot(collected$mass, collected$energy, xaxs="i", yaxs="i", xlab="Mass (kg)", ylab=expression("Energy (J x"~10^{16}~")"), main="Energy/mass relationship")
        fit <- linearFit()
        abline(coef(fit)[1], coef(fit)[2], lwd=2, lty=2, col="red")
    })

    linearFit <- reactive({
        collected <- collectData()
        lm(energy ~ mass, data=collected)
    })

    output$text1 <- renderPrint({
        linearFit()
    })
 
    output$text2 <- renderPrint({
        fit <- linearFit()
        summary(fit)$r.squared
    })

    output$text3 <- renderPrint({
        collected <- collectData()
        cor(collected$energy, collected$mass)
    })
}


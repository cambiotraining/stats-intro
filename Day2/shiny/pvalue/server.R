# This demonstrates the stochasticity of data, the differences between the sample mean and true mean,
# and differences between the sample standard deviation and standard error.

library(shiny)
server <- function(input, output) {
    collectData <- reactive({
        input$resample
        alt <- ifelse(input$hypothesis==all.tests[3], 36, 38)
        mu <- ifelse(input$chosen==all.hyp[1], normal.temp, alt) 
        collected <- rnorm(input$number, mean=mu, sd=normal.sd)
        yloc <- runif(length(collected), 0, dnorm(collected, mean=normal.temp, sd=normal.sd))
        data.frame(x=collected, y=yloc)
    })

    output$hypothesis_text <- renderUI({
        tagList(
                HTML({
                    if (input$hypothesis==all.tests[1]) {
                        x <- "="
                        y <- "&ne;"
                    } else if (input$hypothesis==all.tests[2]) {
                        x <- "&le;"
                        y <- "&gt;"
                    } else {
                        x <- "&ge;"
                        y <- "&lt;"
                    }
                    sprintf("H<sub>0</sub>: temperature %s 37&deg;C<br/>H<sub>1</sub>: temperature %s 37&deg;C", x, y)
                })
                )
    })

    # Click handling
    click_saved <- reactiveValues(singleclick = NULL)
    observeEvent(input$plot1_click, { click_saved$singleclick <- input$plot1_click })

    output$plot1 <- renderPlot({
        collected <- collectData()
        plot(0, 0, type="n", xlab=expression("Observed temperature ("*degree*"C)"), ylab="Density", yaxs="i", 
             ylim=c(0, 0.85), xlim=c(35, 39))
        plot.x <- seq(34.5, 39.5, length.out=100)
        plot.y <- dnorm(plot.x, mean=normal.temp, sd=normal.sd)
        plot.x <- c(plot.x[1], plot.x, plot.x[100])
        plot.y <- c(0, plot.y, 0)

        polygon(plot.x, plot.y, col="grey80", border=NA)
        lines(plot.x, plot.y, col="grey50", lwd=2)
        points(collected$x, collected$y, pch=16, col="grey30")
        
        selected <- nearPoints(collected, click_saved$singleclick, xvar="x", yvar="y")
        if (nrow(selected)) { 

            use.above <- use.below <- FALSE
            if (input$hypothesis==all.tests[1]) {
                use.above <- TRUE
                use.below <- TRUE
                temp.diff <- abs(normal.temp - selected$x[1])
                upper.threshold <- normal.temp + temp.diff
                lower.threshold <- normal.temp - temp.diff
            } else if (input$hypothesis==all.tests[2]) {
                use.above <- TRUE
                upper.threshold <- selected$x[1]
            } else if (input$hypothesis==all.tests[3]) {
                use.below <- TRUE
                lower.threshold <- selected$x[1]
            }

            if (use.above) { 
                is.above <- which(plot.x >= upper.threshold)
                cur.x <- c(upper.threshold, upper.threshold, plot.x[is.above])
                cur.y <- c(0, dnorm(upper.threshold, mean=normal.temp, sd=normal.sd), plot.y[is.above])
                polygon(cur.x, cur.y, col=rgb(1, 0.8, 0.8), border=NA)
                lines(cur.x[-1], cur.y[-1], col=rgb(1, 0.5, 0.5), lwd=2)
                keep <- collected$x >= upper.threshold
                points(collected$x[keep], collected$y[keep], col=rgb(1, 0.3, 0.3), pch=16)
            } 
            if (use.below) {
                is.below <- which(plot.x <= lower.threshold)
                cur.x <- c(plot.x[is.below], lower.threshold, lower.threshold)
                cur.y <- c(plot.y[is.below], dnorm(lower.threshold, mean=normal.temp, sd=normal.sd), 0)
                polygon(cur.x, cur.y, col=rgb(1, 0.8, 0.8), border=NA)
                n <- length(cur.x)
                lines(cur.x[-n], cur.y[-n], col=rgb(1, 0.5, 0.5), lwd=2)
                keep <- collected$x <= lower.threshold
                points(collected$x[keep], collected$y[keep], col=rgb(1, 0.3, 0.3), pch=16)
            }

            points(selected$x[1], selected$y[1], col="red", pch=16)
            abline(v=selected$x[1], col="red", lty=2)
        }
    })

    output$plot2 <- renderPlot({
        all.data <- collectData()
        collected <- all.data$x
        if (input$hypothesis==all.tests[1]) {
            pval <- pmin(pnorm(collected, normal.temp, normal.sd), pnorm(collected, normal.temp, normal.sd, lower=FALSE)) * 2
        } else if (input$hypothesis==all.tests[2]) {
            pval <- pnorm(collected, normal.temp, normal.sd, lower=FALSE)
        } else if (input$hypothesis==all.tests[3]) {
            pval <- pnorm(collected, normal.temp, normal.sd, lower=TRUE)
        }
        h <- hist(pval, xlim=c(0, 1), xlab="P-value", main="", col="grey80", border="grey50")

        all.data$order <- seq_len(nrow(all.data))
        selected <- nearPoints(all.data, click_saved$singleclick, xvar="x", yvar="y")
        if (nrow(selected)) { 
            curp <- pval[selected$order[1]]
            abline(v=curp, col="red", lty=2)
            text(curp, max(h$counts)*0.5, sprintf("%.3f", curp), pos=ifelse(curp > 0.5, 2, 4), col="red")
        }
    })
}


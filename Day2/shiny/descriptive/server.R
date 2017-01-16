# This app provides a simple demonstration of various descriptive statistics.
# (server-side code)
# written by Aaron Lun
# 12 November 2016

library(shiny)
true.bp <- 100
collected <- new.env()
updater <- function(output) {
    output$text_all <- renderPrint({
        options(digits=4, width=55)
        print(sort(collected$data))
    })

    output$text_mean <- renderPrint({
        options(digits=4)
        mean(collected$data)
    })

    output$text_sd <- renderPrint({
        options(digits=4)
        sd(collected$data)
    })

    output$text_med <- renderPrint({
        options(digits=4)
        median(collected$data)
    })

    output$text_1q <- renderPrint({
        options(digits=4)
        unname(quantile(collected$data, 0.25))
    })

    output$text_3q <- renderPrint({
        options(digits=4)
        unname(quantile(collected$data, 0.75))
    })

    output$text_min <- renderPrint({
        options(digits=4)
        min(collected$data)
    })

    output$text_max <- renderPrint({
        options(digits=4)
        max(collected$data)
    })
}

server <- function(input, output) {
    observeEvent(input$resample, ({
        collected$data <- c(collected$data, round(runif(1, 0, 20)))
        updater(output)
    }))

    observeEvent(input$outlier, ({
        collected$data <- c(collected$data, 365)
        updater(output)
    }))
    
    observeEvent(input$reset, ({
        collected$data <- NULL
        updater(output)
    }))
        
    updater(output)
}


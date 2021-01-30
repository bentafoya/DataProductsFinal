#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(readxl)
library(tidyverse)
library(leaflet)
library(plotly)
library(webshot)
library(dplyr)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        LinkPart <- "CoviddataMassJan.xlsx"
        df2 <- read_excel(LinkPart)
        df2$Cases100K <- as.numeric(df2$Cases100K)
        #plot3 <- plot_ly(df2, x = ~Incomepercapita, y = ~Cases100K, type = "scatter")
        
        #x    <- 350
        

        # draw the histogram with the specified number of bins
        df2 <- df2[order(-df2$Population),]
        #plot3 <- plot_ly(df2[1:bins,], x = ~Incomepercapita, y = ~Cases100K, type = "scatter", 
                        # size = ~Population) %>% 
            #layout(title = "Mass Covid Test Rate v Income for Large Municipalities",                                 xaxis = list(title="Income per Capita"), 
                  # yaxis = list(title="Confirmed COVID Cases per 100K"))
        Towns <- seq(min(1), max(350), length.out = input$Towns)
        #Browser()
        df2<-df2[1:length(Towns),]
        #PopTotal <- sum(df2$Population)
        plot(x = df2$Incomepercapita, y = df2$Cases100K, type = "p",
        main="COVID Infection Rate v Municipal Per Capita Income",
        ylab="Confirmed COVID Cases per 100K",
        xlab="Income per Capita",
        col="blue")

    })
    output$PopTotal <- renderText({
        LinkPart <- "CoviddataMassJan.xlsx"
        df2 <- read_excel(LinkPart)
        df2$Cases100K <- as.numeric(df2$Cases100K)
        df2 <- df2[order(-df2$Population),]
        Towns <- seq(min(1), max(350), length.out = input$Towns)
        df2<-df2[1:length(Towns),]
        sum(df2$Population)
    })
})

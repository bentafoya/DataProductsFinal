#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Mass Covid Infection Rate v. Community Income"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Towns",
                        "Number of Communities:",
                        min = 1,
                        max = 350,
                        value = 40),
            p("This application shows the COVID-19 infection rate for Massachusetts cities and towns. The data is from the Massachusetts DPH and covers a two week period in early January. The slider lets you pick the number of communities to graph."),
            p("The communities are sorted in population order from highest - Boston - to the lowest - Gosnold. So selecting 40 gives you a plot of the infection rate v. per capita income of the 40 largest communities in the Commonwealth."),
            p("An interactive element sits below the plot and shows the cumulative population total for the number of communities selected with the maximum being 6964122.")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            #PopTotal
            h3("Population of the selected number of communities"),
            h3(textOutput("PopTotal", container = span)),
        )
    )
))

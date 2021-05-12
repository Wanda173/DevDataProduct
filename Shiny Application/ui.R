#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data("diamonds")


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Diamond Prices Analysis Per Cut"),

    # Sidebar with a list of values input and a checkbox
    sidebarLayout(
        sidebarPanel(
            selectInput("cutLov", "Select type of Diamond Cut", 
                                  c("Fair","Good","Ideal","Premium","Very Good")),
            checkboxInput("show_mean", "Calculate / Hide Mean Diamond Prices", value = TRUE)
        ),

        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            textOutput("disptext"),
            textOutput("disptext2")
        )
    )
))

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data("diamonds")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  

      output$distPlot <- renderPlot({
        
        set.seed(4670)
        dt <- subset(diamonds, cut==input$cutLov)
        mn <- round(mean(dt$price),2)
        

        g <- ggplot(dt, aes(x=price, fill=clarity))  + geom_histogram(bins=30) 
        g <- g + labs(title=paste("Histogram of Diamond prices for Cut : " ,input$cutLov) , color="Legend") +
          labs(x="Price ($)") 
        
        
        if (input$show_mean) {
          g <- g + geom_vline(aes(xintercept=mn), colour="red", size=2)
        }

        print(g)
        
    })

      
   dispmean <- reactive({
     
     set.seed(4670)
     dt <- subset(diamonds, cut==input$cutLov)
     mu <- round(mean(dt$price))

     txt1 <- paste(" Mean Diamond Price for Cut '",input$cutLov,"' is $",mu)

     cnt <- NROW(subset(dt,dt$price > mu))
     tot <- NROW(dt)
     per <- round((cnt/tot)*100)
   
     txt2 <- ifelse(input$show_mean, paste(txt1, ' with ', per," % of the records above the mean price "), "")
 })
   
   output$disptext <- renderText({ dispmean() })
    

})

---
title       : Using Shiny to analyse Diamond Prices Per Cuts
subtitle    : 
author      : Wanda Ken - 11/05/2021
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## How the App has been built 

* The application has been built using R Shiny package.

* The project consists of two files:
  - ui.R which controls the interface and inputs of the application.
  - server.R which controls what the application does.
  
  - The source codes for the files have been loaded in Github link
   https://github.com/Wanda173/DevDataProduct/tree/main/Shiny%20Application

* The application has been deployed at the below link: (It can take a few seconds to load)
  https://wandaken.shinyapps.io/diamond/


---

## About the Dataset 
The Diamonds dataset has been used which contains the prices and other attributes of almost 54,000 diamonds.
The variables that are of interest in the analysis are:
* price - Price in US dollars
* cut - Quality of the cut (Fair, Good, Very Good, Premium, Ideal)
* clarity - Measurement of how clear the diamond (I1, SI2, SI1, VS2, VS1, VVS2, VVS1, IF)
  with I1 being the worst and IF being the best.

## The App Inputs on the Sidebar Panel
* The "Type of Diamond cut" can be selected from an input drop-down list.
* The "Calculate the Mean Diamond Prices" is a checkbox input.
   - When the checkbox is ticked, the mean details will appear on the Main panel. This is the default setting.
   - When the checkbox is blanked out i.e not ticked, the details of the mean are not shown.

---

## The Plot on the Main Panel
* A histogram is displayed for the diamond prices for the diamond cut selected from the drop down list.

* Each bar is filled in colors of the clarity values.

* When the checkbox is ticked, calculations on the server are triggered based on the diamond cut selected:
  - A vertical red line appears on the histogram representing the mean price for the diamond cut.
  - The mean price will be calculated beneath the plot.
  - The % of records from the dataset that have a price above the mean price will also been calculated. 

---

## Server Calculation used to display the mean details

dispmean <- reactive({
     
     set.seed(4670)
     # Get the data for the select cut of diamond
     dt <- subset(diamonds, cut==input$cutLov)
     # Calculate the mean
     mu <- round(mean(dt$price))

     txt1 <- paste(" Mean Diamond Price for Cut '",input$cutLov,"' is $",mu)

     # Calculate the % of records above the mean for the Diamond Cut
     cnt <- NROW(subset(dt,dt$price > mu))
     tot <- NROW(dt)
     per <- round((cnt/tot)*100)
   
     txt2 <- ifelse(input$show_mean, paste(txt1, ' with ', per," % of the records above the mean price "), "")
 })

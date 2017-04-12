# This shiny - app predict MPG from the HorsePower specification of the car
# Based on R's mtcars database
#

library(shiny)

shinyUI(fluidPage(
   titlePanel("Predict MPG from HorsePower"),
   sidebarLayout(
      sidebarPanel(
         sliderInput("sliderHP", "What is the HP of the car?", 50, 350, value = 123),
         checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
         checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
      ),
      mainPanel(
         plotOutput("plot1"),
         h3("Predicted MPG from Model 1:"),
         textOutput("pred1"),
         h3("Predicted MPG from Model 2:"),
         textOutput("pred2")
      )
   )
))
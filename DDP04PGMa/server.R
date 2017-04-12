# This shiny - app predict MPG from the HorsePower specification of the car
# Based on R's mtcars database
#
# https://harmlammers.shinyapps.io/DDP04PGMa/
#

library(shiny)

shinyServer(function(input, output) {
   mtcars$hpsp <- ifelse(mtcars$hp - 123 > 0, mtcars$hp - 123, 0)
   model1 <- lm(mpg ~ hp, data = mtcars)
   model2 <- lm(mpg ~ hpsp + hp, data = mtcars)
   
   model1pred <- reactive({
      hpInput <- input$sliderHP
      predict(model1, newdata = data.frame(hp = hpInput))
   })
   
   model2pred <- reactive({
      hpInput <- input$sliderHP
      predict(model2, newdata = 
                 data.frame(hp = hpInput,
                            hpsp = ifelse(hpInput - 123 > 0,
                                           hpInput - 123, 0)))
   })

   output$plot1 <- renderPlot({
      hpInput <- input$sliderHP
      
      plot(mtcars$hp, mtcars$mpg, xlab = "HorsePower", 
           ylab = "Miles Per Gallon", bty = "n", pch = 16,
           xlim = c(50, 350), ylim = c(10, 35))
      if(input$showModel1){
         abline(model1, col = "red", lwd = 2)
      }
      if(input$showModel2){
         model2lines <- predict(model2, newdata = data.frame(
            hp = 50:350, hpsp = ifelse(50:350 - 123 > 0, 50:350 - 123, 0)
         ))
         lines(50:350, model2lines, col = "blue", lwd = 2)
      }

      legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
             col = c("red", "blue"), bty = "n", cex = 1.2)
      points(hpInput, model1pred(), col = "red", pch = 16, cex = 2)
      points(hpInput, model2pred(), col = "blue", pch = 16, cex = 2)
   })
   
   output$pred1 <- renderText({
      model1pred()
   })
   
   output$pred2 <- renderText({
      model2pred()
   })
})
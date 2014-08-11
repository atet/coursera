## AK 20140811
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

library(shiny)

shinyServer(
  function(input, output){
    
    # Render printing of mpg information for inline text (same font, font size, format, etc.)
    # The following will determine the text output for the mpg selection range
    output$output_mpg = renderPrint({cat("1. Want about ", paste(input$mpg, collapse = " - "), "mpg...")})

    # Render printing of transmission information for inline text (same font, font size, format, etc.)
    # The following if block will determine the text output for the transmission selection
    output$output_trans = renderPrint({
      if(input$trans == "Automatic"){ # mtcars$am: Transmission (0 = automatic, 1 = manual)
        cat("2. An Automatic transmission...")
      }else if(input$trans == "Manual"){
        cat("2. A Manual transmission...")
      }else if(input$trans == "Either"){
        cat("2. Either an Automatic or Manual transmission...")
      }
    })
    
    # Render printing of transmission information for inline text (same font, font size, format, etc.)
    # The following if block will determine the text output for the speed selection range
    output$output_speed = renderPrint({
      if(length(input$speed) > 1){
        cat("3. And you want to drive in the speed range of a ", paste(input$speed[1], input$speed[length(input$speed)], sep = " to "), "...")
      }else
        cat("3. And you want to drive like a ", input$speed, "...")
    })
    
    # This section will execute the filtering of the mtcars data frame after the first press of the GO button
    output$output_car = renderText({
      if(input$goButton > 0){ # Initial page load will not show the prediction, only after pressing the Go button
        
        predict_car = mtcars
        
        # Filter by selected mpg range
        mpg_low = input$mpg[1]
        mpg_high = input$mpg[2]
        predict_car = predict_car[predict_car$mpg >= mpg_low & predict_car$mpg <= mpg_high,]
        
        # Filter by selected transmission
        if(input$trans == "Automatic"){ # mtcars$am: Transmission (0 = automatic, 1 = manual)
          trans = 0
          predict_car = predict_car[predict_car$am == 0,]
        }else if(input$trans == "Manual"){
          trans = 1
          predict_car = predict_car[predict_car$am == 1,]
        }else if(input$trans == "Either"){
          # Do nothing, i.e. consider both automatic and manual
        }
        
        # Filter by selected speed range
        if(length(input$speed) > 1){
          if(input$speed[1] == "Snail"){
            speed_low = 52
          }else if(input$speed[1] == "Rabbit"){
            speed_low = 81
          }
          if(input$speed[2] == "Rabbit"){
            speed_high = 150
          }else if(input$speed[2] == "Cheetah"){
            speed_high = 335
          }
        }else{
          if(input$speed == "Snail"){
            speed_low = 52
            speed_high = 80
          }else if(input$speed == "Rabbit"){
            speed_low = 81
            speed_high = 150
          }else if(input$speed == "Cheetah"){
            speed_low = 151
            speed_high = 335
          }
        }
        predict_car = predict_car[predict_car$hp >= speed_low & predict_car$hp <= speed_high,]
        
        # Collect names of remaining cars after filtering
        predict_car = rownames(predict_car)
        
        # If there is only a single car, display the car name plus model year
        # If there are multiple cars, we will random select one
        # If there are no cars that fit the criteria, display that no cars fit the criteria provided by the user.
        if(length(predict_car) > 1){ 
          # If there is more than one result, we will just randomly pick one for you!
          predict_car = paste("1974 ", predict_car[sample(length(predict_car), 1)], "*", sep = "")
        }else if(length(predict_car) == 1){
          predict_car = paste("1974 ", predict_car, sep = "")
        }else if(length(predict_car) == 0){
          predict_car = "Nothing matches your unrealistic demands!"
        }
        
        # Isolate and return the predicted car name (this actually 
        #  didn't initially isolate for me, the above "input$goButton > 1" 
        #  was a workaround to make the results not display initially before pressing Go button)
        isolate(
          predict_car
        )
        
      }
    })
    
  }
)
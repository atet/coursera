## AK 20140808
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

library(shiny)

# Will use mtcars dataset

shinyUI(
  pageWithSidebar(
    
    # User interface of the header panel
    headerPanel(
      title = em("Find the car (from 1974...) that's right for you!")
    ),
    
    # User interface of the sidebar panel where user input will be entered
    sidebarPanel(
      strong(em("In just TWO (2) steps, we will predict the right car for you!")),
      p("It's soooooo easy to use:"),
      p(strong("Step 1)"), "Just answer the following three questions below (Your selections will be updated in", strong(em("real time")), "on the right side of the page)."),
      sliderInput(
        inputId = "mpg",
        label = "1. What is your ideal fuel efficiency range (in miles per gallon)?",
        value = c((min(mtcars$mpg) + ((max(mtcars$mpg) - min(mtcars$mpg))/2)) - 5, (min(mtcars$mpg) + ((max(mtcars$mpg) - min(mtcars$mpg))/2)) + 5), # Adding two values makes a range
        min = min(mtcars$mpg), max = max(mtcars$mpg), step = 0.1
      ),
      br(),
      radioButtons(
        inputId = "trans",
        label = "2. What kind of transmission do you like?",
        selected = "Either",
        choices = 
          c(
            "Automatic" = "Automatic", # Automatic
            "Manual" = "Manual",       # Manual
            "Either" = "Either"        # Consider both Anutomatic and Manual
          )
      ),
      br(),
      checkboxGroupInput(
        inputId = "speed",
        label = "3. How fast do you like to drive (select all that apply)?",
        selected = "Rabbit",
        choices = 
          c(
            "Snail"    = "Snail",
            "Rabbit"   = "Rabbit",
            "Cheetah"  = "Cheetah"
        )
      ),
      br(),
      p(strong("Step 2)"), "Press the \"Predict!\" button and the car we predict for you will appear in the right side of the page!"),
      actionButton("goButton", "Predict!")
    ),
    
    # User interface of the main panel where the predicted results will be displayed
    mainPanel(
      strong("Since you..."),
      textOutput("output_mpg"),   # Real time output of the mpg range selected
      textOutput("output_trans"), # Real time output of the transmission selected
      textOutput("output_speed"), # Real time output of the speed range selected
      br(),
      strong("We predict that you'd love to drive a..."),
      br(),
      h2(textOutput("output_car")) # Output of the prediction will only occur with an initial press of the Predict Go Button
    )
  )
)
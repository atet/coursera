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
    
    
    headerPanel(
      title = em("Find the car (from 1974...) that's right for you!")
    ),
    
    
    sidebarPanel(
      strong(em("We will predict the right car for you!")),
      p("It's soooooo easy for you to use, just answer the following three questions below and the predictions will be displayed on the right side of the page!"),
      br(),
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
      actionButton("goButton", "Predict!")
    ),
    
    
    mainPanel(
      strong("Since you..."),
      textOutput("output_mpg"),
      textOutput("output_trans"),
      textOutput("output_speed"),
      br(),
      strong("We predict that you'd love to drive a..."),
      br(),
      h2(textOutput("output_car"))
    )
  )
)
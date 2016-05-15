library(shiny)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel(h3("Sample Investment Paths")
             ),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(position = "left",
    sidebarPanel(actionButton("simulate", label = "Simulate"),
      "This app is made to show the effect of uncertainty on investments.",
      "Volatility is a measure of uncertainty.",
      "See a potential path of a retiring account based on your inputs.",
      "Chose your inputs and click Simulate.",
                 
                 
      # Average growth
      sliderInput("average_growth", "Average Growth:",
                  min=-20, max=20, value=3, step= 0.5,
                  post = "%"),
      helpText("Average Growth of your investment account not including monthly contributions)."),
      
      # Volatility
      sliderInput("volatility", "Volatility:",
                  min=0, max=100, value=30, step= 2,
                  post = "%"),
      helpText("Measure of uncertainty. Higher volatility may result in significant gains or losses."),
      
      # Years of contributions
      sliderInput("contribution_year", "Contributions within the ages of:",
                  min = 18, max = 72, value = c(25,60)),
      helpText("The years during contributions to the account will take place."),
      
      # Monthly Contributions
      sliderInput("monthly_contributions", "Monthly Contributions:",
                  min = 0, max = 10000, value = 250, step = 50,
                  pre = "$", sep = ","),
      helpText("Contributions to the investment account per month.")
    ),
    
    # Show a table summarizing the values entered
    mainPanel( #tags$style("body {background-color: aliceblue; }"),
      h4("See a smaple paths of an investment account"),
              h5("Under the assumption that returns are normaly distributed, investment values lognormaly distributed and follow a geometrical Brownian motion"),
              h6("This app was created as the project for the Developing Data Products course of the Coursera Data Science Specialization by Johns Hopkins University"),
              h6("Anastasios Mallis, May 2016"),
      #tableOutput("values"),
      plotOutput("sample_path_plot"),
      textOutput("final_result")
    )
  )
))
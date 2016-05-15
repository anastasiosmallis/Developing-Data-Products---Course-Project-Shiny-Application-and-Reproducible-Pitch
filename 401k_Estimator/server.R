library(shiny)
#library(quantmod)
library(stats)
library(ggplot2)

aggregate_contributions<-function(input) {
  input$monthly_contributions*12*(input$contribution_year[2]-input$contribution_year[1])
}

path_length <- function(input){
  (input$contribution_year[2]-input$contribution_year[1])*252
}


#sample.path<-path(input)

# Define server logic for slider examples
shinyServer(function(input, output) {
  
  path<- eventReactive(input$simulate,{
    temp_path<-c(rep(0,path_length(input)))
    temp_path[1]<-input$monthly_contributions
    for(i in 2:path_length(input)){
      temp_path[i]<-temp_path[i-1]*exp((input$average_growth/100-((input$volatility/100)^2)/2)*(1/252)+(input$volatility/100)*sqrt(1/252)*rnorm(1))
      if((i-1)%%21==0){
        temp_path[i]<-temp_path[i]+input$monthly_contributions
      }
    }
    return(temp_path)
  })
  
  contributions<-eventReactive(input$simulate,{
    c_path<-c(rep(0,path_length(input)))
    c_path[1]<-input$monthly_contributions
    for(i in 2:path_length(input)){
      c_path[i]<-c_path[i-1]
      if((i-1)%%21==0){
        c_path[i]<-c_path[i]+input$monthly_contributions
      }
    }
    return(c_path)
  })
  
  zero_vol<-eventReactive(input$simulate,{
    z_path<-c(rep(0,path_length(input)))
    z_path[1]<-input$monthly_contributions
    for(i in 2:path_length(input)){
      z_path[i]<-z_path[i-1]*exp((input$average_growth/100)*(1/252))
      if((i-1)%%21==0){
        z_path[i]<-z_path[i]+input$monthly_contributions
      }
    }
    return(z_path)
  })
  
  
  
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    # Compose data frame
    data.frame(
      Name = c("Average Growth", 
               "Volatility",
               "Contribution Years",
               "Monthly Contributions"),
      Value = as.character(c(input$average_growth, 
                             input$volatility,
                             paste("Between the ages of ", input$contribution_year[1],
                                   " and ", input$contribution_year[2]),
                             input$monthly_contributions)), 
      stringsAsFactors=FALSE)
  }) 
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  output$sample_path_plot <- renderPlot({
    
    df<- data.frame(seq(from=input$contribution_year[1], 
                         to=input$contribution_year[2],
                         length.out = path_length(input))
                     ,path(),contributions(),zero_vol())
    names(df) <- c("Age","Value","Contributions","Zero_Volatility")
    
    ggplot(data=df, aes(x=Age,colour = Value)) +
      geom_line(aes(y = Value, colour = "Investment Value")) +
      geom_line(aes(y = Contributions, colour = "Contributions")) +
      geom_line(aes(y = Zero_Volatility, colour = "Value if Investment was certain"))
    
#     par(bg = "aliceblue")
#     
#     plot(path(),type="l",col="palegreen4",
#          xlab = "Age", ylab = "Investment Value",lwd=0.5,xaxt="n",yaxt="n")
#     lines(contributions(),type = "l",col="palegreen",lwd=3,lty=4)
#     
#     axis(1, at=seq(from=0, to=path_length(input), by=252*5), 
#          labels = seq(from= input$contribution_year[1],to= input$contribution_year[2], by=5))     
#     
#     yticks <- pretty(path()) 
#     axis(2, at=yticks, labels=sprintf("$%gk",yticks/1000)) 
    
  })
  # Show ending result text
  output$final_result <- renderText({ 
    paste("Based on your selections, this sample path shows a terminal investment value of $",
          formatC(path()[path_length(input)-1],format="d", big.mark=','),
          ".\nYour aggregate contributions are $",
          formatC(aggregate_contributions(input),format="d", big.mark=','),
          ".\nYour investment would have been worth $",
          formatC(zero_vol()[length(zero_vol())],format="d", big.mark=',')," if it was certain.")
  })
})
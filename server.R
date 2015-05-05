list.of.packages <- c("choroplethr", "choroplethrMaps", "shiny")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
library(choroplethr)
library(choroplethrMaps)

data(df_state_demographics, package="choroplethr", envir=environment())
data(df_county_demographics, package="choroplethr", envir=environment())

shinyServer(function(input, output) {
  
  output$map_state = renderPlot({
    title=input$demographic
    num_colors = as.numeric(input$num_colors)
    df_state_demographics$value = df_state_demographics[, input$demographic]
    state_choropleth(df_state_demographics, title=title, num_colors=num_colors)
  })
  
  output$map_county = renderPlot({
    title=input$demographic
    num_colors = as.numeric(input$num_colors)
    df_county_demographics$value = df_county_demographics[, input$demographic]
    county_choropleth(df_county_demographics, title=title, num_colors=num_colors)
  })

  output$boxplot = renderPlot({
    title=input$demographic
    df_state_demographics$value = df_state_demographics[, input$demographic]
    boxplot(df_state_demographics$value, main=title)
  })
})
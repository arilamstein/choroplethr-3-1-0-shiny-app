list.of.packages <- c("choroplethr", "choroplethrMaps", "shiny")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
library(choroplethr)
library(choroplethrMaps)

# the state and county demographics are in these two data.frames. 
# first column is a list of regions. each subseqent column is a value
data(df_state_demographics , package="choroplethr", envir=environment())
data(df_county_demographics, package="choroplethr", envir=environment())

title_first_part = "2013 5-Year American Community Survey:\n"

shinyServer(function(input, output) {
  
  # render the boxplot
  output$boxplot = renderPlot({
    # prepare the data
    title                        = paste0(title_first_part, input$demographic)
    df_state_demographics$value  = df_state_demographics[, input$demographic]
    df_county_demographics$value = df_county_demographics[, input$demographic]
    
    #render
    boxplot(df_state_demographics$value, 
            df_county_demographics$value, 
            main  = title, 
            names = c("State", "County"))
  })
  
  # render the state choropleth map
  output$map_state = renderPlot({
    # prepare the data
    title                       = paste0(title_first_part, input$demographic)
    num_colors                  = as.numeric(input$num_colors)
    df_state_demographics$value = df_state_demographics[, input$demographic]
    
    # render
    state_choropleth(df_state_demographics, 
                     title      = title, 
                     num_colors = num_colors)
  })
  
  # render the county choropleth map
  output$map_county = renderPlot({
    # prepare the data
    title                        = paste0(title_first_part, input$demographic)
    num_colors                   = as.numeric(input$num_colors)
    df_county_demographics$value = df_county_demographics[, input$demographic]
    
    # render
    county_choropleth(df_county_demographics, title=title, num_colors=num_colors)
  })
})
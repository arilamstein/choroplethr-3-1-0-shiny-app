library(shiny)

data(df_state_demographics, package="choroplethr")
demographic_choices = colnames(df_state_demographics)[2:ncol(df_state_demographics)]

shinyUI(fluidPage(

  titlePanel("Explore Demographic Data from choroplethr v3.1.0"),

  sidebarLayout(
    sidebarPanel(      
      selectInput("demographic",
                  label = "Select demographic",
                  choices = demographic_choices,
                  selected = "percent_white"),
      selectInput("num_colors",
                  "Select number of colors",
                  1:9,
                  selected=7)      
    ),

    mainPanel(
      plotOutput("boxplot"),
      plotOutput("map_state"),
      plotOutput("map_county")
    )
  )
))

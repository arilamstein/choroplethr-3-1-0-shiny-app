library(shiny)

# the names of the demographic variables are the column names of this data.frame
# the first column name is a list of the regions, so skip it
data(df_state_demographics, package="choroplethr")
demographic_choices = colnames(df_state_demographics)[2:ncol(df_state_demographics)]

shinyUI(fluidPage(

  titlePanel("Demographic Data from choroplethr v3.1.0"),

  fluidRow(column(12, includeMarkdown("text.md"))),
  
  sidebarLayout(
    sidebarPanel(      
      selectInput("demographic",
                  label = "Select demographic",
                  choices = demographic_choices,
                  selected = "total_population"),
      
      selectInput("num_colors",
                  "Select number of colors",
                  1:9,
                  selected=1)      
    ),

    mainPanel(
      plotOutput("boxplot"),
      plotOutput("map_state"),
      plotOutput("map_county")
    )
  )
))

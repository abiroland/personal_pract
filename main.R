library(shiny)
library(shinycssloaders)
library(shinydashboard)
library(shinythemes)
library(tidyverse)

ui <- fluidPage(

  selectInput()
  selectInput()
  selectInput()
    
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
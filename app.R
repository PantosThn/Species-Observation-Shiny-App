library(shiny)
library(leaflet)
library(highcharter)  # Add highcharter library
library(DT)
library(dplyr)
library(htmlwidgets)
library(data.table)
library(memoise)

# Source the data_loader script
source("data_loader.R")

# Load data
joined_data <- load_data()

# Define a reactive expression for joined_data
joined_data_reactive <- reactive({
  joined_data
})

# Source the UI script
source("ui.R")
source("server.R")

joined_data <- load_data()

# Run the application
shinyApp(ui = ui, server = server)

# Shiny Application

This repository contains code for a Shiny application that visualizes species observations using Leaflet maps and Highcharts timeline visualization.

## Overview

The application consists of three main components:

1. **Data Loading**: Data is loaded from an external source using the `data_loader.R` script.
2. **User Interface (UI)**: The UI is defined in the `ui.R` script and includes inputs for selecting species names.
3. **Server Logic**: The server logic is defined in the `server.R` script and includes reactive expressions for data filtering, Leaflet map rendering, and Highcharts timeline visualization.

## Dependencies

This project relies on the following R packages:

- **shiny**: Required for building the Shiny application framework.
- **memoise**: Used for memoization in the `data_loader.R` script.
- **data.table**: Used for data manipulation in the `data_loader.R` script.
- **leaflet**: Required for creating interactive Leaflet maps.
- **highcharter**: Required for creating interactive Highcharts visualizations.
- **htmlwidgets**: Required for integrating HTML widgets into the Shiny application.

To install these packages, you can use the following R command:

```R
install.packages(c("shiny", "memoise", "data.table", "leaflet", "highcharter", "htmlwidgets"))
```
## Usage

1. Ensure that you have R and the required packages installed.
2. Clone or download this repository to your local machine.
3. Open R or RStudio.
4. Set your working directory to the root of the cloned repository.
5. Run the following commands to launch the Shiny application:

   ```r
   library(shiny)
   shiny::runApp()

## App Preview

![Screenshot](https://i.ibb.co/ns8hfvv/Screenshot-2024-02-13-142628.png)

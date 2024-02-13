server <- function(input, output, session) {
  
  # Reactive filter for species search
  filtered_data <- reactiveVal(NULL)
  
  observeEvent(input$submitBtn, {
    req(input$vernacularName, input$scientificName)
    filtered_data(subset(joined_data,
                         vernacularName == input$vernacularName |
                           scientificName == input$scientificName))
  })
  
  # Output: Leaflet map
  output$map <- renderLeaflet({
    map <- leaflet() %>%
      addProviderTiles("CartoDB.Positron")
    
    if (!is.null(filtered_data())) {
      map <- map %>%
        fitBounds(lng1 = 14.122, lat1 = 49.002, lng2 = 24.145, lat2 = 54.855) %>%
        addMarkers(data = filtered_data(), 
                   ~longitudeDecimal, ~latitudeDecimal,
                   clusterOptions = markerClusterOptions(),
                   popup = customPopup())
    } else {
      map <- map %>%
        setView(lng = 19.145, lat = 51.919, zoom = 6)
    }
    
    return(map)
  })
  
  # Define a custom popup function
  customPopup <- function() {
    paste("Vernacular Name: ", filtered_data()$vernacularName, "<br>",
          "Scientific Name: ", filtered_data()$scientificName, "<br>",
          "Individual Count: ", filtered_data()$individualCount, "<br>",
          "Rights Holder: ", filtered_data()$rightsHolder, "<br>",
          "Creator: ", filtered_data()$creator, "<br>",
          "Image : ", paste0("<img src='", filtered_data()$accessURI, "' style='max-width: 100%; max-height: 100%;'>")
    )
  }
  
  
  # Output: Timeline visualization
  output$timeline <- renderHighchart({  
    data <- filtered_data()
    if(!is.null(data)) {
      # Extract month and year from eventDate
      data$eventDate <- as.Date(data$eventDate)
      data$month_year <- format(data$eventDate, "%Y-%m")
      
      # Aggregate data by month and year
      aggregated_data <- aggregate(vernacularName ~ month_year, data = data, FUN = length)
      
      # Create a Highcharter plot
      highchart() %>%
        hc_title(text = "Timeline of Observations by Month and Year") %>%
        hc_xAxis(categories = aggregated_data$month_year) %>%
        hc_yAxis(
          title = list(
            text = "Frequency",
            style = list(
              fontSize = "16px"  
            )
          )
        ) %>%
        hc_add_series(name = "Observations", data = aggregated_data$vernacularName) %>%
        hc_chart(animation = list(duration = 2500))
      
    } else {
      # If no data, return empty plot
      return(highchart())
    }
  })
}
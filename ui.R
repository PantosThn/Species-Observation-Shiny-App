ui <- fluidPage(
  tags$head(includeHTML("styles.html")
  ),
  div(class = "title", titlePanel("Species Observations in Poland")),
  sidebarLayout(
    sidebarPanel(
      h3("About this App"),
      hr(),
      p("Welcome to the Biodiversity Data Visualization App!"),
      p("This app allows you to explore biodiversity data from the Global Biodiversity Information Facility."),
      p("You can visualize observed species on the map and analyze their occurrence over time."),
      p("Use the dropdown menus to select species of interest and click 'Apply Selection' to update the map and timeline."),
      p("Explore the data and enjoy discovering insights from biodiversity observations!"),
      hr(),
      HTML("<h3>Select Species</h3>"),
      selectInput("vernacularName", "Vernacular Name", choices = unique(joined_data$vernacularName)),
      selectInput("scientificName", "Scientific Name", choices = unique(joined_data$scientificName)),
      hr(),
      actionButton("submitBtn", "Apply Selection", class = "btn btn-primary"),
      hr(),
      p("Use the dropdowns to select a species of interest."),
      p("The map will display the locations where the selected species were observed."),
      hr(),
      class = "sidebar-panel"
    ),
    mainPanel(
      div(class = "block",
          leafletOutput("map")),
      div(class = "block",
          highchartOutput("timeline")),  # Change plotlyOutput to highchartOutput
      class = "main-panel"
    )
  )
)
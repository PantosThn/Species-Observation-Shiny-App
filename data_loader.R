#joined_data <- fread(file = "data/joined_data.csv")

load_data <- function(occurrence_file, multimedia_file) {
  
  load_occurrence_data <- memoise::memoise(function(file_path) {
    # Define columns to load
    cols_to_load <- c("id", "scientificName", "vernacularName",
                      "individualCount", "longitudeDecimal", "latitudeDecimal",
                      "country", "eventDate")
    
    # Load data in chunks
    occ_dt <- fread(file = file_path, select = cols_to_load, header = TRUE)
    
    # Filter data for occurrences in Poland
    occ_dt <- occ_dt[country == "Poland", ]
    
    return(occ_dt)
  })
  
  # Function to load and preprocess multimedia dataset
  load_multimedia_data <- memoise::memoise(function(file_path) {
    # Define columns to load
    cols_to_load <- c("CoreId", "accessURI", "rightsHolder", "creator")
    
    # Load data in chunks
    multi_dt <- fread(file = file_path, select = cols_to_load, header = TRUE)
    
    return(multi_dt)
  })
  
  # Function to perform left join between occurrence and multimedia datasets
  left_join_datasets <- function(occurrence_dt, multimedia_dt) {
    # Perform left join
    joined_dt <- merge(occurrence_dt, multimedia_dt, by.x = "id", by.y = "CoreId", all.x = TRUE)
    
    return(joined_dt)
  }
  
  # Load occurrence data
  #occurrence_dt <- load_occurrence_data(occurrence_file)
  
  # Load multimedia data
  #multimedia_dt <- load_multimedia_data(multimedia_file)
  
  # Perform left join
  #joined_data <- left_join_datasets(occurrence_dt, multimedia_dt)
  

  # Read CSV file
  joined_data <- read.csv("data/joined_data.csv")
  return(joined_data)
}
#' Merge csv files
#'
#' This function merges all csv files in a provided directory
#'
#' 
#' @return A dataframe
#' @export
# merge_csv_files("07_counts/", "csv")


merge_csv_files <- function(directory, pattern) {
  # List all CSV files in the directory matching the pattern
  csv_files <- list.files(path = directory, pattern = pattern, full.names = TRUE, recursive = TRUE)
  
  # Initialize an empty list to store the dataframes
  df_list <- list()
  
  # Loop through each file, read it, and add the filename as a column
  for (file in csv_files) {
    # Read the CSV file into a dataframe
    print(paste0("Reading ", file))
    df <- read.csv(file)
    
    # Add the filename as a new column
    df$filename <- basename(file)
    
    # Append the dataframe to the list
    df_list[[length(df_list) + 1]] <- df
  }
  
  # Bind all the dataframes in the list into a single dataframe
  combined_df <- do.call(rbind, df_list)
  
  # Return the combined dataframe
  return(combined_df)
}

#' Merge txt files
#'
#' This function merges all txt files in a provided directory and subdirectory
#'
#' 
#' @return A dataframe
#' @export
# merge_txt_files("07_counts/", "txt")

merge_txt_files <- function(directory, pattern) {
  # List all TXT files in the directory matching the pattern
  txt_files <- list.files(path = directory, pattern = pattern, full.names = TRUE, recursive = TRUE)
  
  # Initialize an empty list to store the dataframes
  df_list <- list()
  
  # Loop through each file, read it, and add the filename as a column
  for (file in txt_files) {
    # Read the text file into a dataframe
    print(paste0("Reading ", file))
    df <- read.table(file)
    
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

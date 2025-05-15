#' Ingest Monitoring Data
#'
#' This function reads M&E data from a .csv, .xlsx, or Google Sheet and returns a cleaned data frame.
#'
#' @param path Path to the file (CSV, XLSX, or Google Sheet URL)
#' @param sheet Optional sheet name for Excel files
#' @return A data.frame of ingested monitoring data
#' @export
ingest_data <- function(path, sheet = NULL) {
  if (grepl("^https://docs.google.com", path)) {
    if (!requireNamespace("googlesheets4", quietly = TRUE)) stop("Please install 'googlesheets4'")
    data <- googlesheets4::read_sheet(path)
  } else if (grepl("\\.xlsx$", path)) {
    if (!requireNamespace("readxl", quietly = TRUE)) stop("Please install 'readxl'")
    data <- readxl::read_excel(path, sheet = sheet)
  } else if (grepl("\\.csv$", path)) {
    data <- read.csv(path, stringsAsFactors = FALSE)
  } else {
    stop("Unsupported file format. Use .csv, .xlsx, or Google Sheet URL.")
  }
  return(as.data.frame(data))
}

#' Load Logic Model
#'
#' Loads a logic model from a YAML, JSON, or data.frame and returns it as a structured list.
#'
#' @param file Path to a .yaml or .json file, or a data.frame containing the logic model.
#' @return A list representing the logic model
#' @export
load_logic_model <- function(file) {
  if (is.character(file)) {
    if (grepl("\\.ya?ml$", file)) {
      if (!requireNamespace("yaml", quietly = TRUE)) stop("Please install 'yaml'")
      model <- yaml::read_yaml(file)
    } else if (grepl("\\.json$", file)) {
      if (!requireNamespace("jsonlite", quietly = TRUE)) stop("Please install 'jsonlite'")
      model <- jsonlite::fromJSON(file, simplifyVector = TRUE)
    } else {
      stop("Unsupported logic model file type. Use .yaml, .yml or .json.")
    }
  } else if (is.data.frame(file)) {
    model <- as.list(file)
  } else {
    stop("Input must be a file path to .yaml/.json or a data.frame.")
  }

  return(model)
}

#' Validate Logic Model Consistency
#'
#' Checks if required components of a logic model exist and follow expected structure.
#'
#' @param model A logic model list as returned by load_logic_model()
#' @return TRUE if valid, error if invalid
#' @export
validate_model <- function(model) {
  required_fields <- c("inputs", "activities", "outputs", "outcomes", "impact", "kpis", "region", "period")
  missing <- setdiff(required_fields, names(model))
  if (length(missing) > 0) {
    stop(paste("Missing fields in logic model:", paste(missing, collapse = ", ")))
  }
  TRUE
}

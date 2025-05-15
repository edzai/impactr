#' Infer Impact Using Causal Models
#'
#' @param data A data.frame with outcome, treatment, and covariates
#' @param logic_model A logic model list
#' @param method The method to use ('causalforest')
#'
#' @return GRF prediction object
#' @export
infer_impact <- function(data, logic_model, method = "causalforest") {
  if (method == "causalforest") {
    if (!requireNamespace("grf", quietly = TRUE)) stop("Please install the 'grf' package")

    required <- c("region", "period", "outcome_kpi", "treatment")
    if (!all(required %in% names(data))) {
      stop("Data must include: ", paste(required, collapse = ", "))
    }

    # Convert to factors
    data$region <- as.factor(data$region)
    data$period <- as.factor(data$period)

    # Drop factors with fewer than 2 levels to avoid model.matrix errors
    if (nlevels(data$region) < 2) data$region <- NULL
    if (nlevels(data$period) < 2) data$period <- NULL

    # Create covariate matrix X
    covariates <- setdiff(names(data), c("outcome_kpi", "treatment"))
    X <- model.matrix(~ ., data = data[, covariates])[,-1]

    Y <- data$outcome_kpi
    W <- data$treatment

    cf_model <- grf::causal_forest(X, Y, W)
    predictions <- predict(cf_model)

    return(predictions)
  } else {
    stop("Unsupported method: ", method)
  }
}

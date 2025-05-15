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

    # Create feature matrix X using one-hot encoding
    X <- model.matrix(~ region + period, data = data)[, -1]  # drop intercept
    Y <- data$outcome_kpi
    W <- data$treatment

    cf_model <- grf::causal_forest(X, Y, W)
    predictions <- predict(cf_model)

    return(predictions)
  } else {
    stop("Unsupported method: ", method)
  }
}

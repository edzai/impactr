#' Analyse KPIs
#'
#' Compares actual vs. target KPI values and calculates percentage achieved and performance gaps.
#'
#' @param data A data.frame with actual KPI values
#' @param logic_model A logic model list with target KPIs
#' @return A data.frame with KPI analysis
#' @export
analyse_kpis <- function(data, logic_model) {
  if (!"kpis" %in% names(logic_model)) stop("Logic model must include 'kpis' field")
  kpis <- logic_model$kpis

  results <- lapply(kpis, function(kpi_def) {
    kpi_name <- kpi_def$name
    target <- kpi_def$target

    if (!kpi_name %in% names(data)) return(NULL)

    actuals <- data[[kpi_name]]
    avg_actual <- mean(actuals, na.rm = TRUE)
    percent_achieved <- round((avg_actual / target) * 100, 1)
    gap <- target - avg_actual

    data.frame(
      KPI = kpi_name,
      Target = target,
      Actual = avg_actual,
      PercentAchieved = percent_achieved,
      Gap = gap
    )
  })

  do.call(rbind, results)
}

#' Generate Stakeholder Report
#'
#' Generates a tailored report for different stakeholder audiences using rmarkdown.
#'
#' @param data Monitoring data (data.frame)
#' @param logic_model Logic model object
#' @param audience One of 'board', 'public', or 'experts'
#' @param output_format Output format: 'html_document' or 'pdf_document'
#' @return Rendered report file path
#' @export
generate_report <- function(data, logic_model, audience = "board", output_format = "html_document") {
  if (!requireNamespace("rmarkdown", quietly = TRUE)) stop("Please install 'rmarkdown'")

  template_file <- system.file("rmd", paste0("report_", audience, ".Rmd"), package = "impactr")
  if (template_file == "") stop("Template not found for audience: ", audience)

  output_file <- tempfile(fileext = ifelse(output_format == "pdf_document", ".pdf", ".html"))

  rmarkdown::render(
    input = template_file,
    output_format = output_format,
    output_file = output_file,
    params = list(data = data, logic_model = logic_model, audience = audience),
    envir = new.env(parent = globalenv())
  )

  return(output_file)
}

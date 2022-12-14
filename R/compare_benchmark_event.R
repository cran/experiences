

#' Compare Probability of an Event with Benchmark
#'
#' @param event event
#' @param total total
#' @param benchmark benchmark
#' @param event_type Optional: a string describing the type of event. For example, success, failure, etc.
#' @param notes whether output should contain minimal, technical, or executive type of notes.
#' @return list of event rate, probability, notes
#' @export
#' @import cli
#' @import magrittr
#' @importFrom dplyr rename filter
#' @importFrom stringr str_detect
#' @importFrom tibble rownames_to_column
#' @importFrom stats dbinom
#' @importFrom scales percent
#' @importFrom huxtable as_hux position map_align by_cols print_screen
#' @importFrom stats dbinom
#' @examples
#' compare_benchmark_event(benchmark = 0.7,
#'                      event = 10,
#'                      total = 12,
#'                      event_type = "success",
#'                      notes = "minimal")



compare_benchmark_event <- function(benchmark, event, total, event_type = "", notes = c("minimal", "technical")) {

  result <- 1 - sum(dbinom(event:total, prob = benchmark, size = total))

  rate <- event |> divide_by(total) |> percent(2)

  if(event_type == "") {
    event_type <- "event"
  }

  benchmark <- benchmark |> percent()

  result_percent <- result |> percent()

  probability <- round(result, 3)

  minimal <-  paste("Based on the", event_type, paste0("rate of ", rate, ","),
                    "the probability that this rate exceeds a benchmark of",
                    benchmark, "is",
                    result_percent)

  technical <- paste("Probability values were computed based on the binomial distribution",
                     "With the", event_type, paste0("rate of ", rate, ","),
                     "the probability that this rate exceeds a benchmark of",
                     benchmark, "is",
                     result)


  text_result <- match.arg(notes)


  cli::cli_h1("Compare Event Rate with a Benchmark")



  result <- data.frame(event = event,
                       total = total,
                       benchmark = benchmark,
                       probability = probability,
                       text_result =  switch(text_result,
                                             minimal = minimal,
                                             technical = technical)
  )

  cli::cli_text(result$text_result)

  result2 <- result |>
    t() |>
    data.frame() |>
    tibble::rownames_to_column("term") |>
    data.frame() |>
    dplyr::rename(result = t.result.) |>
    huxtable::as_hux()

  huxtable::position(result2) <- "left"

  result3 <- result2 |> dplyr::filter(!stringr::str_detect(term, "text_result"))
  result3 <- huxtable::map_align(result3, huxtable::by_cols("left", "right"))

  huxtable::print_screen(result3, colnames = FALSE)

  result4 <- data.frame(result2)

  return(invisible(result4))


}





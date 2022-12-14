% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compare_benchmark_event.R
\name{compare_benchmark_event}
\alias{compare_benchmark_event}
\title{Compare Probability of an Event with Benchmark}
\usage{
compare_benchmark_event(
  benchmark,
  event,
  total,
  event_type = "",
  notes = c("minimal", "technical")
)
}
\arguments{
\item{benchmark}{benchmark}

\item{event}{event}

\item{total}{total}

\item{event_type}{Optional: a string describing the type of event. For example, success, failure, etc.}

\item{notes}{whether output should contain minimal, technical, or executive type of notes.}
}
\value{
list of event rate, probability, notes
}
\description{
Compare Probability of an Event with Benchmark
}
\examples{
compare_benchmark_event(benchmark = 0.7,
                     event = 10,
                     total = 12,
                     event_type = "success",
                     notes = "minimal")
}

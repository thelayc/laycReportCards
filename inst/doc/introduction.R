## ----, echo = FALSE, message = FALSE-------------------------------------
library(laycReportCards)
knitr::opts_chunk$set(
  comment = "#>",
  error = FALSE,
  tidy = FALSE)

## ------------------------------------------------------------------------
library(laycReportCards)
school_data <- get_rcards('../data/report_card.pdf')
head(school_data[, 2:11])


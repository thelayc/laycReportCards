#' get_date()
#'
#' This function takes a student's report card as input (vector), and extract the term end's date
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_date(students_list[[1]])

get_date <- function(student_rcard){
  
  # 1 - Extract lines containing date information
  # detect date element
  date_line <- stringr::str_detect(student_rcard, "For Term Ending on:")
  # CHECK that pattern has been matched
  assertthat::assert_that(sum(date_line) > 0)
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[date_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  # 2 - Extract date
  # matches everything after "ForTermEndingon:"
  date <- stringr::str_extract(student_rcard, stringr::regex("ForTermEndingon:.+")) 
  # Remove "Cumulative="
  date <- stringr::str_replace(date, "ForTermEndingon:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(date = date)))
}

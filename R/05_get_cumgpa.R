#' get_cumgpa()
#'
#' This function takes a student's report card as input (vector), and extract the students cumulative gpa
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_cumgpa(students_list[[1]])

get_cumgpa <- function(student_rcard){
  
  # 1 - Extract lines containing cumulative gpa information
  # detect cumulative gpa element
  gpa_line <- stringr::str_detect(student_rcard, "Cumulative =")
  # CHECK that pattern has been matched
  assertthat::assert_that(sum(gpa_line) > 0)
  # Extract line containing cumulative gpa
  student_rcard <- student_rcard[gpa_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  # 2 - Extract cumulative gpa
  # matches number with format 0.00 after "Cumulative="
  cumgpa <- stringr::str_extract(student_rcard, stringr::regex("Cumulative=[0-9]\\.[0-9]{2}")) 
  # Remove "Cumulative="
  cumgpa <- stringr::str_replace(cumgpa, "Cumulative=", "") 
  
  ## Return student's cumulative gpa
  return(list(c(cumGpa = cumgpa)))
}

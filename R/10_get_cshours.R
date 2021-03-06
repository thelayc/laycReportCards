#' get_cshours()
#'
#' This function takes a student's report card as input (vector), and extract the student's community service hours
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_cshours(students_list[[1]])

get_cshours <- function(student_rcard){
  
  # 1 - Extract lines containing community service information
  # detect cumulative gpa element
  cshours_line <- stringr::str_detect(student_rcard, "Community Service Hours:")
  # CHECK that pattern has been matched
  assertthat::assert_that(sum(cshours_line) > 0)
  # Extract element containing cumulative gpa
  student_rcard <- student_rcard[cshours_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- stringr::str_replace_all(student_rcard, " ", "")
  
  # 2 - Extract community service hours
  # matches numbers after "CommunityServiceHours:"
  cshours <- stringr::str_extract(student_rcard, stringr::regex("CommunityServiceHours:[0-9]+")) 
  # Remove "Cumulative="
  cshours <- stringr::str_replace(cshours, "CommunityServiceHours:", "") 
  
  ## Return student's cumulative gpa
  return(list(c(cshours = cshours)))
}

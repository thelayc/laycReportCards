#' get_gpa()
#'
#' This function takes a student's report card as input (vector), and extract the students gpas
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' get_gpa(students_list[[1]])

get_gpa <- function(student_rcard){
  
  # 1 - Extract lines containing gpa information
  # detect gpa element
  gpa_line <- grepl(x = student_rcard, pattern = "Grade Point Average")
  # CHECK that pattern has been matched
  assertthat::assert_that(sum(gpa_line) > 0)
  # Extract element containing gpa
  student_rcard <- student_rcard[gpa_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- gsub(x = student_rcard, pattern = " ", replacement = "")
  
  # 2- Extract gpa scores
  # first quarter
  # CHECK: If there is a match for first quarter
  assertthat::assert_that(grepl(pattern = '1=', x = student_rcard))
  # matches number with format 0.00 after "1="
  gpa1 <- stringr::str_extract(student_rcard, stringr::regex("1=[0-9]\\.[0-9]{2}")) 
  # Remove "1="
  gpa1 <- stringr::str_replace(gpa1, "1=", "") 
  
  # second quarter
  # CHECK: If there is a match for second quarter
  assertthat::assert_that(grepl(pattern = '2=', x = student_rcard))
  # matches number with format 0.00 after "2="
  gpa2 <- stringr::str_extract(student_rcard, stringr::regex("2=[0-9]\\.[0-9]{2}")) 
  # Remove "2="
  gpa2 <- stringr::str_replace(gpa2, "2=", "") 
  
  # third quarter
  # CHECK: If there is a match for third quarter
  assertthat::assert_that(grepl(pattern = '3=', x = student_rcard))
  # matches number with format 0.00 after "3="
  gpa3 <- stringr::str_extract(student_rcard, stringr::regex("3=[0-9]\\.[0-9]{2}"))
  # Remove "2="
  gpa3 <- stringr::str_replace(gpa3, "3=", "") 
  
  # fourth quarter
  # CHECK: If there is a match for fourth quarter
  assertthat::assert_that(grepl(pattern = '4=', x = student_rcard))
  # matches number with format 0.00 after "4="
  gpa4 <- stringr::str_extract(student_rcard, stringr::regex("4=[0-9]\\.[0-9]{2}")) 
  # Remove "2="
  gpa4 <- stringr::str_replace(gpa4, "4=", "") 
  
  ## Return student's gpa
  return(list(c(gpa1 = gpa1, gpa2 = gpa2, gpa3 = gpa3, gpa4 = gpa4)))
}

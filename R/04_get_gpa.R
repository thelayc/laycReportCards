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
  ## Load libraries
  library(stringr)
  
  ## Grab student's gpas
  # detect gpa element
  gpa_line <- str_detect(student_rcard, "Grade Point Average")
  # Extract element containing gpa
  student_rcard <- student_rcard[gpa_line]
  # Remove potential duplicates
  student_rcard <- student_rcard[1] 
  # Remove blank spaces
  student_rcard <- str_replace_all(student_rcard, " ", "")
  
  ## Extract gpa first quarter
  # matches number with format 0.00 after "1="
  gpa1 <- str_extract(student_rcard, perl("1=[0-9]\\.[0-9]{2}")) 
  # Remove "1="
  gpa1 <- str_replace(gpa1, "1=", "") 
  
  # Extract gpa second quarter
  # matches number with format 0.00 after "2="
  gpa2 <- str_extract(student_rcard, perl("2=[0-9]\\.[0-9]{2}")) 
  # Remove "2="
  gpa2 <- str_replace(gpa2, "2=", "") 
  
  # Extract gpa third quarter
  # matches number with format 0.00 after "3="
  gpa3 <- str_extract(student_rcard, perl("3=[0-9]\\.[0-9]{2}"))
  # Remove "2="
  gpa3 <- str_replace(gpa3, "3=", "") 
  
  # Extract gpa fourth quarter
  # matches number with format 0.00 after "4="
  gpa4 <- str_extract(student_rcard, perl("4=[0-9]\\.[0-9]{2}")) 
  # Remove "2="
  gpa4 <- str_replace(gpa4, "4=", "") 
  
  ## Return student's gpa
  return(list(c(gpa1 = gpa1, gpa2 = gpa2, gpa3 = gpa3, gpa4 = gpa4)))
}

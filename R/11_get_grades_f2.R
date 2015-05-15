#' get_grades_f2()
#'
#' This function takes a student's report card as input (vector), and extract the student's grades and courses.
#' @param student_rcard A vector containing a student's report card information
#' @keywords student_rcard
#' @export
#' @examples
#' parsed_pdf <-read_pdf('my_pdf_file.pdf')
#' students_list <- split_students(parsed_pdf)
#' student_rcard <- students_list[[1]]
#' get_grades(student_rcard)

get_grades_f2 <- function(student_rcard){
  
  #1) Extract text chunk containing grades information
  # Identify chunk's first line
  chunk_start <- which(stringr::str_detect(student_rcard, 'Term progress marks') == TRUE)
  # Identify chunk's last line
  chunk_end <- which(stringr::str_detect(student_rcard, 'Teacher comment') == TRUE)
  # Extract chunk
  chunk <- student_rcard[chunk_start:chunk_end]
  chunk <- chunk[!is.na(chunk)]
  # Extract grade lines
  grade_lines <- chunk[3:length(chunk)-1]
  
  #2) Identify position of each grade on the line
  # Use "TERM", as a position markers
  # Extract element containing TERM"
  term <- student_rcard[chunk_start]
  term <- stringr::str_locate_all(term, 'TERM')
  # Locate the starting position of "Term 1" in the string - First occurrence of TERM
  g1_position <- term[[1]][1, ]['start']
  # Locate the starting position of "Term 2" in the string
  g2_position <- term[[1]][2, ]['start']
  # Locate the starting position of "Term 3" in the string
  g3_position <- term[[1]][3, ]['start']
  # Locate the starting position of "Term 4" in the string
  g4_position <- term[[1]][4, ]['start']
  # Locate the starting position of "Exam" in the string
  #exam_position <- stringr::str_locate(term, 'Exam')[1]
  # Locate the starting position of "Term 4" in the string
  #final_position <- stringr::str_locate(term, 'Final')[1]
  
  #3) Grab grades based on the position information
  # grab course names
  courses <- stringr::str_trim(substr(grade_lines, 1, g1_position - 1))
  # grab grades from term 1
  term1 <- stringr::str_trim(substr(grade_lines, g1_position, g2_position - 1))
  # grab grades from term 2
  term2 <- stringr::str_trim(substr(grade_lines, g2_position, g3_position - 1))
  # grab grades from term 3
  term3 <- stringr::str_trim(substr(grade_lines, g3_position, g4_position - 1))
  # grab grades from term 4
  term4 <- stringr::str_trim(substr(grade_lines, g4_position, g4_position + 5))
  # grab grades from exam
  #exam <- stringr::str_trim(substr(grade_lines, exam_position, final_position - 1))
  # grab grades from final
  #final <- stringr::str_trim(substr(grade_lines, final_position, final_position + 10))
  
  # Create a dataframe
  grades <- data.frame(courses = courses, term1 = term1, term2 = term2, term3 = term3, term4 = term4)
  # Remove extra rows
  grades <- grades[grades$courses != '', ]
  grades <- grades[grades$courses != 'EDUCATION', ]
  # Replace blank by NAs: TO BE DONE
  
  # Melt data frame
  grades <- reshape2::melt(grades, id = c('courses'))
  # Remove rows with empty value
  grades$value <- stringr::str_replace_all(grades$value, " ", "")
  # Make wide
  grades <- reshape::cast(grades, ~ courses + variable)
  
  return(grades)
}

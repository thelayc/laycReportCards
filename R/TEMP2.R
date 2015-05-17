list.files('./data')

file <- "./data/students_progress.pdf"
# Test read file
txt <- read_pdf(file)

parsed_pdf <- txt
assertthat::assert_that(is.character(parsed_pdf))

# Test split_students
format_type <- 'students_progress'
lst <- split_students(txt, format_type)

# Test get_name
student_rcard <- lst[[1]]
get_name(student_rcard, format_type = format_type)
debug(get_name)
undebug(get_name)

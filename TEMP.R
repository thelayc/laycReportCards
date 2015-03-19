# Testing code for FORMAT1 ------------------------------------------------

list.files('../temp_data', full.names = TRUE, recursive = TRUE)
format_type <- 'format1'
txt <- read_pdf("../temp_data/report_cards/LAYC-Wilson report cards.pdf")
rcards <- split_students(txt, format_type)
student_rcard <- rcards[[1]]
# Testing get_names
get_name(student_rcard, format_type)
names <- lapply(rcards, get_name, format_type)
names[[1]]

debug(get_grades)
get_grades(student_rcard)
undebug(get_grades)

# Testing code for FORMAT2 ------------------------------------------------

list.files('../temp_data', full.names = TRUE, recursive = TRUE)
format_type <- 'format2'
txt <- read_pdf('../temp_data/report_cards/Powell ES Term2 report cards SY14-15.pdf')
rcards <- split_students(txt, format_type = 'format2')
student_rcard <- rcards[[1]]
# Testing get_names
get_name(student_rcard, format_type = 'format2')
names <- lapply(rcards, get_name, format_type = 'format2')
names[[1]]





l <- rcards[[1]][10]
nchar(l)
for (i in 1:nchar(l)) {
  print(paste(i, substr(l, 1, i)))
}



names <- lapply(rcards, get_name)
#########################################
parsed_pdf <-read_pdf('./data/wilson_20140124.pdf')
students_list <- split_students(parsed_pdf)
student_rcard <- students_list[[2]]

test <- get_grades(student_rcard)

test <- test[test$courses != 'Authorized PM Off Campus', ]
test[] <- lapply(test, function(x) {ifelse(x == "", NA, as.character(x))})

lapply(mtcars, function(x) length(unique(x)))


student_rcard <- report_cards[[2]]

test <- get_rcards('./data/report_card.pdf')

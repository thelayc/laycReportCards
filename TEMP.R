library(dplyr)
library(plyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(ggthemes)
library(extrafont)
# Testing code for FORMAT1 ------------------------------------------------

list.files('../temp_data', full.names = TRUE, recursive = TRUE)
format_type <- 'format1'
txt <- read_pdf("../temp_data/report_cards/LAYC-Wilson report cards.pdf")
rcards <- split_students(txt, format_type)
student_rcard <- rcards[[334]]
# Testing get_names
get_name(student_rcard, format_type)
names <- lapply(rcards, get_name, format_type)
names[[334]]

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
#get_name(student_rcard, format_type = 'format2')
names <- lapply(rcards, get_name, format_type = 'format2')
names <- data.frame(sapply(names,c), stringsAsFactors = FALSE)
names <- data.frame(t(names))
#names[[1]]
# Testing get_grades_f2
debug(get_grades_f2)
undebug(get_grades_f2)
get_grades_f2(student_rcard)
## Create a dataframe of topic grades
topics <- lapply(rcards, get_grades_f2)
topics <- do.call("rbind.fill", topics)
topics['value'] <- NULL

## Bind dataframes
powell <- cbind(names, topics)
powell[] <- lapply(powell, as.character)
my_col <- colnames(powell)
my_col <- str_replace_all(my_col, ' ', '.')
colnames(powell) <- my_col

powell %>%
  gather(topic, value, ART_term1:WORLD.LANGUAGE_term4) %>%
  separate(topic, into = c('topic', 'term'), sep= '_') ->
  powell2

# Deal with duplicate "topic" values
powell2$topic[powell2$topic == "SPEAKING.&.LISTENING"] <- "SPEAKING.AND.LISTENING"
powell2$topic[powell2$topic == "WORLD.LANGUAGES.[LATIN]"] <- "WORLD.LANGUAGES"
powell2$topic[powell2$topic == "WORLD.LANGUAGE"] <- "WORLD.LANGUAGES"
powell2$topic[powell2$topic %in% c("HEALTH.&.PHYSICAL", "HEALTH.&.PHYSICAL.EDUCATION")] <- "HEALTH.AND.PHYSICAL.EDUCATION"
# format topic and value
powell2 <- powell2[powell2$value != '', ]
powell2 <- powell2[!is.na(powell2$value), ]
powell2$topic <- tolower(powell2$topic)
powell2$value <- as.numeric(powell2$value)


powell2 %>%
  spread(term, value) %>%
  mutate(change = term2 - term1) ->
  powell2

powell2$topic <- str_replace_all(powell2$topic, '\\.', '_')

powell2$change_ord[powell2$change > 0] <- 'positive'
powell2$change_ord[powell2$change == 0] <- 'no change'
powell2$change_ord[powell2$change < 0] <- 'negative'

powell2$custom_id <- paste0(powell2$fname, powell2$lname)
powell2$custom_id <- tolower(powell2$custom_id)


# match with ETO participants

eto <- laycUtils::load_txt('../temp_data/powell_eto.txt')
eto <- laycUtils::clean_data(eto)
eto$custom_id <- paste0(eto$fname, eto$lname)

eto %>%
  separate(custom_id, into = c('custom_id', 'trash'), by = '-', extra = 'drop') %>%
  select(-trash) %>%
  left_join(powell2, by = 'custom_id') %>%
  select(-(custom_id:lname.y)) %>%
  dplyr::rename(fname = fname.x, lname = lname.x) ->
  powell3

length(unique(powell3$id))

write.csv(powell3, file = '../temp_data/powell.csv', row.names = FALSE, na = '')

# Create plot
my_palette <- c('#e9a3c9', '#bababa', '#a1d76a')
my_title <- ('Powell: Number of students showing positive / negative change in grades\n comparison between Term 1 and Term 2\n breakdown by subject area\n')

p <- ggplot(data = powell3[!is.na(powell3$change_ord), ], aes(x = factor(change_ord)))
p <- p + geom_bar(aes(fill = factor(change_ord)))
p <- p + geom_text(aes(label = ..count.., y = ..count.. + 1), stat = 'bin', size = 3)
p <- p + scale_fill_manual(values = my_palette)
p <- p + facet_wrap(~topic, ncol = 2) + coord_flip()
p <- p + ggtitle(my_title)
p <- p + laycUtils::theme_layc()
p <- p + theme(
  axis.title = element_blank(),
  axis.ticks.x = element_blank(),
  axis.text.x = element_blank(),
  panel.border = element_blank(),
  strip.text = element_text(size = 12),
  #strip.background = element_rect(colour = 'black'),
  legend.position = 'none'
)

p

ggsave(filename = '../temp_data/powell.png', plot = p, width = 30, height = 15, units = 'cm')











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

install.packages("swirl")
library(swirl)
swirl()
install_course("Getting and Cleaning Data")
install_course("Regression Models")
install_course("Statistical Inference")
install_course("Advanced R Programming")

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
library(dplyr)
packageVersion("dplyr")
?tbl_df

cran <- tbl_df(mydf)
rm("mydf")
cran
?select
select(cran, ip_id, package, country)

5:20
select(cran, r_arch:country)
select(cran, country:r_arch)
cran
select(cran, -time)

-5:20
-(5:20)

select(cran, -(X:size))  ## select to subset columns
                         ## filter to subset rows

filter(cran, package == "swirl")
filter(cran, r_version <= "3.0.2", country == "IN")

?Comparison

filter(cran, country =="US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")

!is.na(c(3, 5, NA, 10))

filter(cran, !is.na(r_version))
cran2 <- select(cran, size:ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)
cran3 <- select(cran, ip_id, package, size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb/2^10)
mutate(cran3, correct_size = size + 1000)
summarize(cran, avg_bytes = mean(size))






library(dplyr)
cran <- tbl_df(mydf)
rm("mydf")

cran
?group_by

by_package <- group_by(cran, package)
by_package

summarize(by_package, mean(size))

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
pack_sum

quantile(pack_sum$count, probs = 0.99)

top_counts <- filter(pack_sum, count > 679)
top_counts
View(top_counts)

top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)

quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)
submit()

result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)
submit()

result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)
submit()

View(result3)

names(cran)

cran %>% select(ip_id, country, package, size) %>% print
submit()


cran %>% select(ip_id, country, package, size) %>% mutate(size_mb = size / 2^20)


cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>% print# Your call to filter() goes here
submit()

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>% arrange(desc(size_mb)) %>% print



library(swirl)
swirl()
library(tidyr)

students

?gather

gather(students, sex, count, -grade)

students2

res <- gather(students2, sex_class, count, -grade)
res

?separate

separate(res, sex_class, c("sex", "class"))

students2 %>%
  gather(sex_class ,count ,-grade ) %>%
  separate(sex_class , c("sex", "class")) %>%
  print

students3

students3 %>%
  gather( class, grade , class1:class5 ,na.rm = TRUE) %>%
  print
submit()

?spread

stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocksm <- stocks %>% gather(stock, price, -time)

stocksm
stocksm %>% spread(stock, price)
stocksm %>% spread(time, price)

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test,grade) %>%
  print
submit()

library(readr)
parse_number("class5")

students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  ### Call to mutate() goes here %>%
  mutate(class = parse_number(class)) %>%
  print

students

student_info <- students4 %>%
  select( id, name, sex) %>%
  print
submit()

student_info <- students4 %>%
  select(id, name, sex) %>%
  ### Your code here %>%
  unique() %>%
  print

gradebook <- students4 %>%
  ### Your code here %>%
  select(id, class, midterm, final)%>%
  print

passed
failed

passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")

?bind_rows
bind_rows(passed, failed)

sat

sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
         prop = count / total
  ) %>% print




















































































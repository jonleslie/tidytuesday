library(tidyverse)
library(here)
library(lubridate)

df <- read_csv(here("data", "2019", "2019-12-03", "tickets.csv"))
df

df %>% 
  mutate(date = floor_date(issue_datetime, unit = "day")) %>% 
  select(issue_datetime, date) %>% 
  group_by(date) %>% 
  count() %>% 
  mutate(weekday = wday(date, label = TRUE)) %>% 
  ggplot(aes(x = date, y = n)) +
  geom_line()

df %>% 
  mutate(date = floor_date(issue_datetime, unit = "day")) %>% 
  select(issue_datetime, date) %>% 
  group_by(date) %>% 
  count() %>% 
  mutate(weekday = wday(date, label = TRUE)) %>% 
  ggplot(aes(weekday, n)) +
  geom_boxplot()


# Are there more tickets on Eagles gamedays? ------------------------------

eagles <- ymd("2017-09-24",
              "2017-10-08",
              "2017-10-23",
              "2017-10-29",
              "2017-11-05",
              "2017-11-26",
              "2017-12-25",
              "2017-12-31")

wday(eagles, label = TRUE)

df_date <- df %>% 
  mutate(date = as.Date(ymd_hms(issue_datetime))) %>% 
  select(date) %>% 
  group_by(date) %>% 
  count() %>% 
  mutate(weekday = wday(date, label = TRUE)) %>% 
  mutate(eagles = date %in% eagles)

df_date
table(df_date$date %in% eagles)

df_eagles <- df_date %>% 
  filter(weekday %in% c("Sun", "Mon"))
df_eagles

df_eagles %>% 
  group_by(weekday, eagles) %>% 
  summarise(average = mean(n))

df_eagles %>% 
  ggplot(aes(x = weekday, y = n, fill = eagles)) +
  geom_boxplot() +
  ggtitle("Are more tickets issued on Eagles gamedays?") +
  xlab("day") +
  ylab("count") +
  labs(fill = "Gameday")

# It doesn't seem to be so


# Does the amount of fines issued vary with time? -------------------------

firsts <- unique(floor_date(df_date$date, unit = "month"))

df %>% 
  mutate(date = as.Date(ymd_hms(issue_datetime))) %>% 
  select(date, fine) %>% 
  group_by(date) %>% 
  summarise(total_fines = sum(fine)) %>% 
  ggplot(aes(x = date, y = total_fines)) +
  geom_line() +
  geom_vline(xintercept = firsts[2:12], colour = "red") +
  ggtitle("Total fines in Phili wrt the first of the month")
  
holidays <- ymd(c("2017-01-16",
                  "2017-04-16",
                  "2017-05-29",
                  "2017-07-04",
                  "2017-09-04",
                  "2017-11-10",
                  "2017-11-23",
                  "2017-12-25"))
df %>% 
  mutate(date = as.Date(ymd_hms(issue_datetime))) %>% 
  mutate(week = floor_date(date, unit = "week")) %>% 
  select(week, fine) %>% 
  group_by(week) %>% 
  summarise(total_fines = sum(fine)) %>% 
  ggplot(aes(x = week, y = total_fines)) +
  geom_line() +
  geom_vline(xintercept = firsts[2:12], colour = "red") +
  geom_vline(xintercept = holidays, colour = "blue") +
  geom_vline(xintercept = ymd("2017-03-14"), colour = "green") +
  ggtitle("Total fines in Phili wrt the first of the month")

df %>% 
  mutate(date = as.Date(ymd_hms(issue_datetime))) %>% 
  mutate(week = floor_date(date, unit = "week")) %>% 
  select(week, fine, issuing_agency) %>% 
  group_by(week, issuing_agency) %>% 
  summarise(total_fines = sum(fine)) %>% 
  ggplot(aes(x = week, y = total_fines, colour = issuing_agency)) +
  geom_line() +
  geom_vline(xintercept = firsts[2:12], colour = "red") +
  geom_vline(xintercept = holidays, colour = "blue") +
  geom_vline(xintercept = ymd("2017-03-14"), colour = "green") +
  ggtitle("Total fines in Phili wrt the first of the month")



# Random stuff with Andras and Deeps --------------------------------------


df %>% 
  filter(issuing_agency == "POLICE")
df %>% 
  filter(issuing_agency == "PPA")

df %>% 
  group_by(issuing_agency) %>% 
  summarise(sum = sum(fine))

x <- table(df$issuing_agency)
y <- as.numeric(x)
names(y) <- names(x)
attributes(y)
names(y)[1] <- "zztop"
y
sort(y)
sort(y, decreasing = TRUE)
names(y)[order(names(y))]
y[order(names(y))]
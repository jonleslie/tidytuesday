library(tidyverse)

dd <- read_csv("week_6/dunkin-donuts/dunkin_donuts.csv")
head(dd)

sb <- read_csv("week_6/directory.csv")
head(sb)

# exploration -------------------------------------------------------------

summary(dd)

dd %>% 
  group_by(e_state) %>% 
  count() %>% 
  ggplot(aes(e_state, n)) +
  geom_col() +
  coord_flip()

dd %>% 
  group_by(e_state) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  ggplot(aes(e_state, n)) +
  geom_col() +
  coord_flip()

dd %>% 
  group_by(e_state) %>% 
  count() %>% 
  forcats::fct_reorder(as.factor(e_state))

dd %>% 
  group_by(e_state) %>% 
  count() %>% 
  mutate(state = forcats::as_factor(e_state))


summary(sb)
sb %>% 
  group_by(`State/Province`) %>% 
  count()

m <- matrix(1:10, nrow = 10, ncol = 1)
v <- 1:10
v2 <- vector(mode = numeric, 1:10)
v
cv <- c("one", "two", "three")

library(tidyverse)

df <- read_csv("../tidytuesday/data/2018-11-27/baltimore_bridges.csv")
df
names(df)

df %>% 
  ggplot(aes(x = as.factor(bridge_condition), y = yr_built)) +
  geom_point(alpha = 0.1) +
  geom_jitter(alpha = 0.1)

df %>% 
  group_by(yr_built) %>% 
  ggplot(aes(yr_built, as_factor(bridge_condition))) +
  geom_boxplot()

names(df)
summary(df$vehicles)
head(df$vehicles)

df %>% 
  ggplot(aes(x = bridge_condition, y = total_improve_cost_thousands)) +
  geom_boxplot()

df %>% 
  filter(total_improve_cost_thousands > 10000) %>% 
  ggplot(aes(x = log(total_improve_cost_thousands), colour = bridge_condition)) +
  geom_density()

df %>% 
  ggplot(x = yr_built, y = )

levels(as_factor(df$bridge_condition))
forcats::fct_reorder(df$bridge_condition, .fun = c(3, 1, 2))
example(fct_reorder())
example("fct_reorder")
fct_relevel(.f = df$bridge_condition, "fair", after = "good")
example("fct_relevel")
f
fct_relevel(f)
fct_relevel(f, "c")
f
fct_relevel(f, "b", "a")
fct_relevel(df$bridge_condition)

df$bridge_condition <- as_factor(df$bridge_condition)
df
levels(df$bridge_condition)
df$bridge_condition <- fct_relevel(df$bridge_condition, "Poor")
names(df)
levels(df$bridge_condition)
df
glimpse(df)
levels(as_factor(df$county))

fix_county <- function(x){
  for(i in 1:length(x)) {
    if(x[i] == "Baltimore city") {
      x[i] <- "Baltimore City"
    }
  }
  return(x)
}
fix_county <- function(x){
  if(x == "Baltimore city") {
    x <- "Baltimore City"
  }
  return(x)
}

df$county
table(df$county)
df %>% 
  select(county) %>% 
  filter(county == "Baltimore city") %>% 
  map(., ~ fix_county())

test <- df$county[1]  
test
fix_county(test)
test2 <- "Baltimore city"
fix_county(test2)
fix_county(df$county)
table(map_chr(df$county, fix_county))

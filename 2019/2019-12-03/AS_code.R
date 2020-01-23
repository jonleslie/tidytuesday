library(tidyverse)
install.packages("devtools", dependencies = TRUE)
devtools::install_github("thebioengineer/tidytuesdayR")
tuesdata <- tidytuesdayR::tt_load("2019-12-03")

str(tuesdata)
colnames(tuesdata)
typeof(tuesdata)
print(tuesdata[1])
print(length(tuesdata))

summary(tuesdata)
glimpse(tuesdata)

# To access an element in a list, use [[ ]]!! 
tickets <- tuesdata[[1]]
typeof(tickets)
summary(tickets)
names(tickets)
# A dataframe is a list of vectors where the vectors are the columns of the dataframe. 
# By the way, tickets is a tibble, not a dataframe. 
print(length(tickets))

print(tickets$issue_datetime)
tickets[2]
print(colnames(tickets))



# Unique elements in issuing_agency and violations:
unique(tickets$issuing_agency)
unique(tickets$violation_desc)
# Returns a vector, so we can ask the length of these:
length(unique(tickets$issuing_agency))
length(unique(tickets$violation_desc))

# The number of tickets by issuing agency:
table(tickets$issuing_agency)

# How many tickets did the different agencies give out? 
data.frame(table(tickets$issuing_agency)) %>% ggplot(aes(Var1, Freq)) + geom_col()
# Same thing but simpler:
tickets %>% ggplot(aes(issuing_agency)) + geom_bar()


# Do different agencies charge more? 
# Plots of fine amounts issued by agencies: 
tickets %>% ggplot(aes(issuing_agency, fine)) + geom_point()
hist(tickets$fine)
tickets %>% ggplot(aes(issuing_agency, fine)) + geom_boxplot()
tickets %>% ggplot(aes(issuing_agency, fine)) + geom_boxplot() + scale_y_continuous(trans='log10')
tickets %>% ggplot(aes(issuing_agency, fine)) + geom_boxplot() + scale_y_continuous(limits = c(0,150))

# Plotting genius:
g <- tickets %>% 
  ggplot(aes(x = issuing_agency, y = fine)) +
  geom_boxplot() +
  scale_y_continuous(trans = "log10")
p <- g +
  ggtitle("TidyThursday 2019-12-10") +
  theme(plot.title = element_text(size = 20, face = "bold"))
p
ggsave("2019/2019-12-03/AS_plot_02.jpeg", 
       plot = p, 
       device = "jpeg",width = 11, height = 6.5)



# There are a few really large fines, what are these? 
tickets[(tickets$fine>500),]
high_fines <- tickets[(tickets$fine>500),]
# This returns another tbl 
# What are these violations?
unique(high_fines$violation_desc)
# Faking parking permit! Severe crime! 

# What are the moderate fine charges? 
moderate_fines <- tickets[(tickets$fine>250 & tickets$fine<350),]
tickets[(tickets$fine>250 & tickets$fine<350),]$violation_desc %>% unique()
tickets[(tickets$fine>250 & tickets$fine<350),]$violation_desc %>% table()
# Mostly parking in reserved space, secondly it's abandoned vehicles. 


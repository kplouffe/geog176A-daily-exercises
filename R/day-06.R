#Kyler Plouffe
#8/11/202
#Creating aesthetically pleasing graphs

library(tidyverse)

library(ggplot2)

install.packages("ggthemes")
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  head()
  slice_max(cases, n = 6) %>%
  pull(state) ->
  top_states
covid %>%
  filter(state %in% top_states) %>%
  group_by(state, date) %>%
  summarise(cases = sum(cases)) %>%
  head()
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size = 2) +
  facet_wrap(~state) +
  ggthemes::theme_solarized() +
  theme(legend.position = 'NA') +
  labs(title = "States with the Most Case Counts",
       subtitle = "Data Source: NY-Times",
       x = "Date",
       y = "Cases")
  ggsave(file="img/worst_state_counts.png")
#making the second graph
covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(fill = "blue", color = "blue", alpha = .3) +
  geom_line(color = "blue", size = 4) +
  ggthemes::solarized() +
  labs(title = "National Total Case Counts",
         x = "Date",
         y = "Cases")
  ggsave(file="img/national_case_counts.png")

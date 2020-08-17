#Kyler Plouffe
#8/16/2020
#Making a rolling average graph

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(zoo)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)

state.of.interest = "Utah"
covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarise(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases),
         roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "#81b6db") +
  geom_line(aes(y = roll7), col = "darkblue", size = 1) +
  ggthemes::theme_solarized() +
  labs(title = paste("New Reported Cases by Day in", state.of.interest), y= "# of New Cases", x="Date") +
  theme(plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(size = 14, face = 'bold')) +
  theme(aspect.ratio = .5)

ggsave(file="img/cases-by-day-in-utah.png")

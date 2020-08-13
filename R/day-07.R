#Kyler Plouffe
#8/12/2020
#Using join functions to create new data.frames

library(tidyverse)
library(ggplot2)
library(ggthemes)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)

region = data.frame(state = state.name, region = state.region)

head(region)

covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases  = sum(cases),
            deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) ->
  regional_covid

ggplot(regional_covid, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_solarized() +
  theme(legend.position = "right") +
  labs(title = "Total Cases and Deaths by Region",
       y = "Daily Total",
       x = "Date",
       subtitle = "COVID-19 Data: NY-Times" )
  ggsave(file="img/by_region.png")

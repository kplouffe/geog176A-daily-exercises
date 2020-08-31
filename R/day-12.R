#Kyler Plouffe
#8/23/2020
#spatially filtering

#SPDS
library(tidyverse)
library(sf)
library(units)

# Data
library(USAboundaries)
library(rnaturalearth)

# Visualization
library(gghighlight)
library(ggrepel)
library(knitr)

states = us_states()
utah = filter(states, name == "Utah")
mutate(states,
        deim9 = st_relate(states, utah),
        touch = st_touches(states, utah, sparse = F)) %>%
  names(touch == TRUE)


colorado = filter(states, name == "Colorado")
ggplot(states %>%
         filter(!name %in% c("Puerto Rico",
                                   "Alaska",
                                   "Hawaii"))) +
  geom_sf() +
  geom_sf(data = colorado, fill = "red", alpha = .2) +
  geom_sf(data = st_filter(states, colorado, .predicate = st_touches), fill = "blue", alpha = .5) +
  theme_void()
ggsave(file="img/states_touch_CO.png")

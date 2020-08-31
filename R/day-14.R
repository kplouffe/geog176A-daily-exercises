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

library(rmapshaper)

get_conus = function(data, var){
  conus = filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
  return(conus)
}

cities = read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  select(city)

polygon = get_conus(USAboundaries::us_states(), "name") %>%
  select(name)

cj = st_join(polygon, cities) %>%
  st_drop_geometry() %>%
  count(name) %>%
  left_join(polygon, by = 'name') %>%
  st_as_sf()

point_in_polygon3 = function(points, polygon, group){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(group)) %>%
    setNames(c(group, "n")) %>%
    left_join(polygon, by = group) %>%
    st_as_sf()
}

counties = get_conus(us_counties(), "state_name") %>%
  st_transform(st_crs(cities))
city_pip = point_in_polygon3(cities, counties, "geoid")

plot(city_pip['n'])

ggsave(file="img/pips.png")

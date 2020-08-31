#Kyler Plouffe
#8/23/2020
#using simplification functions

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

library(rmapshaper)

usa = USAboundaries::us_states() %>%
  filter(!stusps %in% c("AK", "HI", "PR")) %>%
  st_union() %>%
  st_transform(5070)

usa1500   = st_simplify(usa, dTolerance = 15000)
usa10000  = st_simplify(usa, dTolerance = 100000)
usa100000 = st_simplify(usa, dTolerance = 1000000)

usa10 = ms_simplify(usa, keep = .1)
usa5  = ms_simplify(usa, keep = .05)
usa1  = ms_simplify(usa, keep = .01)

plot(usa1500)
print(mapview::npts(usa1500))

plot(usa5)
print(mapview::npts(usa1))

plot(usa)
print(mapview::npts(usa))

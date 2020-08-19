#Kyler Plouffe
#8/18/2020
#casting a CONUS

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(zoo)
library(sf,stars, units, raster, mapview, leaflet, gdalUtilities)
library(whitebox)
conus = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico",
                            "Alaska",
                            "Hawaii"))

us_c_ml = st_combine(conus) %>%
  st_cast("MULTILINESTRING")
us_u_ml = st_union(conus) %>%
  st_cast("MULTILINESTRING")

#Kyler Plouffe
#8/20/2020
#calculating distance between points

library(tidyverse)
library(ggplot2)
library(ggthemes)
library(zoo)
library(sf)
library(sf, stars, units, raster, mapview, leaflet, gdalUtilities)
library(whitebox)
library(raster)
library(readr)
library(units)
homes = readr::read_csv("uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Santa Barbara", "Carmichael"))

st_distance(homes)

st_distance(st_transform(homes, 5070))

st_distance(st_transform(homes, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))

st_distance(homes)

(st_distance(homes) %>%
    set_units("km") %>%
    drop_units())

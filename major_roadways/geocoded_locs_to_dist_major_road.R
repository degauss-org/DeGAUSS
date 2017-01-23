#!/usr/bin/Rscript

suppressPackageStartupMessages(library(argparser))
p <- arg_parser('return distance to nearest major roadway for geocoded CSV file')
p <- add_argument(p,'file_name',help='name of geocoded csv file')
args <- parse_args(p)

suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))

message('(down)loading major roadway shapefile...')
shp.roads <- tigris::primary_roads() %>% 
  spTransform(CRS('+init=epsg:5072'))

message('loading and projecting input file...')
d <- read.csv(args$file_name,stringsAsFactors=FALSE)
# d <- read.csv('test_addresses_geocoded.csv',stringsAsFactors=FALSE)

coordinates(d) <- c('lon','lat')
proj4string(d) <- CRS('+init=epsg:4326')
d <- spTransform(d,CRS('+init=epsg:5072'))

message('finding distance to major roadway (in meters) for each point...')

dists <- rgeos::gDistance(d,shp.roads,byid=c(TRUE,FALSE))

d@data$dist_to_major_road <- dists %>% as.vector

out.file <- d %>% spTransform(CRS('+init=epsg:4326')) %>% as.data.frame

out.file.name <- paste0(gsub('.csv','',args$file_name,fixed=TRUE),'_disttomajorroadway.csv')
write.csv(out.file,out.file.name,row.names=F)

message('FINISHED! output written to ',out.file.name)

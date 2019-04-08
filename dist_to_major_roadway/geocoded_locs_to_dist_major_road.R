#!/usr/local/bin/Rscript

setwd('/tmp')

suppressPackageStartupMessages(library(argparser))
p <- arg_parser('return distance to nearest major roadway for geocoded CSV file')
p <- add_argument(p,'file_name',help='name of geocoded csv file')
args <- parse_args(p)

suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))

# create memoised version of functions using local persistent cache
suppressPackageStartupMessages(library(memoise)) # note: requires gh version of this package

lc <- cache_filesystem('/tmp/degauss_cache')
primary_roads <- memoise(tigris::primary_roads,cache=lc)
gDistance <- memoise(rgeos::gDistance,cache=lc)

message('\n(down)loading major roadway shapefile...\n')
shp.roads <- primary_roads() %>% 
  spTransform(CRS('+init=epsg:5072'))

message('\nloading and projecting input file...\n')
d <- read.csv(args$file_name,stringsAsFactors=FALSE)
# d <- read.csv('test_addresses_geocoded.csv',stringsAsFactors=FALSE)

d_cc <- complete.cases(d[ ,c('lat','lon')])

if (! all(d_cc)) {
        message('WARNING: input files contains missing coordinates, these rows will be omitted from output.')
        d <- d[d_cc, ]
}

coordinates(d) <- c('lon','lat')
proj4string(d) <- CRS('+init=epsg:4326')
d <- spTransform(d,CRS('+init=epsg:5072'))

message('\nfinding distance to major roadway (in meters) for each point...\n')

dists <- gDistance(d,shp.roads,byid=c(TRUE,FALSE))

d@data$dist_to_major_road <- dists %>% as.vector

out.file <- d %>% spTransform(CRS('+init=epsg:4326')) %>% as.data.frame

out.file.name <- paste0(gsub('.csv','',args$file_name,fixed=TRUE),'_disttomajorroadway.csv')
write.csv(out.file,out.file.name,row.names=F)

message('\nFINISHED! output written to ',out.file.name)

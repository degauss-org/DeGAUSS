#!/usr/bin/Rscript

setwd('/tmp')

suppressPackageStartupMessages(library(argparser))
p <- arg_parser('return census tracts for geocoded CSV file')
p <- add_argument(p,'file_name',help='name of geocoded csv file')
args <- parse_args(p)

suppressPackageStartupMessages(library(tigris))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))

# this will be in the docker image so it won't redownloaded everytime
message('\n(down)loading all county shapefiles...\n')
shp.counties <- tigris::counties() %>% 
  spTransform(CRS('+init=epsg:5072'))

message('\nloading and projecting input file...\n')
d <- read.csv(args$file_name,stringsAsFactors=FALSE)
# d <- read.csv('test_addresses_geocoded.csv',stringsAsFactors=FALSE)
# d <- read.csv('test_addresses_geocoded_disttomajorroadway.csv',stringsAsFactors=FALSE)

d_cc <- complete.cases(d[ ,c('lat','lon')])

if (! all(d_cc) {
	message('WARNING: input files contains missing coordinates, these rows will be omitted from output.')
        d <- d[d_cc, ]
}

coordinates(d) <- c('lon','lat')
proj4string(d) <- CRS('+init=epsg:4326')
d <- spTransform(d,CRS('+init=epsg:5072'))


message('\nfinding necessary counties...\n')
d$county <- sp::over(d,shp.counties)$GEOID
counties_needed <- unique(d$county)

message(paste('\n(down)loading tract shapefiles for counties',paste(counties_needed,collapse=', ')))

shps.tracts <- map(counties_needed,function(x) {
  message('\n',x,'\n')
  tigris::tracts(state=substr(x,1,2),county=substr(x,3,5)) %>% 
    spTransform(CRS('+init=epsg:5072'))
  }) %>% 
  set_names(counties_needed)

message('\nfinding census tract for each point...')
d$tract <- NA
for (x in counties_needed) {
  message('\n',x,'...')
  d[d$county == x,'tract'] <- sp::over(d[d$county == x, ],shps.tracts[[x]])$GEOID
}

out.file <- d %>% spTransform(CRS('+init=epsg:4326')) %>% as.data.frame

out.file.name <- paste0(gsub('.csv','',args$file_name,fixed=TRUE),'_censustracts.csv')
write.csv(out.file,out.file.name,row.names=F)

message('\nFINISHED! output written to ',out.file.name)

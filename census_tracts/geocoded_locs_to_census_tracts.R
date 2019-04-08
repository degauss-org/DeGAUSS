#!/usr/local/bin/Rscript

setwd('/tmp')

suppressPackageStartupMessages(library(argparser))
p <- arg_parser('return census tracts for geocoded CSV file')
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
counties <- memoise(tigris::counties,cache=lc)
tracts  <- memoise(tigris::tracts,cache=lc)
over <- memoise(sp::over,cache=lc)

message('\n(down)loading all county shapefiles...\n')
shp.counties <- counties() %>% 
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


message('\nfinding necessary counties...\n')
d$county <- over(d,shp.counties)$GEOID
counties_needed <- unique(d$county)
counties_needed  <- na.omit(counties_needed)

message(paste('\n(down)loading tract shapefiles for counties',paste(counties_needed,collapse=', ')))

shps.tracts <- map(counties_needed,function(x) {
  message('\n',x,'\n')
  tracts(state=substr(x,1,2),county=substr(x,3,5)) %>% 
    spTransform(CRS('+init=epsg:5072'))
  }) %>% 
  set_names(counties_needed)

d_c_tract <- complete.cases(as.data.frame(d[ ,'county']))

if (! all(d_c_tract)) {
  message('WARNING: some coordinates were not able to be assigned to a county, these rows will be omitted from output.')
  d <- d[d_c_tract, ]
}

message('\nfinding census tract for each point...')
d$tract <- NA
for (x in counties_needed) {
  message('\n',x,'...')
  d[d$county == x,'tract'] <- over(d[d$county == x, ],shps.tracts[[x]])$GEOID
}

out.file <- d %>% spTransform(CRS('+init=epsg:4326')) %>% as.data.frame

out.file.name <- paste0(gsub('.csv','',args$file_name,fixed=TRUE),'_censustracts.csv')
write.csv(out.file,out.file.name,row.names=F)

message('\nFINISHED! output written to ',out.file.name)

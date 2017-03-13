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

message(paste('\n(down)loading tract shapefiles for counties',paste(counties_needed,collapse=', ')))

shps.tracts <- map(counties_needed,function(x) {
  message('\n',x,'\n')
  tracts(state=substr(x,1,2),county=substr(x,3,5)) %>% 
    spTransform(CRS('+init=epsg:5072'))
  }) %>% 
  set_names(counties_needed)

message('\nfinding census tract for each point...')
d$tract <- NA
for (x in counties_needed) {
  message('\n',x,'...')
  d[d$county == x,'tract'] <- over(d[d$county == x, ],shps.tracts[[x]])$GEOID
}

out.file <- d %>% spTransform(CRS('+init=epsg:4326')) %>% as.data.frame


message('\ndownloading Median household income in the past 12 months (in 2015 Inflation-adjusted dollars) from 2015 5-year American Community Survey\n')

## get census info from 2015 ACS 5-year data API
eMERGE_census_API_key <- '400ebfb0fc89448797851b6a3e31334a315f4168'

get_ACS_data <- function(county_fips,variable='B19013_001E') {
  the_call <- paste0('http://api.census.gov/data/2015/acs5?get=NAME,',
                     variable,
                     '&for=tract:*&',
                     'in=state:',substr(county_fips,1,2),
                     '&in=county:',substr(county_fips,3,5),
                     '&key=',eMERGE_census_API_key)
  the_results <- jsonlite::fromJSON(the_call) %>% 
    data.frame(stringsAsFactors=FALSE)
  names(the_results) <- the_results[1, ]
  the_results <- the_results[-1, ]
  return(the_results)
}
get_ACS_data <- memoise(get_ACS_data,cache=lc)

acs_data <- map_df(unique(d$county),get_ACS_data)
acs_data$tract <- paste0(acs_data$state,acs_data$county,acs_data$tract)

message('\nmerging into output file\n')

out.file <- merge(out.file,acs_data[ ,c('B19013_001E','tract')],by='tract',all.x=TRUE,all.y=FALSE)
  
out.file.name <- paste0(gsub('.csv','',args$file_name,fixed=TRUE),'_medianhouseholdincome.csv')
write.csv(out.file,out.file.name,row.names=F)

message('\nFINISHED! output written to ',out.file.name)

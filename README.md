# DeGAUSS

[![Build Status](https://travis-ci.org/cole-brokamp/DeGAUSS.svg?branch=master)](https://travis-ci.org/cole-brokamp/DeGAUSS)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![status](http://joss.theoj.org/papers/51cadcd9bce9b42b6164e71cf708eb81/status.svg)](http://joss.theoj.org/papers/51cadcd9bce9b42b6164e71cf708eb81)
[![DOI](https://zenodo.org/badge/79760093.svg)](https://zenodo.org/badge/latestdoi/79760093)

**De**centralized **G**eomarker **A**ssessment for M**u**lti-**S**ite **S**tudies  

Questions? Problems? Please [file an issue](https://github.com/cole-brokamp/DeGAUSS/issues/new) on GitHub or [read the wiki](https://github.com/cole-brokamp/DeGAUSS/wiki) for troubleshooting tips, address formatting best practices, and help with interpreting geocoding results.

## About

Scientific studies often examine the relationships between place-based information and health outcomes; for example, air pollution and asthma, neighborhood crime and mental health, or community greenspace and IQ. Study subjects with location information, most commonly a residential mailing address, are linked to databases of place-based information, or "geomarkers" in order to conduct these studies. Defined formally, a "geomarker" is any objective, contextual or geographic measure that influences or predicts the incidence of outcome or disease. "Geocoding" is the process of translating a string of text referring to a location (most often a mailing address) into coordinates on the earth's surface (most often latitude and longitude). These coordinates are required to link participants to their estimated exposures to geomarkers -- a process we call "geomarker assessment". Some examples of geomarker assessment commonly performed in health studies using people include distance to the nearest major roaday -- a commonly used as a measure of estimated exposure to traffic related air pollution that is associated with increased risk of asthma -- or  neighborhood median household income -- a commonly used as a measure of community deprivation associated with increased bed days spent in the hospital.

Within these health studies, both geocoding and geomarker assessment involve the use of identifying information (addresses and location coordinates) and therefore must be conducted in a HIPAA and IRB compliant manner. These laws were designed to protect the privacy of study participants by preventing the sharing of a myriad of protected health information (PHI). While beneficial with repsect to privacy, this prevents an outstanding challenge for researchers by preventing them from using external third party software, e.g. Google Maps, to analyze and extract information from study participants' adddresses or locations. Furthermore, this restricts scientists' ability to collaborate by combining datasets containing any PHI. We are critically missing standard ways to make this easy.

Our solution is a standalone, container-based application that can produce geocodes and conduct geomarker assessment. A container is a platform that wraps software into a complete filesystem containing everything it needs to run. For geocoding and geomarker assessment, this includes code, runtime, system tools, system libraries (shapefiles, databases, rasters, etc...) and data. Usable on PC, Mac, or Linux machines, researchers can use DeGAUSS containers to geocode and conduct geomarker assessment without PHI ever leaving their local machine. After geomarkers are attached to subjects' health information, personal identifiers like address or location coordinates are removed, effectively making the dataset no longer PHI and not subject to HIPAA or privacy concerns. This facilitates sharing and collaboration among scientists without privacy concerns over PHI. In addition, the use of containers guarantees the software will always run the same, regardless of its environment, which is a vital requirement for reproducible research, especially within in a collaborative, multi-site study.

## Citation

If you use this software in a scientific publication, please cite the following peer-reviewed manuscript:

Cole Brokamp, Chris Wolfe, Todd Lingren, John Harley, Patrick Ryan. Decentralized and Reproducible Geocoding and Characterization of Community and Environmental Exposures for Multi-Site Studies. *Journal of American Medical Informatics Association*. 25(3). 309-314. 2018. [*Download*](https://colebrokamp-website.s3.amazonaws.com/publications/Brokamp_JAMIA_2017.pdf).

## Currently Available Images

**image** |  **description** | **size** | **link** | **build status** |
|:---------------|:-------------------------|:-----:|:-----:|:------:|
`degauss/geocoder` | batch geocoding | [![](https://images.microbadger.com/badges/image/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder) | [![](https://images.microbadger.com/badges/version/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder/) | [![](https://img.shields.io/docker/automated/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder/builds)
`degauss/geocoder_slim` | return geocoded text string as JSON | [![](https://images.microbadger.com/badges/image/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder) | [![](https://images.microbadger.com/badges/version/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder_slim/) | [![](https://img.shields.io/docker/automated/degauss/geocoder_slim.svg)](https://hub.docker.com/r/degauss/geocoder_slim/builds)
`degauss/census_tracts`  | census tract FIPS ID | [![](https://images.microbadger.com/badges/image/degauss/census_tracts.svg)](https://microbadger.com/images/degauss/census_tracts) | [![](https://images.microbadger.com/badges/version/degauss/census_tracts.svg)](https://hub.docker.com/r/degauss/census_tracts/) | [![](https://img.shields.io/docker/automated/degauss/census_tracts.svg)](https://hub.docker.com/r/degauss/census_tracts/builds)
`degauss/dist_to_major_roadway` | distance to TIGER/Line 2015 S1100 line in meters | [![](https://images.microbadger.com/badges/image/degauss/dist_to_major_roadway.svg)](https://microbadger.com/images/degauss/dist_to_major_roadway) | [![](https://images.microbadger.com/badges/version/degauss/dist_to_major_roadway.svg)](https://hub.docker.com/r/degauss/dist_to_major_roadway/) | [![](https://img.shields.io/docker/automated/degauss/dist_to_major_roadway.svg)](https://hub.docker.com/r/degauss/dist_to_major_roadway/builds)
`degauss/acs_income` | census tract median household income from 2015 5-year ACS | [![](https://images.microbadger.com/badges/image/degauss/acs_income.svg)](https://microbadger.com/images/degauss/acs_income) | [![](https://images.microbadger.com/badges/version/degauss/acs_income.svg)](https://hub.docker.com/r/degauss/acs_income/) | [![](https://img.shields.io/docker/automated/degauss/acs_income.svg)](https://hub.docker.com/r/degauss/acs_income/builds)

## Install Docker

#### Linux

If using Linux, install Docker on your machine following the instructions [here](https://www.docker.com/products/overview#/install_the_platform).

#### Windows or macOS

If using Windows or macOS, download and install [Docker Toolbox](https://www.docker.com/products/docker-toolbox).

*Note: Docker is natively supported on most linux distributions, but requires Microsoft Windows 10 Professional or Enterprise 64-bit if you are using Windows and Apple macOS Yosemite 10.10.3 or or above if you are using Apple.  All of the DeGAUSS images should run without problems on the native version of Docker and on Docker Toolbox; however, we recommend using Docker Toolbox to minimize issues and potential problems if you are not familiar with the command line or using docker in general.*

#### Troubleshooting Common Installation Problems

- If you are trying to install on Windows and receive the error message `docker computer does not have VT-X/AMD-v enabled, enabling it in BIOS is mandatory` when trying to startup the virtual box / Docker Quickstart Terminal, then you need to boot into your computer's BIOS settings and enable VT-X. If you are unsure how to boot into your BIOS settings try rebooting your computer and hold down F2 while it restarts.  It should look something like [this](https://goo.gl/images/rPbKVd) but will be different depending on the exact make and model of your computer.
- Do not attempt to use Docker Toolbox when connected to a virtual network (i.e. remoting in to a work machine from home) or when using a proxy.  Docker Toolbox works by communicating with a virtual machine and these settings will cause problems.

## Using Docker

To test your installation, open the Docker Quickstart Terminal Application (or a shell if using Linux).  This is usually installed to your Applications or Programs folder and there is also often a shortcut created on the Desktop. 

Run `docker run hello-world` and you should see some output describing what Docker did and that it is working correctly.

Notice that after asking Docker to run a container, if it does not find the image locally, it downloads it from an online repository. This is only necessary the first time you run a container from each image.  Once downloaded, Docker will continue to use the same local image to create containers. 

## Gecoding with DeGAUSS

### Input File

The input file must be a CSV file with a column containing an address string. Other columns may be present and will be returned in the output file, but should be kept to a minimum to reduce file size.

An example input CSV file (called `my_address_file.csv`) might look like:

	id,address
    001,3333 Burnet Ave Cincinnati OH 45229
    002,660 Lincoln Avenue Cincinnati OH 45229
    003,2800 Winslow Avenue Cincinnati OH 45206

Please see our [geocoding documentation](http://colebrokamp.com/posts/geocoding_tips.html) for more information on the geocoding process, how to interpret the output, and tips for getting the best results.

### Geocoding

After opening the Docker Quickstart Terminal (or in a shell on linux), navigate to the directory where the CSV file to be geocoded is located. See [here](http://linuxcommand.org/lc3_lts0020.php) for help on navigating a filesystem using the command line. 

For those unfamiliar with the command line, the simplest approach might be to put the file to be geocoded on the desktop and then navigate to your desktop folder after starting the Docker Quickstart Terminal with `cd Desktop`.

Run: 

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/geocoder <name-of-file> <address-column-name>
```

replacing `<name-of-file>` with the name of the CSV file to be geocoded and `<address-column-name>` with the name of the column in the CSV file that contains the address strings.

Continuing on our example address file above, we can use:

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/geocoder my_address_file.csv address
```

To avoid headaches don't use a file with spaces in the filename or address column name. When issuing the geocoding docker command make sure to include the `.csv` filename extension even if they don't show up in your system file browser. 

If run successfully, the shell should show a progress bar while geocoding and the geocoded file will be written to the current working directory named similarly to the input file but with `_geocoded` appended to the file name.

Don't forget that if calling this image for the first time, Docker will have to download the image before starting the geocoding process.  Although it is quite a large download (~ 6 GB), this only has to happen one time.

Our output file is written to the same directory and in our example, will be called `my_address_file_geocoded.csv`:

```
"address","id","street","zip","city","state","lat","lon","score","prenum","number","precision"
"2800 Winslow Avenue Cincinnati OH 45206","003","Winslow Ave","45206","Cincinnati","OH",39.130586,-84.49631,0.941,"","2800","range"
"3333 Burnet Ave Cincinnati OH 45229","001","Burnet Ave","45229","Cincinnati","OH",39.14089,-84.500402,0.949,"","3333","range"
"660 Lincoln Avenue Cincinnati OH 45229","002","Lincoln Ave","45206",NA,NA,39.13282,-84.494724,0.805,"","660","range"
```

This output file will also contain diagnostic information on the precision and method used for geocoding each address.  See [here](https://colebrokamp.com/posts/geocoding_tips.html) for more details on interpreting the output. These geocodes can be used to create maps of subject locations or can be further passed onto other DeGAUSS containers for geomarker assessment.

## Geomarker Assessment with DeGAUSS

The geomarker assessment images will only work with the output of the geocoding docker image (or a CSV file with columns named `lat` and `lon`).  In a similar fashion as above, navigate to the directory where the geocoded CSV file is located. If you are running geomarker assessment right after geocoding and using the same Quickstart Terminal, the files will be in the same location, so no further navigation is necessary.

Run:

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/<name-of-image> <name-of-geocoded-file>
```

Continuing with our usage example, if we wanted to calculate the median household income of each of the subjects' census tracts, we would use:

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/acs_income my_address_file_geocoded.csv
```

Docker will emit some messages as it progresses through the calculations and will again write the file to the working directory with a descriptive name appended (in this case the median household income from the 2015 American Community Survey based on the census tract of each location).

Again, our output file will be written into the same directory as our input file.  In our example above, this will be called `my_address_file_geocoded_medianhouseholdincome.csv`:

```
"tract","address","id","street","zip","city","state","score","prenum","number","precision","county","lon","lat","B19013_001E"
"39061027000","2800 Winslow Avenue Cincinnati OH 45206",3,"Winslow Ave",45206,"Cincinnati","OH",0.941,NA,2800,"range","39061",-84.49631,39.130586,"12282"
"39061027000","3333 Burnet Ave Cincinnati OH 45229",1,"Burnet Ave",45229,"Cincinnati","OH",0.949,NA,3333,"range","39061",-84.500402,39.14089,"12282"
"39061027000","660 Lincoln Avenue Cincinnati OH 45229",2,"Lincoln Ave",45206,NA,NA,0.805,NA,660,"range","39061",-84.494724,39.13282,"12282"
```

Please note that the geomarker assesment programs will not return rows that contain missing coordinate values.  Missing coordinate values are possible if the geocoding container failed to assign them, for example, when using a malformed address string. A warning will be issued and the rows with missing coordinates will be removed before proceeding. A user should verify that the address strings have been recorded correctly; however, geocoding sometimes fails even with a correctly supplied address due to inconsistencies and inaccuracies in the street range files provided by the census.

## Deidentifying Data

Now that we have our desired geomarkers, we can remove the addresses and coordinates from our output file, leaving only the geomarker information that will be associated with health outcomes in a downstream analysis:

```
"id","B19013_001E"
3,"12282"
1,"12282"
2,"12282"
```

`B19013_001E` is the variable name used by the census to denote median household income in a census tract -- here, they are all the same becuase our example addresses are all in the same census tract. Since this file no longer contains any PHI, it is no longer subject to HIPAA and can be shared with others or used with third party online services. (*Note: Here, we are applying the "Safe Harbor" method defined by HIPAA for deidentification, but re-identification is certainly possible when enough geomarkers and non-identifying information are combined together. Do not take the use of DeGAUSS as a guarantee of deidentification and please consult your institution for more information relating to their specific policies.*)

## Memoisation

The underlying R code in the Docker images uses the `memoise` package to cache certain function calls to a folder in the working directory called `degauss_cache`. This can be safely deleted after running any container, but if kept and the docker image is called again from the directory containing the cache directory, it will use the cached results rather than redownloading shapefiles or geocoding again.  This can be especially useful when one of many counties fails to download and the entire container process fails.  In this case, running the command again will not require redownloading/recomputation of items that have previously been completed. Because of the support for multithreaded geocoding using the `CB::cb_apply` function, the cache folder for geocoding is called `cache` instead of `degauss_cache`.

## Contributing

Please see `CONTRIBUTING.md` for guidelines on how to contribute to the development of `DeGAUSS`. We welcome additions to our wiki, where we collect common problems and their solutions as well as provide troubleshooting advice. We also welcome new containers using the DeGAUSS framework.  Pull requests are always welcome but early visibility is highly encouraged; we often create containers that are not yet publicly available and would love to still collaborate.

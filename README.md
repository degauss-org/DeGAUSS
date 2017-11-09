# DeGAUSS

[![DOI](https://zenodo.org/badge/79760093.svg)](https://zenodo.org/badge/latestdoi/79760093)
 [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

**De**centralized **G**eomarker **A**ssessment for M**u**lti-**S**ite **S**tudies  

Questions? Problems? Please [file an issue](https://github.com/cole-brokamp/DeGAUSS/issues/new) on GitHub.

## Citation

If you use this software in a scientific publication, please cite the following peer-reviewed manuscript:

Cole Brokamp, Chris Wolfe, Todd Lingren, John Harley, Patrick Ryan. Decentralized and Reproducible Geocoding and Characterization of Community and Environmental Exposures for Multi-Site Studies. *Journal of American Medical Informatics Assocation*. 0(0). 1-6. 2017. [*Download*](https://colebrokamp-website.s3.amazonaws.com/publications/Brokamp_JAMIA_2017.pdf).

## Currently Available Images

**image** |  **description** | **size** | **link** | **build status** |
|:---------------|:-------------------------|:-----:|:-----:|:------:|
`degauss/geocoder` | batch geocoding | [![](https://images.microbadger.com/badges/image/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder) | [![](https://images.microbadger.com/badges/version/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder/) | [![](https://img.shields.io/docker/automated/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder/builds)
`degauss/geocoder_slim` | return geocoded text string as JSON | [![](https://images.microbadger.com/badges/image/degauss/geocoder.svg)](https://microbadger.com/images/degauss/geocoder) | [![](https://images.microbadger.com/badges/version/degauss/geocoder.svg)](https://hub.docker.com/r/degauss/geocoder_slim/) | [![](https://img.shields.io/docker/automated/degauss/geocoder_slim.svg)](https://hub.docker.com/r/degauss/geocoder_slim/builds)
`degauss/census_tracts`  | census tract FIPS ID | [![](https://images.microbadger.com/badges/image/degauss/census_tracts.svg)](https://microbadger.com/images/degauss/census_tracts) | [![](https://images.microbadger.com/badges/version/degauss/census_tracts.svg)](https://hub.docker.com/r/degauss/census_tracts/) | [![](https://img.shields.io/docker/automated/degauss/census_tracts.svg)](https://hub.docker.com/r/degauss/census_tracts/builds)
`degauss/dist_to_major_roadway` | distance to TIGER/Line 2015 S1100 line in meters | [![](https://images.microbadger.com/badges/image/degauss/dist_to_major_roadway.svg)](https://microbadger.com/images/degauss/dist_to_major_roadway) | [![](https://images.microbadger.com/badges/version/degauss/dist_to_major_roadway.svg)](https://hub.docker.com/r/degauss/dist_to_major_roadway/) | [![](https://img.shields.io/docker/automated/degauss/dist_to_major_roadway.svg)](https://hub.docker.com/r/degauss/dist_to_major_roadway/builds)
`degauss/acs_income` | census tract median household income from 2015 5-year ACS | [![](https://images.microbadger.com/badges/image/degauss/acs_income.svg)](https://microbadger.com/images/degauss/acs_income) | [![](https://images.microbadger.com/badges/version/degauss/acs_income.svg)](https://hub.docker.com/r/degauss/acs_income/) | [![](https://img.shields.io/docker/automated/degauss/acs_income.svg)](https://hub.docker.com/r/degauss/acs_income/builds)

## About

Geocoding and geomarker assessment involves the use of identifying information (addresses) and therefore must be conducted in a HIPPA and IRB compliant manner. 

This is an outstanding challenge for multi-site studies because current approaches include getting specific IRB approval for a central site to conduct all analyses, which is a lengthy and sometime unfeasible process, or allowing each site to conduct their own analyses which requires expertise at each site and can result in non-reproducible and inconsistent geocoding and geomarker assessment results.

Our approach is a standalone, container-based application that can produce geocodes and derive community and environmental exposures. Usable on PC, Mac, or Linux machines, identifying information never leaves the local machine. Each study site independently geocodes their own addresses and links exposures, strips any PHI, and then sends de-identified and HIPPA compliant dataset out.

We have implemented this using Docker, a software containerization platform that wraps software into a complete filesystem containing everything needed to run: code, runtime, system tools, system libraries (shapefiles, databases, rasters, etc...). This guarantees the software will always run the same, regardless of its environment, which is a vital requirement for reproducible research in a multi-site study.

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

An example input CSV file might look like:

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

For example, 

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/geocoder my_address_file.csv addresses
```
To avoid headaches don't use a file with spaces in the filename or address column name. When issuing the geocoding docker command make sure to include the `.csv` filename extension even if they don't show up in your system file browser. 

If run successfully, the shell should show a progress bar while geocoding and the geocoded file will be written to the current working directory named similarly to the input file but with `_geocoded` appended to the file name.

Don't forget that if calling this image for the first time, Docker will have to download the image before starting the geocoding process.  Although it is quite a large download (~ 6 GB), this only has to happen one time.

## Geomarker Assessment with DeGAUSS

The geomarker assessment images will only work with the output of the geocoding docker image (or a CSV file with columns named `lat` and `lon`).  In a similar fashion as above, navigate to the directory where the geocoded CSV file is located. If you are running geomarker assessment right after geocoding and using the same Quickstart Terminal, the files will be in the same location, so no further navigation is necessary.

Run:

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/acs_income <name-of-geocoded-file>
```

Docker will emit some messages as it progresses through the calculations and will again write the file to the working directory with a descriptive name appended (in this case the median household income from the 2015 American Community Survey based on the census tract of each location).

To attach the distance (in meters) to the nearest major roadway, run:

```
docker run --rm=TRUE -v "$PWD":/tmp degauss/dist_to_major_roadway <name-of-geocoded-file>
```

Please note that the geomarker assesment programs will not return rows that contain missing coordinate values.  Missing coordinate values are possible if the geocoding container failed to assign them, for example, when using a malformed address string. A warning will be issued and the rows with missing coordinates will be removed before proceeding.

## Memoisation

The underlying R code in the Docker images uses the `memoise` package to cache certain function calls to a folder in the working directory called `degauss_cache`. This can be safely deleted after running any container, but if kept and the docker image is called again from the directory containing the cache directory, it will use the cached results rather than redownloading shapefiles or geocoding again.  This can be especially useful when one of many counties fails to download and the entire container process fails.  In this case, running the command again will not require redownloading/recomputation of items that have previously been completed. Because of the support for multithreaded geocoding using the `CB::cb_apply` function, the cache folder for geocoding is called `cache` instead of `degauss_cache`.

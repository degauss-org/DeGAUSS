# DeGAUSS

**De**centralized **G**eomarker **A**ssessment for M**u**lti-**S**ite **S**tudies  

[![Build Status](https://travis-ci.org/cole-brokamp/DeGAUSS.svg?branch=v0.5)](https://travis-ci.org/cole-brokamp/DeGAUSS)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![status](http://joss.theoj.org/papers/51cadcd9bce9b42b6164e71cf708eb81/status.svg)](http://joss.theoj.org/papers/51cadcd9bce9b42b6164e71cf708eb81)
[![DOI](https://zenodo.org/badge/79760093.svg)](https://zenodo.org/badge/latestdoi/79760093)

*Questions? Problems? Please [file an issue](https://github.com/cole-brokamp/DeGAUSS/issues/new) on GitHub and/or see our [troubleshooting](https://github.com/cole-brokamp/DeGAUSS/wiki/Troubleshooting) guide.*

## About

DeGAUSS is a decentralized method for geocoding and deriving community and individual level environmental characteristics while maintaining the privacy of protected health information. It is a standalone and versatile software application based on containerization.  This means that geomarker assessment is reproducible, standardized, and can be computed on at scale. Importantly, DeGAUSS is executable on a local machine -- it does not require extensive computational resources and PHI is never exposed to a third party or the internet, making it ideal for geomarker assessment in a multi-site study. Please see detailed documentation within the [wiki](https://github.com/cole-brokamp/DeGAUSS/wiki):

- [A background on geocoding, geomarkers, and private health information](https://github.com/cole-brokamp/DeGAUSS/wiki/Background)
- [Installing Docker](https://github.com/cole-brokamp/DeGAUSS/wiki/Installing-Docker)
- [Reproducibility and Versioning](https://github.com/cole-brokamp/DeGAUSS/wiki/Reproducibility-and-Versioning)
- [Geocoding with DeGAUSS](https://github.com/cole-brokamp/DeGAUSS/wiki/Geocoding-with-DeGAUSS)
- [Geomarker Assessment with DeGAUSS](https://github.com/cole-brokamp/DeGAUSS/wiki/Geomarker-Assessment-with-DeGAUSS)
- [Troubleshooting](https://github.com/cole-brokamp/DeGAUSS/wiki/Troubleshooting)
- [Memoisation](https://github.com/cole-brokamp/DeGAUSS/wiki/Memoisation)

## Currently Available Images

| **image** |  **description** | **version** | **source** | **build** |
|-----------|------------------|-------------|------------|------------------|
`degauss/geocoder` | batch geocoding | [![](https://img.shields.io/github/tag-date/cole-brokamp/geocoder.svg?label=&style=flat-square)](https://github.com/cole-brokamp/geocoder/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/geocoder.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/geocoder) | [![](https://img.shields.io/docker/automated/degauss/geocoder.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/geocoder) | 
`degauss/census_tracts`  | census tract FIPS ID | [![](https://img.shields.io/github/tag-date/cole-brokamp/DeGAUSS.svg?label=&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/DeGAUSS.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/tree/master/census_tracts) | [![](https://img.shields.io/docker/automated/degauss/census_tracts.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/census_tracts) | 
`degauss/dist_to_major_roadway` | distance to TIGER/Line 2015 S1100 line in meters | [![](https://img.shields.io/github/tag-date/cole-brokamp/DeGAUSS.svg?label=&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/DeGAUSS.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/tree/master/dist_to_major_roadway) | [![](https://img.shields.io/docker/automated/degauss/dist_to_major_roadway.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/dist_to_major_roadway) | 
`degauss/acs_income` | census tract median household income from 2015 5-year ACS | [![](https://img.shields.io/github/tag-date/cole-brokamp/DeGAUSS.svg?label=&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/DeGAUSS.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/DeGAUSS/tree/master/ACS_income) | [![](https://img.shields.io/docker/automated/degauss/acs_income.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/acs_income) | 
`degauss/geocoder_slim` | return geocoded text string as JSON | [![](https://img.shields.io/github/tag-date/cole-brokamp/geocoder_slim.svg?label=&style=flat-square)](https://github.com/cole-brokamp/geocoder_slim/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/geocoder_slim.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/geocoder_slim) | [![](https://img.shields.io/docker/automated/degauss/geocoder_slim.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/geocoder_slim) | 
| `degauss/cchmc_batch_geocoder` | geocoding, census tract, deprivation index | [![](https://img.shields.io/github/tag-date/cole-brokamp/cchmc_batch_geocoder.svg?label=&style=flat-square)](https://github.com/cole-brokamp/cchmc_batch_geocoder/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/cchmc_batch_geocoder.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/cchmc_batch_geocoder) | [![](https://img.shields.io/docker/automated/degauss/cchmc_batch_geocoder.svg?label=&logo=docker&style=flat-square)](https://cloud.docker.com/u/degauss/repository/docker/degauss/cchmc_batch_geocoder) | 
`degauss/crew_census` | historical census tracts and data built for CREW | [![](https://img.shields.io/github/tag-date/cole-brokamp/crew_census.svg?label=&style=flat-square)](https://github.com/cole-brokamp/crew_census/releases) | [![](https://img.shields.io/github/languages/code-size/cole-brokamp/crew_census.svg?colorB=9cf&label=&logo=github&logoColor=black&style=flat-square)](https://github.com/cole-brokamp/crew_census) | [![Docker Repository on Quay](https://quay.io/repository/degauss/crew_census/status?token=7eaa4f26-4a6c-498f-86d9-dd0e68be5fc4")](https://quay.io/repository/degauss/crew_census)


## Contributing

Please see `CONTRIBUTING.md` for guidelines on how to contribute to the development of `DeGAUSS`. Pull requests for new containers using the DeGAUSS framework are always welcome but early visibility is highly encouraged; we often create containers that are not yet publicly available and would love to still work together. Automated tests for containers are conducted through Travis, see `.travis.yml` for details.

## Citation

If you use this software in a scientific publication, please consider citing one of our publications:

- Cole Brokamp, Chris Wolfe, Todd Lingren, John Harley, Patrick Ryan. Decentralized and Reproducible Geocoding and Characterization of Community and Environmental Exposures for Multi-Site Studies. *Journal of American Medical Informatics Association*. 25(3). 309-314. 2018. [*Download*](https://colebrokamp-website.s3.amazonaws.com/publications/Brokamp_JAMIA_2017.pdf).
- Cole Brokamp. DeGAUSS: Decentralized Geomarker Assessment for Multi-Site Studies. *Journal of Open Source Software*. 2018. [*Download*](https://colebrokamp-website.s3.amazonaws.com/publications/Brokamp_JOSS_2018.pdf).

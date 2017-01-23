# docker run --rm=TRUE -v ${PWD}:/tmp colebrokamp/degauss:census_tracts <geocoded-file-name.csv>

FROM ubuntu:14.04

MAINTAINER Cole Brokamp cole.brokamp@gmail.com

RUN useradd docker \
  && mkdir /home/docker \
  && chown docker:docker /home/docker \
  && addgroup docker staff

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libproj-dev libgdal-dev \
    software-properties-common python-software-properties \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install R
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install r-base-core -y --force-yes \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set default CRAN repo and DL method
RUN echo 'options(repos=c(CRAN = "https://cran.rstudio.com/"), download.file.method="libcurl")' >> /etc/R/Rprofile.site

RUN sudo su - -c "R -e \"install.packages('ghit')\"" 
RUN sudo su - -c "R -e \"ghit::install_github('cole-brokamp/automagic')\""

# run automagic from here
RUN mkdir /temp
COPY . /temp

RUN sudo su - -c "R -e \"setwd('/temp'); automagic::automagic()\""

ENTRYPOINT ["/temp/geocoded_locs_to_census_tracts.R"]
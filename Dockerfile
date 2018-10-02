FROM ubuntu:14.04

MAINTAINER Cole Brokamp cole.brokamp@gmail.com

ONBUILD RUN mkdir /temp
ONBUILD COPY . /temp
ONBUILD RUN R -e "setwd('/temp'); automagic::automagic()"

RUN useradd docker \
  && mkdir /home/docker \
  && chown docker:docker /home/docker \
  && addgroup docker staff

RUN apt-get update && apt-get install -y software-properties-common \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libproj-dev \
    libgeos-dev \
    libgdal-dev \
    liblwgeom-dev \
    libudunits2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install r-base-core -y --force-yes \
  && apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set default CRAN repo and DL method
RUN echo 'options(repos=c(CRAN = "https://cran.rstudio.com/"), download.file.method="libcurl")' >> /etc/R/Rprofile.site

# install devel version of automagic package to install package dependencies
RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('cole-brokamp/automagic')"

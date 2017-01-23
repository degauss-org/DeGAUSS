# docker run --name=censustract --rm=true --volume=$PWD:/tmp colebrokamp/... <geocoded-file-name>

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

# install geo libraries
RUN add-apt-repository -y ppa:ubuntugis/ppa         
RUN apt-get update && apt-get install gdal-bin -y --force-yes \ 
   && apt-get clean \                              
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /

RUN sudo su - -c "R -e \"install.packages('ghit')\"" 
RUN sudo su - -c "R -e \"ghit::install_github('cole-brokamp/automagic')\""
RUN sudo su - -c "R -e \"automagic::automagic()\""

ENTRYPOINT ["/bin/bash", "-c", "./geocoded_locs_to_census_tracts.R $1"]


FROM rocker/geospatial:3.5.3

MAINTAINER Cole Brokamp cole.brokamp@gmail.com

RUN echo 'options(repos=c(CRAN = "https://cran.rstudio.com/"), download.file.method="libcurl")' >> /.Rprofile

RUN R -e "install.packages('automagic')"

ONBUILD RUN mkdir /temp
ONBUILD COPY . /temp
ONBUILD RUN R -e "setwd('/temp'); automagic::automagic()"

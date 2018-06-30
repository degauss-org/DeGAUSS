---
title: 'DeGAUSS: Decentralized Geomarker Assessment for Multi-Site Studies'
tags:
  - container
  - Docker
  - geocoding
  - geomarker
  - reproducible research
authors:
  - name: Cole Brokamp
    orcid: 0000-0003-0872-7098
    affiliation: "1, 2"
affiliations:
 - name: Cincinnati Children's Hospital Medical Center
   index: 1
 - name: University of Cincinnati
   index: 2
date: 28 June 2018
bibliography: paper.bib
---

# Summary

Health studies that utilize geocoding and assessment of any place-based characteristic, e.g. census-tract level income or estimated exposure to ambient air pollution, frequently utilize residential addresses or other geolocation data that are considered protected health information (PHI). The HIPAA privacy rule [@hipaa], the HITECH Act of 2009 [@hitech], and the Federal Policy for the Protection of Human Subjects [@commonrule] establish regulations to safeguard the confidentiality of patients and research subjects when health care providers or researchers use PHI. This is an outstanding challenge for multi-site studies because current approaches include getting institution-specific approval for a central site to conduct all analyses, which is a lengthy and sometime unfeasible process, or allowing each site to conduct their own analyses which requires expertise at each site and can result in non-reproducible and inconsistent geocoding and assessment of place-based characteristics, i.e. geomarkers. 

`DeGAUSS` is a standalone, container-based application that can produce geocodes and derive community and environmental exposures. Usable on PC, Mac, or Linux machines, identifying information never leaves the local machine. Figure 1 illustrates the process of using `DeGAUSS` within a multi-site study. Each study site uses `DeGAUSS` to both independently geocode their own addresses and link in the necessary place-based characteristics, strips any PHI, and then sends de-identified dataset out for analysis. In addition to securing PHI, this guarantees that the software will always run the same, regardless of its environment, which is a vital requirement for reproducible research. 

![Illustration of DeGAUSS application within a multi-site study.](degauss_diagram.jpg)

`DeGAUSS` relies heavily on `R` [@R] and the geospatial packages `sp` [@bivand2005classes], `rgdal` [@rgdal] `tigris` [@tigris], and `tidycensus` [@tidycensus]. The underlying geocoder is based on the `usaddress` geocoder [@cole_brokamp_2017_344621]. It was designed to be used by scientific researchers who wish to collect place-based data on study subjects and patients with a residential address. A proof of concept of the application of `DeGAUSS` within a multi-site study has previously been described [@degaussjamia] and this approach is currently being adopted by several other multi-site cohort studies. Additionally, `DeGAUSS` has found use within the electronic health records of healthcare systems to automate geocoding and assessment of community characteristics and environmental exposures.

`DeGAUSS` is currently licensed under GNU GPLv3, archived on Zenodo with a linked DOI [@cole_brokamp_2017_570873], and is maintained on GitHub (https://github.com/cole-brokamp/DeGAUSS) where users can submit issues and propose their own extensions and additions.

# References

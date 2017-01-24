# DeGAUSS User Instructions

> Decentralized Geomarker Assessment for Multi Site Studies  
> Comments / Questions: cole.brokamp@cchmc.org

## Install Docker

Install Docker on your machine following the instructions here: [https://www.docker.com/products/overview#/install_the_platform](https://www.docker.com/products/overview#/install_the_platform)

*Note: Docker is supported on most linux distributions, but requires Microsoft Windows 10 Professional or Enterprise 64-bit if you are using Windows and Apple macOS Yosemite 10.10.3 or or above if you are using Apple.  If you don't meet these operating system requirements, download and use [Docker Toolbox](https://www.docker.com/products/docker-toolbox) instead.*

## Using Docker

To test your installation, open a shell (using for example Terminal on Mac, or Git Bash on Windows).  If using Docker Toolbox, double click the Docker Quickstart Terminal to get started.

Run `docker run hello-world` and you should see some output describing what Docker did and that it is working correctly.

## Get Access to Private Image Repositories

You must have access to the private image repositories to pull and use them.  In order to this:

- Make an account at http://hub.docker.com
- Run `docker login` at the shell and type in your username and password
- Email your username to [Cole Brokamp](mailto:cole.brokamp@cchmc.org) in order to gain access to the private image repository


## Gecoding with DeGAUSS

### Input File

The input file must be a CSV file with a column containing an address string. Other columns may be present and will be returned in the output file, but should be kept to a minimum to reduce file size.

An example input CSV file might look like:

	id,address
    001,3333 Burnet Ave Cincinnati OH 45229
    002,660 Lincoln Avenue Cincinnati OH 45229
    003,2800 Winslow Avenue Cincinnati OH 45206

Please see our [geocoding documentation](http://colebrokamp.com.s3-website-us-east-1.amazonaws.com/posts_geocoding_tips.html) for more information on the geocoding process, how to interpret the output, and tips for getting the best results.

### Geocoding

At the command line, navigate to the directory where the CSV file to be geocoded is located. See [here](http://linuxcommand.org/lc3_lts0020.php) for help on navigating a filesystem using the command line. To avoid headaches don't use a remote or mounted directory like OneDrive or a shared research drive. Also, avoid spaces in the filename or address column name. When issuing the geocoding docker command make sure to include filename extensions even if they don't show up in your system file browser.

Run: 

```
docker run --rm=TRUE -v=$PWD:/tmp colebrokamp/geocoder <name-of-file> <address-column-name>
```

replacing `<name-of-file>` with the name of the CSV file to be geocoded and `<address-column-name>` with the name of the column in the CSV file that contains the address strings.  For example, 

```
docker run --rm=TRUE -v=$PWD:/tmp colebrokamp/geocoder my_address_file.csv addresses
```

If on a Windows system, use file paths for windows instead of `$PWD`. For example, to use a file on your desktop the file paths for windows would be `/c/Users/<user-name>/desktop`.

If run successfully, the shell should show a progress bar while geocoding and the geocoded file will be written to the current working directory named similarly to the input file but with `_geocoded` appended to the file name.

## Geomarker Assessment with DeGAUSS

The geomarker assessment images will only work with the output of the geocoding docker image (or a CSV file with columns named `lat` and `lon`).  In a similar fashion as above, navigate to the directory where the geocoded CSV file is located.

Run:

```
docker run --rm=TRUE -v=$PWD:tmp colebrokamp/degauss:census_tracts <name-of-geocoded-file>
```

Docker will emit some messages as it progresses through the calculations and will again write the file to the working directory with a descriptive name appended.

To attach the distance (in meters) to the nearest major roadway, run:

```
docker run --rm=TRUE -v=$PWD:tmp colebrokamp/degauss:dist_to_major_roadway <name-of-geocoded-file>
```

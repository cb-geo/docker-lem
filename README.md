# Docker image for Lattice Element Method
> Krishna Kumar

[![Quay image](https://img.shields.io/badge/quay--image-cbgeo--lem-ff69b4.svg)](https://quay.io/repository/cbgeo/lem)
[![Docker hub](https://img.shields.io/badge/docker--hub-cbgeo--lem-ff69b4.svg)](https://hub.docker.com/r/cbgeo/lem)
[![Build status](https://api.travis-ci.org/cb-geo/docker-lem.svg)](https://travis-ci.org/cb-geo/docker-lem)
[![](https://images.microbadger.com/badges/image/cbgeo/lem.svg)](http://microbadger.com/images/cbgeo/lem)

## Tools
* Clang
* CMake
* Eigen3
* GCC 6
* Vim
* Voro++

# Using the docker image
* The docker image can be used directly from Quay.io or Docker Hub
* Pull the docker image `docker pull quay.io/cbgeo/lem` or `docker pull cbgeo/lem` 
* To launch the `cbgeo/ca-abm`  docker container, run `docker run -ti cbgeo/lem:latest /bin/bash` or `docker run -ti quay.io/cbgeo/lem:latest /bin/bash`

# To login as root
* Launching docker as root user: `docker exec -u 0 -ti <containerid> /bin/bash`

# Creating an image from the docker file
* To build an image from docker file run as root `docker build -t "cbgeo/lem" /path/to/Dockerfile`
* `docker history` will show you the effect of each command has on the overall size of the file.
